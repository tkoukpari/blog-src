open! Core
open! Import
open Shexp_process.Let_syntax

type t = { metadata : Metadata.t; content_html : string }
[@@deriving fields ~getters]

let load filename ~slug =
  let%map metadata = Metadata.load filename ~slug
  and content_html = Markdown.html.f filename in
  { metadata; content_html }

let load_all ~dir =
  Path_and_slug.readdir ~dir
  >>| List.map ~f:(fun ({ path; slug } : Path_and_slug.t) -> load path ~slug)
  >>= Shexp_process.fork_all
  >>| List.sort
        ~compare:(Comparable.lift Date.compare ~f:(Metadata.date << metadata))
