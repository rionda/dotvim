#!/bin/sh
git submodule sync --recursive
git submodule update --init --recursive # --remote --merge
git submodule update --init --remote --merge
git commit -a -m "Sync submodules."
git push

./build_command_t.sh
./build_ycm.sh
