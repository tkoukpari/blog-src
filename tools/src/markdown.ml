open! Core
open! Import
open Shexp_process
open Shexp_process.Let_syntax

type t = { f : Filename.t -> string Shexp_process.t }

let evaluate_template input_file ~template =
  with_temp_file ~prefix:"" ~suffix:".template" (fun template_file ->
      let%bind () = write_endline template ~filename:template_file in
      run "pandoc" [ input_file; "--template"; template_file ])
  |- read_all

let json = { f = evaluate_template ~template:"$meta-json$" }
let html = { f = evaluate_template ~template:"$body$" }
