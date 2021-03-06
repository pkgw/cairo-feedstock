#!/bin/bash

export CFLAGS="-I$PREFIX/include -L$PREFIX/lib"

# As of Mac OS 10.8, X11 is no longer included by default
# (See https://support.apple.com/en-us/HT201341 for the details).
# Due to this change, we disable building X11 support for cairo on OS X by
# default.
export XWIN_ARGS=""
if [ $(uname) == Darwin ]; then
    export XWIN_ARGS="--disable-xlib -disable-xcb --disable-glitz"
fi

./configure \
    --prefix="${PREFIX}" \
    --enable-warnings \
    --enable-ft \
    --enable-ps \
    --enable-pdf \
    --enable-svg \
    --disable-gtk-doc \
    $XWIN_ARGS

make
# FAIL: check-link on OS X
# Hangs for > 10 minutes on Linux
# make check
make install
