#!/bin/bash

mkdir -p app
cat > "app/.gitignore" <<END
*
END

if [ `uname` == Darwin ]; then
  [ -d app/PretextView.app ] && rm -rf app/PretextView.app
  env CC=clang CXX=clang MACOSX_DEPLOYMENT_TARGET=10.10 meson setup --buildtype=release --prefix=$(pwd)/app/PretextView.app --bindir=Contents/MacOS --unity on builddir --reconfigure
else
  env CC=clang CXX=clang meson setup --buildtype=release --prefix=$(pwd)/app --bindir=./ --unity on builddir --reconfigure
fi

meson compile -C builddir
meson install -C builddir

