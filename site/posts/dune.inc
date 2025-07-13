; post generation rules
(rule
 (deps ../../tools/bin/tools.exe (glob_files ../../templates/*.html) ../../src/2025-05-31-blog-1.md ../git-revision)
 (targets 2025-05-31-blog-1.html)
 (action
  (run
    ../../tools/bin/tools.exe
    build-post
    ../../src/2025-05-31-blog-1.md
    2025-05-31-blog-1.html
    -git-revision "%{read-lines:../git-revision}"
    -template ../../templates/post.html
    )))
(rule
 (deps ../../tools/bin/tools.exe (glob_files ../../templates/*.html) ../../src/2025-06-01-python-lists.md ../git-revision)
 (targets 2025-06-01-python-lists.html)
 (action
  (run
    ../../tools/bin/tools.exe
    build-post
    ../../src/2025-06-01-python-lists.md
    2025-06-01-python-lists.html
    -git-revision "%{read-lines:../git-revision}"
    -template ../../templates/post.html
    )))
(rule
 (deps ../../tools/bin/tools.exe (glob_files ../../templates/*.html) ../../src/2025-06-06-calling-ocaml-from-c-from-swift.md ../git-revision)
 (targets 2025-06-06-calling-ocaml-from-c-from-swift.html)
 (action
  (run
    ../../tools/bin/tools.exe
    build-post
    ../../src/2025-06-06-calling-ocaml-from-c-from-swift.md
    2025-06-06-calling-ocaml-from-c-from-swift.html
    -git-revision "%{read-lines:../git-revision}"
    -template ../../templates/post.html
    )))
(rule
 (deps ../../tools/bin/tools.exe (glob_files ../../templates/*.html) ../../src/2025-06-21-politicking.md ../git-revision)
 (targets 2025-06-21-politicking.html)
 (action
  (run
    ../../tools/bin/tools.exe
    build-post
    ../../src/2025-06-21-politicking.md
    2025-06-21-politicking.html
    -git-revision "%{read-lines:../git-revision}"
    -template ../../templates/post.html
    )))
(rule
 (deps ../../tools/bin/tools.exe (glob_files ../../templates/*.html) ../../src/2025-06-22-fool-me-twice.md ../git-revision)
 (targets 2025-06-22-fool-me-twice.html)
 (action
  (run
    ../../tools/bin/tools.exe
    build-post
    ../../src/2025-06-22-fool-me-twice.md
    2025-06-22-fool-me-twice.html
    -git-revision "%{read-lines:../git-revision}"
    -template ../../templates/post.html
    )))
(rule
 (deps ../../tools/bin/tools.exe (glob_files ../../templates/*.html) ../../src/2025-07-12-versioned-rpc.md ../git-revision)
 (targets 2025-07-12-versioned-rpc.html)
 (action
  (run
    ../../tools/bin/tools.exe
    build-post
    ../../src/2025-07-12-versioned-rpc.md
    2025-07-12-versioned-rpc.html
    -git-revision "%{read-lines:../git-revision}"
    -template ../../templates/post.html
    )))

; aggregation alias
(alias
  (name default)
  (deps 2025-05-31-blog-1.html 2025-06-01-python-lists.html 2025-06-06-calling-ocaml-from-c-from-swift.html 2025-06-21-politicking.html 2025-06-22-fool-me-twice.html 2025-07-12-versioned-rpc.html))
  
