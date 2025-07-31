---
title: calling ocaml from c from swift
series: object magic
date: 2025-06-06
category: tech
tags:
- dune
- ocaml
- swift
uuid: a079e94a-23db-48c0-8162-e924bd9a851e 
---

now that we can
[call ocaml from c](https://mt-caret.github.io/blog/posts/2025-02-02-calling-ocaml-from-c-in-dune.html),
let's try calling ocaml from c from swift so we can make ocaml iphone apps.

here's the ocaml code we'll want to run:

```ocaml
let fib =
  let rec f n = if n < 2 then 1 else f (n - 1) + f (n - 2) in
  print_endline "ocaml invoked by c";
  f

let _ = Callback.register "fib" fib
```

the closure needs to be registered with the c runtime[^callback]

[^callback]:
  [caml.org/manual/5.3/api/Callback.html](https://ocaml.org/manual/5.3/api/Callback.html)

there isn't any overhead to making swift aware of the c code, but c needs to
initialize the ocaml runtime and set a pointer to the ocaml closure[^intfc]

```c
static void init_ocaml(void) __attribute__((constructor));
static void init_ocaml(void) {
    char *argv[] = {"main", NULL};
    caml_startup(argv);
    fib_closure = caml_named_value("fib");
}

int fib(int n) {
    printf("c invoked by swift\n");
    return Int_val(caml_callback(*fib_closure, Val_int(n)));
}
```

[^intfc]:
  [ocaml.org/manual/5.3/intfc.html](https://ocaml.org/manual/5.3/intfc.html)
  
and finally the swift code that calls into c:

```swift
@_silgen_name("fib") func fib(_ n: Int32) -> Int32

let n = Int32(CommandLine.arguments[1])!
let res = fib(n)
print("swift printing the fibonacci number for \(n): \(res)")
```

dune compiles the ocaml code into a static library, compiles the c object file,
and links everything with swiftc:

```bash
(executables
 (names mod)
 (modes object))

(rule
 (targets libocaml.a)
 (deps mod.exe.o)
 (action
  (run ar rcs %{targets} %{deps})))

(rule
 (targets main.o)
 (deps main.c)
 (action
  (run clang -c -I %{ocaml_where} main.c -o main.o)))

(rule
 (targets main)
 (deps main.swift main.o)
 (action
  (run
   swiftc
   main.swift
   main.o
   -o
   main
   -L
   %{ocaml_where}
   -L
   .
   -locaml
   -lcamlrun)))
```

and voila! time to get schwifty 

```bash
$ dune build
$ dune exe ./main 10
c invoked by swift               
ocaml invoked by c
swift printing the fibonacci number for 10: 89
```

the full code is available in the
[calling-ocaml-from-c-from-swift](https://github.com/tkoukpari/calling-ocaml-from-c-from-swift)
repository