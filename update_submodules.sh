#!/bin/sh
git pull && \
git submodule sync && \
git submodule update --init --remote --merge && \
git commit --no-gpg-sign bundle -m "Sync submodules." && \
git push && \
git submodule sync --recursive && \
git submodule update --init --recursive # --merge 

./build_command_t.sh
./build_ycm.sh
