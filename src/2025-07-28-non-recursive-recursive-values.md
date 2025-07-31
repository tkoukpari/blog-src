---
title: non-recursive recursive values
series: object magic
date: 2025-07-28
category: tech
tags:
- ocaml
uuid: 27014239-95b6-4d71-a556-e93b321404d3
---

today, one of my work colleagues showed me how to recurse in ocaml without
recursing.[^crediting-work] the usual disclaimer about basic knowledge of
ocaml types applies.

[^crediting-work]: M if you stumble upon this, claim credit

consider the type:

```ocaml
type 'a t = { f : 'a t -> 'a }
```

you can create an `f` by applying a `t.f` to itself:

```ocaml
let extract ({ f } as t) = f t

val extract : 'a t -> 'a
```

now just wrap `extract` back into a `t` and apply it to itself:

```ocaml
let recurse_forever = extract { f = extract }

val recurse_forever : 'a 
```

and you've created a diverging program without `rec`