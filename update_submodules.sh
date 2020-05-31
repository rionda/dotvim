#!/bin/sh
echo "## Pulling from remote" && \
git pull && \
echo "## Syncing submodules " &&  \
git submodule sync && \
echo "## Updating/Initing and merging submodules from their remote" &&  \
git submodule update --init --remote --merge && \
echo "## Committing update " &&  \
git commit --no-gpg-sign bundle -m "Sync submodules." && \
echo "## Pushing " &&  \
git push && \
echo "## Syncing submodules recursively" &&  \
git submodule sync --recursive && \
echo "## Updating submodules recursively" &&  \
git submodule update --init --recursive && \
echo "## Building command-t" &&  \
./build_command_t.sh && \
echo "## Building YCM" &&  \
./build_ycm.sh
