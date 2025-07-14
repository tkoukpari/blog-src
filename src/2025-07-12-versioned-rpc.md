---
title: versioned rpc
date: 2025-07-12
category: tech
tags:
- ocaml
- rpc-infrastructure
uuid: 677dabd5-8e1e-4b0a-b6bd-99821e73ffb7
---

I'm going to write a series on ocaml rpc infrastructure: how to set up an
ecosystem of servers, have them talk to each other via rpc, and have them
interact with the outside world.

I'll assume knowledge of the code in
[rpc-infrastructure](https://github.com/tkoukpari/rpc-infrastructure).  there
are three relevant libraries under the server-client-rpc directory. the
libraries are split across server, client, and protocol to avoid a build
dependency between server and client.

the rpc is implemented with [babel](https://github.com/janestreet/babel), but is
otherwise easy to follow (two versions of an `int` query and a `unit` response).

blogs in this series will be tagged with rpc-infrastructure.