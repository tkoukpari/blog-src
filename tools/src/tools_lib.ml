open! Core
open! Import
module Syndication = Syndication

let load_site_config site_config_path =
  let open Shexp_process in
  let open Shexp_process.Let_syntax in
  let%map site_config_json = stdin_from site_config_path read_all in
  [%of_yojson: Syndication.Site_config.t]
    (Yojson.Safe.from_string site_config_json)

let generate_posts_for_syndication ~input_dir ~output_dir
    ({ base_url; _ } as site_config : Syndication.Site_config.t) =
  let open Shexp_process.Let_syntax in
  let%bind posts =
    Post.load_all ~dir:input_dir
    >>| List.map ~f:(Syndication.Post.create ~base_url)
  in
  let%bind () =
    Syndication.create_rss_feed site_config posts
    |> write_endline ~filename:(Filename.concat output_dir "rss.xml")
  in
  Syndication.create_atom_feed site_config posts
  |> write_endline ~filename:(Filename.concat output_dir "atom.xml")

let syndication_feeds =
  Command.basic ~summary:"Generate syndication feeds"
  @@
  let%map_open.Command input_dir = Param.input_dir
  and output_dir = Param.output_dir
  and site_config =
    flag "site-config"
      (required Filename_unix.arg_type)
      ~doc:"PATH Path to site config file"
  in
  fun () ->
    let open Shexp_process in
    let open Shexp_process.Let_syntax in
    load_site_config site_config
    >>= generate_posts_for_syndication ~input_dir ~output_dir
    |> eval

let build_post =
  Command.basic ~summary:"Build a post"
  @@
  let%map_open.Command input_file = Param.input_file
  and output_file = Param.output_file
  and git_revision = Param.git_revision
  and template_file = Param.template_file in
  fun () ->
    let open Shexp_process in
    eval
    @@ run "pandoc"
         [
           input_file;
           "--output";
           output_file;
           "--template";
           template_file;
           "--variable";
           [%string "rev:%{git_revision}"];
           "--to=html5";
         ]

let post_generation_rule slug ~self_path ~template_file ~git_revision_file =
  let git_revision_variable = "%{read-lines:" ^ git_revision_file ^ "}" in
  let template_dir = Filename.dirname template_file in
  [%string
    {|(rule
 (deps %{self_path} (glob_files %{template_dir}/*.html) ../../src/%{slug}.md %{git_revision_file})
 (targets %{slug}.html)
 (action
  (run
    %{self_path}
    build-post
    ../../src/%{slug}.md
    %{slug}.html
    -git-revision "%{git_revision_variable}"
    -template %{template_file}
    )))|}]

let print_dune_rules =
  Command.basic ~summary:"Print out dune rules"
  @@
  let%map_open.Command input_dir = Param.input_dir
  and template_file = Param.template_file
  and git_revision_file = Param.git_revision_file
  and kind =
    flag "kind"
      (optional_with_default `Index
         (Arg_type.enumerated
            (module struct
              type t = [ `Index | `Category | `Tag ]
              [@@deriving enumerate, sexp]

              let to_string = String.lowercase << Sexp.to_string << sexp_of_t
            end)))
      ~doc:"Kind of rule to print"
  in
  fun () ->
    let open Shexp_process in
    let open Shexp_process.Let_syntax in
    eval
    @@
    let self_path =
      (* [Command.Param.args] exists, but the directory seems to be stripped
         there, so we get argv directly. *)
      (Sys.get_argv ()).(0)
    in
    match kind with
    | `Index ->
        let%bind slugs =
          Path_and_slug.readdir ~dir:input_dir
          >>| Core.List.map ~f:Path_and_slug.slug
        in
        let post_generation_rules =
          Core.List.map slugs
            ~f:
              (post_generation_rule ~self_path ~template_file ~git_revision_file)
          |> String.concat ~sep:"\n"
        in
        let output_files =
          Core.List.map slugs ~f:(fun file -> [%string "%{file}.html"])
        in
        echo
          [%string
            {|; post generation rules
%{post_generation_rules}

; aggregation alias
(alias
  (name default)
  (deps %{String.concat ~sep:" " output_files}))
  |}]
    | `Category ->
        let%bind metadata = Metadata.load_all ~dir:input_dir in
        let all_categories =
          Core.List.filter_map metadata ~f:Metadata.category
          |> Core.List.dedup_and_sort ~compare:String.compare
        in
        let index_generation_rules =
          Core.List.map all_categories ~f:(fun category ->
              Index.index_generation_rule ~self_path ~input_dir ~template_file
                ~git_revision_file (Category category))
          |> String.concat ~sep:"\n"
        in
        let output_files =
          Core.List.map all_categories ~f:(fun category ->
              [%string "%{category}.html"])
        in
        echo
          [%string
            {|; category index generation rules
%{index_generation_rules}

; aggregation alias
(alias
  (name default)
  (deps %{String.concat ~sep:" " output_files}))
  |}]
    | `Tag ->
        let%bind metadata = Metadata.load_all ~dir:input_dir in
        let all_tags =
          Core.List.concat_map metadata ~f:Metadata.tags
          |> Core.List.dedup_and_sort ~compare:String.compare
        in
        let index_generation_rules =
          Core.List.map all_tags ~f:(fun tag ->
              Index.index_generation_rule ~self_path ~input_dir ~template_file
                ~git_revision_file (Tag tag))
          |> String.concat ~sep:"\n"
        in
        let output_files =
          Core.List.map all_tags ~f:(fun tag -> [%string "%{tag}.html"])
        in
        echo
          [%string
            {|; tag index generation rules
%{index_generation_rules}

; aggregation alias
(alias
  (name default)
  (deps %{String.concat ~sep:" " output_files}))
  |}]

let command =
  Command.group ~summary:"Tools for generating blog"
    [
      ("syndication-feeds", syndication_feeds);
      ("print-dune-rules", print_dune_rules);
      ("build-post", build_post);
      ("build-index", Index.build);
    ]
