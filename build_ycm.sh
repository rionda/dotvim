#! /bin/sh
UNAME=`uname`
if [ ${UNAME} = "FreeBSD" ]; then
    cd pack/matteo/start/YouCompleteMe && \
    env LD_LIBRARY_PATH=/usr/local/llvm10/lib python3.8 ./install.py \
    --clang-tidy --clang-completer --system-libclang --system-boost
elif [ ${UNAME} = "Darwin" ]; then
    CLANG_DYLIB=/opt/local/libexec/llvm-9.0/lib/libclang.dylib
    LLVM_DYLIB=/opt/local/libexec/llvm-9.0/lib/libLLVM.dylib
    LLVM_ROOT=/opt/local/libexec/llvm-9.0/
    PYTHON_DYLIB=/opt/local/Library/Frameworks/Python.framework/Versions/3.8/lib/libpython3.8.dylib
    PYTHON_INCLUDE=/opt/local/Library/Frameworks/Python.framework/Versions/3.8/Headers
    if [ ! -f ${CLANG_DYLIB} ]; then
        echo "ERROR:" ${CLANG_DYLIB} " not found: update CLANG_DYLIB variable."
        exit 1
    fi
    if [ ! -f ${LLVM_DYLIB} ]; then
        echo "ERROR:" ${LLVM_DYLIB} " not found: update LLVM_DYLIB variable."
        exit 1
    fi
    if [ ! -f ${PYTHON_DYLIB} ]; then
        echo "ERROR:" ${PYTHON_DYLIB} " not found: update PYTHON_DYLIB variable."
        exit 1
    fi
    if [ ! -d ${PYTHON_INCLUDE} ]; then
        echo "ERROR:" ${PYTHON_INCLUDE} " not found: update PYTHON_INCLUDE variable."
        exit 1
    fi
    if [ -d ycm_build ]; then
    rm -rf ycm_build
    fi
    mkdir ycm_build && \
    cd ycm_build && \
    cmake -G "Unix Makefiles" -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DUSE_CLANG_COMPLETER=On -DUSE_CLANG_TIDY=On -DEXTERNAL_LIBCLANG_PATH=${CLANG_DYLIB} -DPATH_TO_LLVM_ROOT=${LLVM_ROOT} -DPYTHON_LIBRARY=${PYTHON_DYLIB} -DPYTHON_INCLUDE_DIR=${PYTHON_INCLUDE} . ~/.vim/pack/matteo/start/YouCompleteMe/third_party/ycmd/cpp && \
    cmake --build . --target ycm_core && \
    cd .. && \
    rm -rf ycm_build && \
    cp "${LLVM_DYLIB}" pack/matteo/start/YouCompleteMe/third_party/ycmd/third_party/clang/lib/ && \
    orig=$PWD && \
    cd pack/matteo/start/YouCompleteMe/third_party/ycmd/third_party/watchdog_deps/watchdog && \
    rm -rf build/3 && \
    python setup.py build --build-base=build/3 --build-lib=build/lib3 && \
    cd "${orig}" && \
    mkdir regex_build && \
    cd regex_build && \
    cmake -G "Unix Makefiles" -DCMAKE_C_COMPILER=clang . ~/.vim/pack/matteo/start/YouCompleteMe/third_party/ycmd/third_party/cregex && \
    cmake --build . --target _regex
    cd .. && \
    rm -rf regex_build
elif [ ${UNAME} = "Linux" ]; then
    cd pack/matteo/start/YouCompleteMe && \
    python3 ./install.py --clang-completer --clang-tidy
else
    echo "Fix $0 to build on you OS." >&2
    exit 1
fi
