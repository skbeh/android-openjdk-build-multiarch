#!/bin/bash
. setdevkitpath.sh
cd freetype-$BUILD_FREETYPE_VERSION

echo "Building Freetype"

if [ "$BUILD_IOS" != "1" ]; then
  export PATH=$TOOLCHAIN/bin:$PATH
  ./configure \
    --host="$TARGET" \
    --prefix="${PWD}"/build_android-"${TARGET_SHORT}" \
    --without-zlib \
    --with-brotli=no \
    --with-png=no \
    --with-harfbuzz=no "${EXTRA_ARGS:-}" ||
    error_code=$?

  if [ "${error_code:-0}" -ne 0 ]; then
    echo -e "\n\nCONFIGURE ERROR $error_code , config.log:"
    cat "${PWD}"/builds/unix/config.log
    exit $error_code
  fi

  CFLAGS=-fno-rtti CXXFLAGS=-fno-rtti make -j4
  make install

fi
