open! Core

module Date : sig
  type t = Date.t [@@deriving  yojson]
end

type t = Yojson.Safe.t [@@deriving sexp_of]
