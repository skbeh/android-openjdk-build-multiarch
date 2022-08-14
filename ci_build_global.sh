#!/bin/bash
. setdevkitpath.sh

export JDK_DEBUG_LEVEL=release

if [ "$BUILD_IOS" != "1" ]; then
  sudo apt update
  sudo apt -y install autoconf python3 unzip zip

  wget -nc -nv -O android-ndk-$NDK_VERSION-linux.zip "https://dl.google.com/android/repository/android-ndk-$NDK_VERSION-linux.zip"
  ./extractndk.sh
else
  # OpenJDK 8 iOS port is still in unusable state, so we need build in debug mode
  export JDK_DEBUG_LEVEL=slowdebug

  chmod +x ios-arm64-clang
  chmod +x ios-arm64-clang++
  chmod +x macos-host-cc
fi

# Some modifies to NDK to fix

./getlibs.sh
./buildlibs.sh
./clonejdk.sh
./buildjdk.sh
./removejdkdebuginfo.sh
./tarjdk.sh
