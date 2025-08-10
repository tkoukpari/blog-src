open! Core
open! Import

type t = All | Category of string | Tag of string

let param =
  let%map_open.Command category =
    flag "category" (optional string) ~doc:"Generate index for category"
  and tag = flag "tag" (optional string) ~doc:"Generate index for tag" in
  match (category, tag) with
  | Some category, Some tag ->
      raise_s [%message "Cannot specify both category and tag" category tag]
  | Some category, None -> Category category
  | None, Some tag -> Tag tag
  | None, None -> All

let filter t (metadata : Metadata.t) =
  match t with
  | All -> true
  | Category category -> (
      match metadata.category with
      | None -> false
      | Some metadata_category -> String.equal metadata_category category)
  | Tag tag -> List.mem metadata.tags tag ~equal:String.equal

let title = function
  | All -> "variable length"
  | Category category -> [%string "'category: %{category}'"]
  | Tag tag -> [%string "'tag: %{tag}'"]

let index_generation_rule t ~self_path ~input_dir ~template_file
    ~git_revision_file =
  let git_revision_variable = "%{read-lines:" ^ git_revision_file ^ "}" in
  let template_dir = Filename.dirname template_file in
  let flag, field =
    match t with
    | All -> failwith "not supported"
    | Category category -> ("category", category)
    | Tag tag -> ("tag", tag)
  in
  [%string
    {|
(rule
 (deps %{self_path} (source_tree %{input_dir}) (glob_files %{template_dir}/*.html) %{git_revision_file})
 (action
  (with-stdout-to
   %{field}.html
   (run
    %{self_path}
    build-index
    %{input_dir}
    -%{flag} %{field}
    -git-revision "%{git_revision_variable}"
    -template %{template_file}
    -root-dir ..
    ))))|}]

(* TODO: It's confusing that there's Metadata.t and Post_metadata.t; fix this. *)
module Series = struct
  open Ppx_yojson_conv_lib.Yojson_conv

  module Post = struct
    type t = {
      date : Json.Date.t;
      title : string;
      href : string;
      root_dir : string;
    }
    [@@deriving yojson_of]

    let of_metadata (metadata : Metadata.t) ~root_dir =
      {
        date = metadata.date;
        title = metadata.title;
        href =
          Filename.concat root_dir
            (Filename.concat "posts/" (metadata.slug ^ ".html"));
        root_dir;
      }
  end

  type t = { title : string option; mutable posts : Post.t list }
  [@@deriving yojson_of]
end

let build =
  Command.basic ~summary:"Build index.html"
  @@
  let%map_open.Command input_dir = Param.input_dir
  and git_revision = Param.git_revision
  and template_file = Param.template_file
  and t = param
  and root_dir =
    flag "root-dir"
      (optional_with_default "." string)
      ~doc:"DIR root dir relative to output dir"
  in
  fun () ->
    let open Shexp_process in
    let open Shexp_process.Infix in
    eval
    @@
    let%bind.Shexp_process post_metadata =
      Metadata.load_all ~dir:input_dir >>| Core.List.filter ~f:(filter t)
    in
    let series_index = Hashtbl.create (module String) in
    let series =
      Core.List.fold post_metadata ~init:[||] ~f:(fun acc metadata ->
          let post = Series.Post.of_metadata metadata ~root_dir in
          let fresh title = [| { Series.title; posts = [ post ] } |] in
          match metadata.series with
          | Some title -> (
              match Hashtbl.find series_index title with
              | None ->
                  Hashtbl.add_exn series_index ~key:title
                    ~data:(Array.length acc);
                  Array.append acc (fresh (Some title))
              | Some index ->
                  let series = Array.get acc index in
                  series.posts <- post :: series.posts;
                  acc)
          | None -> (
              if Array.is_empty acc then Array.append acc (fresh None)
              else
                let series = Array.get acc (Array.length acc - 1) in
                match series.title with
                | None ->
                    series.posts <- post :: series.posts;
                    acc
                | Some _ -> Array.append acc (fresh None)))
      |> Array.to_list |> Core.List.rev
      |> Ppx_yojson_conv_lib.Yojson_conv.([%yojson_of: Series.t list])
      |> Yojson.Safe.to_string
    in
    let title = title t in
    let config =
      match t with
      | All ->
          let include_before =
            "a mostly technical collection of writings, of variable length, \
             sometimes partitioned into series"
          in
          [%string
            {|---
title: %{title}
include-before: %{include_before}
series: %{series}
root_dir: %{root_dir}
show_index_link: %{not (String.equal root_dir ".")#Bool}
---|}]
      | _ ->
          [%string
            {|---
title: %{title}
series: %{series}
root_dir: %{root_dir}
show_index_link: %{not (String.equal root_dir ".")#Bool}
---|}]
    in
    echo config
    |- run "pandoc"
         [
           "--template";
           template_file;
           "--variable";
           [%string "rev:%{git_revision}"];
           "--to=html5";
         ]
