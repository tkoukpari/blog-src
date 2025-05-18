open! Core
open! Import

type t = private
  { metadata : Metadata.t
  ; content_html : string
  }

val load_all : dir:string -> t list Shexp_process.t
