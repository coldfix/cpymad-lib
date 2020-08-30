#! /usr/bin/env bash
set -ex

mkdir build
cd build

cmake ../src/MAD-X -G "MinGW Makefiles" \
    -DCMAKE_INSTALL_PREFIX=../dist \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHARED_LIBS=OFF \
    -DMADX_STATIC=ON \
    -DMADX_ONLINE=OFF \
    -DMADX_INSTALL_DOC=OFF \
    -DMADX_FORCE_32=OFF \
    -DMADX_X11=OFF

cmake --build . --target install

gcc -shared -s \
    lib/libmadx.obj \
    -L lib \
    -static \
    -lmadx -lDISTlib -lptc -lgc-lib \
    -lstdc++ -lgfortran -lquadmath \
    -o lib/madx.dll
