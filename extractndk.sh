#!/bin/sh
set -eu

unzip -q android-ndk-"$NDK_VERSION"-linux.zip
ln -s "$TOOLCHAIN"/bin/llvm-objcopy "$TOOLCHAIN"/bin/objcopy
ln -s "$TOOLCHAIN"/bin/llvm-strip "$TOOLCHAIN"/bin/strip
