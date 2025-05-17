; post generation rules
(rule
 (deps ../../tools/bin/tools.exe (glob_files ../../templates/*.html) ../../src/2025-02-02-calling-ocaml-from-c-in-dune.md ../git-revision)
 (targets 2025-02-02-calling-ocaml-from-c-in-dune.html)
 (action
  (run
    ../../tools/bin/tools.exe
    build-post
    ../../src/2025-02-02-calling-ocaml-from-c-in-dune.md
    2025-02-02-calling-ocaml-from-c-in-dune.html
    -git-revision "%{read-lines:../git-revision}"
    -template ../../templates/post.html
    )))

; aggregation alias
(alias
  (name default)
  (deps 2025-02-02-calling-ocaml-from-c-in-dune.html))
  
