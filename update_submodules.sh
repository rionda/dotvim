#!/bin/sh

function getYCMcommit() {
    if [ -d pack/matteo/start/YouCompleteMe ]; then
        here=$PWD
        cd pack/matteo/start/YouCompleteMe && \
        git show -q --oneline | cut -d" " -f 1 && \
        cd "${here}"
    else
        echo 0
    fi
}

oldycmcmt=`getYCMcommit`
(echo "## Pulling from remote" && git pull) || return 1
(echo "## Syncing submodules " && git submodule sync) || return 1
(echo "## Updating/Initing and merging submodules from their remote" &&  \
    git submodule update --init --remote --merge) || return 1
(echo "## Committing update " && \
git commit --no-gpg-sign pack/matteo/ -m "Sync submodules.") || \
    return 1
(echo "## Pushing " && git push) || return 1
(echo "## Syncing submodules recursively" &&  \
    git submodule sync --recursive)
(echo "## Updating submodules recursively" &&  \
    git submodule update --init --recursive) || return 1
newycmct=`getYCMcommit`
if [ $oldycmcmt != $newycmct ]; then
    (echo "## Building YCM" && ./build_ycm.sh) || return 1
fi
