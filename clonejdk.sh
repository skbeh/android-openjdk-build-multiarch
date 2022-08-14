#!/bin/sh
set -eu

git clone --depth 1 https://github.com/PojavLauncherTeam/mobile openjdk
cd openjdk
git am ../*.patch
