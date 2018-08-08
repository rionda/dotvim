#!/bin/sh
git pull && \
git submodule sync && \
git submodule update --init --remote --merge && \
git submodule sync --recursive && \
git commit --no-gpg-sign bundle -m "Sync submodules." && \
git submodule update --init --merge --recursive && \
git push

./build_command_t.sh
./build_ycm.sh
