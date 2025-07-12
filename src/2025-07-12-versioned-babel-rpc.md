---
title: versioned babel rpc
date: 2025-07-12
category: tech
tags:
- ocaml
- rpc-infrastructure
uuid: 677dabd5-8e1e-4b0a-b6bd-99821e73ffb7
---

I'm going to write a series on rpc infrastructure: how to set up an ecosystem of
servers, have them talk to each other, and have them interact with the outside
world.

everything will be written in ocaml. I'll assume knowledge of the code in
[rpc-infrastructure](https://github.com/tkoukpari/rpc-infrastructure)

under the server-client-rpc directory, there are three libraries and an
executable. the libraries are split across server, client, and protocol.

the rpc is implemented with [babel](https://github.com/janestreet/babel) but
should otherwise be straightforward to follow (two versions of a simple query
and a unit response).

blogs in this series will be tagged with rpc-infrastructure.