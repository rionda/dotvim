#!/bin/sh
git submodule update --init --remote --merge && \
git commit bundle -m "Sync submodules." && \
git submodule sync --recursive && \
git submodule update --init --recursive && \ # --remote --merge
git push

./build_command_t.sh
./build_ycm.sh
