open! Core
open! Import

type t =
  | All
  | Category of string
  | Tag of string

val index_generation_rule
  :  t
  -> self_path:string
  -> input_dir:string
  -> template_file:string
  -> git_revision_file:string
  -> string

val build : Command.t
