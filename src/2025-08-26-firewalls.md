---
title: firewalls
series: rpcs
date: 2025-08-26
category: tech
tags:
- ocaml
uuid: f8328097-be68-4210-91a5-dce10f6b5214
---

I left a comment on the last post in this series about how _the same private network_ was an overestimate.

to make the servers in the vpc actually private you need to setup a firewall (which you can do under the networking tab)

the default should be to drop all requests. otherwise you should have two inbound rules:

- TCP protocol on port 22, accepting all IPv4 and IPv6 sources
- TCP protocol on port 8080 (or wherever you are hosting your rpc), accepting all VPC IPv4 sources (e.g. 10.0.0.1/32... 10.0.0.n/32)

the first rule allows ssh-ing from your personal machine; the second allows intra-VPC connections. all rpc requests from the outside world are dropped