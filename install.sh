#! /bin/sh

git submodule update --init --merge --recursive && \
    ln -s "${PWD}/dot.vimrc" ~/.vimrc && \
    mkdir -p ~/.vim/swapfiles && \
    ln -s "${PWD}/pack" ~/.vim/pack && \
    ln -s "${PWD}/after" ~/.vim/after
