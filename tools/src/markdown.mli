open! Core

type t = { f : Filename.t -> string Shexp_process.t }

val json : t
val html : t
