#!/bin/bash
# duplicate of buildjdk.sh that avoids reconfiguring. Used for making changes to openjdk code.
. setdevkitpath.sh
export FREETYPE_DIR=$(pwd)/freetype-${BUILD_FREETYPE_VERSION}/build_android-${TARGET_SHORT}
export CUPS_DIR=$(pwd)/cups-2.3.3

cd openjdk/build/${JVM_PLATFORM}-"${TARGET_JDK}"-${JVM_VARIANTS}-release
make JOBS=4 images
