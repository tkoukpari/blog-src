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
 (deps ../../tools/bin/tools.exe (glob_files ../../templates/*.html) ../../src/2025-07-19-rpcs.md ../git-revision)
 (targets 2025-07-19-rpcs.html)
 (action
  (run
    ../../tools/bin/tools.exe
    build-post
    ../../src/2025-07-19-rpcs.md
    2025-07-19-rpcs.html
    -git-revision "%{read-lines:../git-revision}"
    -template ../../templates/post.html
    )))
(rule
 (deps ../../tools/bin/tools.exe (glob_files ../../templates/*.html) ../../src/2025-07-26-hosting-servers-on-linode.md ../git-revision)
 (targets 2025-07-26-hosting-servers-on-linode.html)
 (action
  (run
    ../../tools/bin/tools.exe
    build-post
    ../../src/2025-07-26-hosting-servers-on-linode.md
    2025-07-26-hosting-servers-on-linode.html
    -git-revision "%{read-lines:../git-revision}"
    -template ../../templates/post.html
    )))
(rule
 (deps ../../tools/bin/tools.exe (glob_files ../../templates/*.html) ../../src/2025-07-28-non-recursive-recursive-values.md ../git-revision)
 (targets 2025-07-28-non-recursive-recursive-values.html)
 (action
  (run
    ../../tools/bin/tools.exe
    build-post
    ../../src/2025-07-28-non-recursive-recursive-values.md
    2025-07-28-non-recursive-recursive-values.html
    -git-revision "%{read-lines:../git-revision}"
    -template ../../templates/post.html
    )))
(rule
 (deps ../../tools/bin/tools.exe (glob_files ../../templates/*.html) ../../src/2025-08-09-open-source.md ../git-revision)
 (targets 2025-08-09-open-source.html)
 (action
  (run
    ../../tools/bin/tools.exe
    build-post
    ../../src/2025-08-09-open-source.md
    2025-08-09-open-source.html
    -git-revision "%{read-lines:../git-revision}"
    -template ../../templates/post.html
    )))
(rule
 (deps ../../tools/bin/tools.exe (glob_files ../../templates/*.html) ../../src/2025-08-17-counterfactual.md ../git-revision)
 (targets 2025-08-17-counterfactual.html)
 (action
  (run
    ../../tools/bin/tools.exe
    build-post
    ../../src/2025-08-17-counterfactual.md
    2025-08-17-counterfactual.html
    -git-revision "%{read-lines:../git-revision}"
    -template ../../templates/post.html
    )))
(rule
 (deps ../../tools/bin/tools.exe (glob_files ../../templates/*.html) ../../src/2025-08-26-firewalls.md ../git-revision)
 (targets 2025-08-26-firewalls.html)
 (action
  (run
    ../../tools/bin/tools.exe
    build-post
    ../../src/2025-08-26-firewalls.md
    2025-08-26-firewalls.html
    -git-revision "%{read-lines:../git-revision}"
    -template ../../templates/post.html
    )))

; aggregation alias
(alias
  (name default)
  (deps 2025-05-31-blog-1.html 2025-06-01-python-lists.html 2025-06-06-calling-ocaml-from-c-from-swift.html 2025-06-21-politicking.html 2025-06-22-fool-me-twice.html 2025-07-19-rpcs.html 2025-07-26-hosting-servers-on-linode.html 2025-07-28-non-recursive-recursive-values.html 2025-08-09-open-source.html 2025-08-17-counterfactual.html 2025-08-26-firewalls.html))
  
