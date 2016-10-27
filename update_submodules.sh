#!/bin/sh
git submodule update --remote --merge
git submodule foreach --recursive git submodule update --init --recursive
git commit -a -m "Sync submodules."
git push
