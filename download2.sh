#!/usr/bin/env bash

curl http://statcounter.com/js/packed/global-c72de6291c.js | awk '/^var d1=/' | tr '$' '\n' |\
  gsed '1 s/var d1="//
$ s/";//
s/ /_/5g
s/ /|/g
s/_/ /g ' |\
  cut -d '|' -f 2,5

