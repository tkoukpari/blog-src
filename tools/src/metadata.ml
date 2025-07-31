open! Core
open! Import
open Shexp_process.Let_syntax

module From_frontmatter = struct
  open Ppx_yojson_conv_lib.Yojson_conv

  type t = {
    date : Json.Date.t;
    update_date : Json.Date.t option; [@default None]
    title : string;
    series : string option; [@default None]
    category : string option; [@default None]
    tags : string list; [@default []]
    uuid : string;
  }
  [@@deriving of_yojson] [@@yojson.allow_extra_fields]

  let of_json_str s =
    let json = Yojson.Safe.from_string s in
    match [%of_yojson: t] json with
    | x -> x
    | exception exn ->
        raise_s
          [%message
            "Unexpected error while parsing metadata"
              (exn : exn)
              (json : Json.t)]

  let load filename = filename |> Markdown.json.f >>| of_json_str
end

type t = {
  date : Date.t;
  update_date : Date.t option;
  title : string;
  series : string option;
  category : string option;
  tags : string list;
  uuid : string;
  slug : string;
}
[@@deriving sexp_of, fields ~getters]

let create
    ({ date; update_date; title; series; category; tags; uuid } :
      From_frontmatter.t) ~slug =
  { date; update_date; title; series; category; tags; uuid; slug }

let load filename ~slug = From_frontmatter.load filename >>| create ~slug

let load_all ~dir =
  Path_and_slug.readdir ~dir
  >>| List.map ~f:(fun ({ path; slug } : Path_and_slug.t) -> load path ~slug)
  >>= Shexp_process.fork_all
  >>| List.sort ~compare:(Comparable.lift [%compare: Date.t] ~f:date)
