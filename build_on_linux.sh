#! /usr/bin/env bash
set -ex
if [[ -d /opt/python/cp38-cp38/bin ]]; then
    PATH="/opt/python/cp38-cp38/bin:$PATH"
fi

mkdir build
cd build

pip install --upgrade cmake
cmake ../src/MAD-X \
    -DCMAKE_INSTALL_PREFIX=../dist \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_C_FLAGS="-fvisibility=hidden" \
    -DBUILD_SHARED_LIBS=OFF \
    -DMADX_STATIC=ON \
    -DMADX_ONLINE=OFF \
    -DMADX_INSTALL_DOC=OFF \
    -DMADX_FORCE_32=OFF \
    -DMADX_X11=OFF

cmake --build . --target install
