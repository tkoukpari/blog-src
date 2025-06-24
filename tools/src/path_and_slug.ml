open! Core
open! Import
open Shexp_process.Let_syntax

type t = { path : Filename.t; slug : string }
[@@deriving compare, fields ~getters]

let readdir ~dir =
  Shexp_process.readdir dir
  >>| List.filter_map ~f:(fun filename ->
          filename
          |> String.chop_suffix ~suffix:".md"
          |> Option.map ~f:(fun slug ->
                 { path = Filename.concat dir filename; slug }))
  >>| List.sort ~compare
