#! /usr/bin/env bash
# Build MAD-X static library from prepared sources.
#
# Usage: madx.sh [<MADXDIR>] [<BUILDDIR>] [<DISTDIR>]
#
# Arguments:
#   <MADXDIR>:  root directory of MAD-X sources
#   <BUILDDIR>: cmake build directory
#   <DISTDIR>:  output prefix for madx installation
#
# Outputs:
#   <MADXDIR>/build: cmake build directory
#   <MADXDIR>/dist:  MAD-X installation directory (binary distribution)
set -eux -o pipefail

MADXDIR=${1-MAD-X}
BUILDDIR=${2-$MADXDIR/build}
DISTDIR=${3-$MADXDIR/dist}

if [[ ! -d "$MADXDIR" ]]; then
    git clone https://github.com/MethodicalAcceleratorDesign/MAD-X \
        "$MADXDIR" -b "$(cat MADX_VERSION)" --depth 1
fi

cmake -S "$1" -B "${2-$1/build}" \
    -DCMAKE_INSTALL_PREFIX="${3-$1/dist}" \
    -G "MinGW Makefiles" \
    -DBUILD_SHARED_LIBS=OFF \
    -DMADX_STATIC=ON \
    -DCMAKE_BUILD_TYPE=Release \
    -DMADX_INSTALL_DOC=OFF \
    -DMADX_ONLINE=OFF \
    -DMADX_FORCE_32=OFF \
    -DMADX_X11=OFF

cmake --build "$BUILDDIR" --target install
