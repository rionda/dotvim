#! /bin/sh
CLANG_DYLIB=/opt/local/libexec/llvm-4.0/lib/libclang.dylib
PYTHON_DYLIB=/opt/local/Library/Frameworks/Python.framework/Versions/3.6/lib/libpython3.6.dylib
PYTHON_INCLUDE=/opt/local/Library/Frameworks/Python.framework/Versions/3.6/Headers
if [ ! -f ${CLANG_DYLIB} ]; then
    echo "ERROR:" ${CLANG_DYLIB} " not found: update CLANG_DYLIB variable."
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
cmake -G "Unix Makefiles" -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DEXTERNAL_LIBCLANG_PATH=${CLANG_DYLIB} -DUSE_PYTHON2=OFF -DPYTHON_LIBRARY=${PYTHON_DYLIB} -DPYTHON_INCLUDE_DIR=${PYTHON_INCLUDE} .  ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp && \
cmake -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DEXTERNAL_LIBCLANG_PATH=${CLANG_DYLIB} -DUSE_PYTHON2=OFF -DUSE_CLANG_COMPLETER=y -DPYTHON_LIBRARY=${PYTHON_DYLIB} -DPYTHON_INCLUDE_DIR=${PYTHON_INCLUDE} --build . --target ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp # --config Release
#make ycm_support_libs && \
make && \
cd .. && \
rm -rf ycm_build
