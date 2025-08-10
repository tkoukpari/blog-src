include Composition_infix
module Json = Formatting_lib.Json
module Markdown = Formatting_lib.Markdown

let write_endline string ~filename =
  string
  |> Shexp_process.echo ~where:Stdout ~n:()
  |> Shexp_process.outputs_to filename
