open Core

type t = Date.t [@@deriving sexp]

let t_of_yojson json =
  json |> Ppx_yojson_conv_lib.Yojson_conv.string_of_yojson |> Date.of_string

let yojson_of_t t =
  t |> Date.to_string |> Ppx_yojson_conv_lib.Yojson_conv.yojson_of_string
