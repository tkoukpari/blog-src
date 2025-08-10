open! Core

module Date = struct
  open Ppx_yojson_conv_lib

  type t = Date.t

  let t_of_yojson json = json |> Yojson_conv.string_of_yojson |> Date.of_string
  let yojson_of_t t = t |> Date.to_string |> Yojson_conv.yojson_of_string
end

type t =
  [ `Null
  | `Bool of bool
  | `Int of int
  | `Intlit of string
  | `Float of float
  | `String of string
  | `Assoc of (string * t) list
  | `List of t list
  | `Tuple of t list
  | `Variant of string * t option ]
[@@deriving sexp_of]
