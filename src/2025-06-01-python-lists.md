---
title: python lists
series: object magic
date: 2025-06-01
category: tech
tags:
- ocaml
- python
uuid: f0970c25-c8d2-48a8-9be8-e11b218a1844 
---

before anything I'm going to familiarize myself with writing markdown. here's a
blog about how to make python lists in ocaml. I assume basic knowledge of ocaml
types.

in ocaml, lists are linked lists of elements of the same type:

```ocaml
type 'a list = 
  | [] 
  | (::) of 'a * 'a list

let ints = (::) (1, (::) (2, (::) (3, [])))
```

a list can be empty, or it can have a value of type `'a` and a pointer to the
next element, which must also be a `'a list`. syntax sugar will convert `ints`
into:

```ocaml
let ints = [ 1; 2; 3 ]
```

we'll make it possible to have a list containing entirely different types using
generalized algebraic data types (gadts). normal variants are a special case of
gadt where all constructors have the same type (type `t`):

```ocaml
type t =
  | A : t
  | B : int    -> t
  | C : string -> t
```

gadts in general don't require that property:

```ocaml
type _ t =
  | A : unit t
  | B : int -> int t
  | C : string -> string t
```

### python lists using gadts

we can rewrite our list as a gadt and point each element to a list with a
possibly different element type:

```ocaml
type _ list = 
  | []   : unit list 
  | (::) : 'a * 'b list -> ('a * 'b) list

let things : (string * (int * unit)) list = (::) ("hi", (::) (1, []))
```

syntax sugar will convert `things` into:

```ocaml
let things = [ "hi"; 1 ]
```

a strongly typed python list

```python
things = [ "hi", 1 ]
```