#!/bin/sh
git submodule sync --recursive
git submodule update --recursive #--remote --merge
#%git submodule foreach --recursive git submodule update --init --recursive
git commit -a -m "Sync submodules."
git push

./build_command_t.sh
#./build_ycm.sh
