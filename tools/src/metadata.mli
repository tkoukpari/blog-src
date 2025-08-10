open! Core

type t =
  { date : Date.t
  ; update_date : Date.t option
  ; title : string
  ; series : string option
  ; category : string option
  ; tags : string list
  ; uuid : string
  ; slug : string
  }
[@@deriving fields ~getters]

val load : Filename.t -> slug:string -> t Shexp_process.t
val load_all : dir:Filename.t -> t list Shexp_process.t
