#!/bin/bash
. setdevkitpath.sh

if [ "$BUILD_IOS" != "1" ]; then
  unset AR AS CC CXX LD OBJCOPY RANLIB STRIP CPPFLAGS LDFLAGS
  git clone https://github.com/termux/termux-elf-cleaner || true
  cd termux-elf-cleaner
  autoreconf --install
  ./configure
  make
  chmod +x termux-elf-cleaner
  cd ..

  findexec() {
    find "$1" -type f -name "*" -not -name "*.o" -exec sh -c '
    case "$(head -n 1 "$1")" in
      ?ELF*) exit 0;;
      MZ*) exit 0;;
      #!*/ocamlrun*)exit0;;
    esac
exit 1
' sh {} \; -print
  }

  findexec jreout | xargs -- ./termux-elf-cleaner/termux-elf-cleaner --api-level 33
  findexec jdkout | xargs -- ./termux-elf-cleaner/termux-elf-cleaner --api-level 33

fi

cp -rv jre_override/lib/* jreout/lib/ || true

cd jreout
tar cJf "../jre17-${TARGET_SHORT}-$(date +%Y%m%d)-${JDK_DEBUG_LEVEL}.tar.xz" .

cd ../jdkout
tar cJf "../jdk17-${TARGET_SHORT}-$(date +%Y%m%d)-${JDK_DEBUG_LEVEL}.tar.xz" .
