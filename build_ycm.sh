#! /bin/sh
cmake -G "Unix Makefiles" -DEXTERNAL_LIBCLANG_PATH=/opt/local/libexec/llvm-3.6/lib/libclang.dylib -DPYTHON_LIBRARY=/opt/local/Library/Frameworks/Python.framework/Versions/2.7/lib/libpython2.7.dylib -DPYTHON_INCLUDE_DIR=/opt/local/Library/Frameworks/Python.framework/Versions/2.7/Headers .  ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
