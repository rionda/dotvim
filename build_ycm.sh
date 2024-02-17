#! /bin/sh
UNAME=`uname`
cd pack/matteo/start/YouCompleteMe
if [ ${UNAME} = "FreeBSD" ]; then
    LLVMLIB_PATH=/usr/local/llvm15/lib
    if [ ! -d ${LLVMLIB_PATH} ]; then
        echo "ERROR:" ${LLVMLIB_PATH} " not found: update LLVMLIB_PATH variable."
        exit 1
    fi
    env LD_LIBRARY_PATH=${LLVMLIB_PATH} python3.11 ./install.py \
    --clang-tidy --clang-completer --java-completer --system-libclang --quiet
elif [ ${UNAME} = "Darwin" ]; then
    LLVM_ROOT=/opt/local/libexec/llvm-15/
    CLANG_DYLIB=${LLVM_ROOT}lib/libclang.dylib
    LLVM_DYLIB=${LLVM_ROOT}lib/libLLVM.dylib
    if [ ! -f ${CLANG_DYLIB} ]; then
        echo "ERROR:" ${CLANG_DYLIB} " not found: update CLANG_DYLIB variable."
        exit 1
    fi
    if [ ! -f ${LLVM_DYLIB} ]; then
        echo "ERROR:" ${LLVM_DYLIB} " not found: update LLVM_DYLIB variable."
        exit 1
    fi
    EXTRA_CMAKE_ARGS="-DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DEXTERNAL_LIBCLANG_PATH=${CLANG_DYLIB} -DPATH_TO_LLVM_ROOT=${LLVM_ROOT}" python3 ./install.py \
    --clang-completer --clang-tidy --java-completer --quiet
    # For some reason, the libraries are not copied, but they are needed.
    cp ${CLANG_DYLIB} ${LLVM_DYLIB} third_party/ycmd/third_party/clang/lib/
elif [ ${UNAME} = "Linux" ]; then
    python3 ./install.py \
    --clang-completer --clang-tidy --java-completer --quiet
else
    echo "Fix $0 to build on your OS." >&2
    exit 1
fi
