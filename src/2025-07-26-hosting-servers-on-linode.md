---
title: hosting servers on linode
series: rpcs
date: 2025-07-26
category: tech
tags:
- ocaml
uuid: 67ce1e84-5d8b-421c-ae2b-9eea16f41f75
---

first in the series is getting two different machines to communicate with
one-another on the same private network

we're going to use linode (a.k.a. akamai) because I couldn't figure out how to
open an account (or pay for an account) on a few other cloud providers

you can consider this an advertisement for linode - it was actually easy to use

### setup

once you have a linode account, set up a VPC and two linodes on the same VPC
subnet

ssh into each machine using `ssh root@IP_ADDRESS` and run the following to
download dune:

```bash
sudo apt update
apt install ocaml-dune
```

download and init opam:

```bash
sudo apt-get install opam
opam init
```

clone the [rpcs](https://github.com/tkoukpari/rpcs) repository with `git clone ... rpcs`

you can probably do all the above on a single machine, and then clone the
machine, instead of doing everything twice

### running code

on the first linode, run the rpc-server with:[^1]

```bash
cd rpcs
dune build
./_build/default/server-client-rpc/bin/main.exe server 5
```

[^1]: if you want to run the server in the background, first run `touch /tmp/ocaml-rpc-logs`
  and then append ` > /tmp/ocaml-rpc-logs 2>&1 & pid=$!` where you start the
  server. you can kill the server with `kill $pid`

`dune build` will run into `Library "X" not found` for some Xs... they should be
installed with `opam install`. make sure `async` is on v>0.17.0.

on the second linode, query the server with

```bash
cd rpcs
dune build
./_build/default/server-client-rpc/bin/main.exe client IP_ADDRESS_OF_LINODE_1 42
```

note we've changed the client implementation such that the RPC client is created
with an `Inet` address instead of a host:

```ocaml
let%bind client =
  Rpc.Connection.client
    (Tcp.Where_to_connect.of_inet_address
      (`Inet (inet_addr, 8080)))
...
```

### service discovery and other infrastructure

some things that would be useful that I didn't do:

1. have your github repository sync automatically on your linodes so you don't
need to `git pull` every time you make a change

2. set up service discovery so that you don't need to manually query with an IP
address. this might be of the form "have a perma-server with a perma-IP address
that other servers can connect to via pipe to subscribe to or advertise IP
addresses and ports"