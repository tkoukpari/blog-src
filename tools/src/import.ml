include Composition_infix

let write_endline string ~filename =
  string
  |> Shexp_process.echo ~where:Stdout ~n:()
  |> Shexp_process.outputs_to filename
