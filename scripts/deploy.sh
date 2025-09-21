#!/bin/bash

set -euo pipefail

dune clean
dune build @runtest @default

rm -rf deploy/category/*
rm -rf deploy/posts/*
rm -rf deploy/static/*
rm -rf deploy/tag/*

cp -r _build/default/site/* deploy/
rm -f deploy/dune*
rm -f deploy/static/dune*