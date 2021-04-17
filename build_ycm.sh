#! /bin/sh
UNAME=`uname`
cd pack/matteo/start/YouCompleteMe
if [ ${UNAME} = "FreeBSD" ]; then
    env LD_LIBRARY_PATH=/usr/local/llvm11/lib python3.8 ./install.py \
    --clang-tidy --clang-completer --java-completer --system-libclang --system-boost --quiet
elif [ ${UNAME} = "Darwin" ]; then
    CLANG_DYLIB=/opt/local/libexec/llvm-11/lib/libclang.dylib
    LLVM_DYLIB=/opt/local/libexec/llvm-11/lib/libLLVM.dylib
    LLVM_ROOT=/opt/local/libexec/llvm-11/
    if [ ! -f ${CLANG_DYLIB} ]; then
        echo "ERROR:" ${CLANG_DYLIB} " not found: update CLANG_DYLIB variable."
        exit 1
    fi
    if [ ! -f ${LLVM_DYLIB} ]; then
        echo "ERROR:" ${LLVM_DYLIB} " not found: update LLVM_DYLIB variable."
        exit 1
    fi
    if [ -d ycm_build ]; then
    rm -rf ycm_build
    fi
    EXTRA_CMAKE_ARGS="-DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DEXTERNAL_LIBCLANG_PATH=${CLANG_DYLIB} -DPATH_TO_LLVM_ROOT=${LLVM_ROOT}" python3 ./install.py \\
    --clang-completer --clang-tidy --java-completer --quiet
elif [ ${UNAME} = "Linux" ]; then
    python3 ./install.py \\
    --clang-completer --clang-tidy --java-completer --quiet
else
    echo "Fix $0 to build on you OS." >&2
    exit 1
fi
