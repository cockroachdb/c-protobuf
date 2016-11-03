#!/usr/bin/env sh

set -eu

rm -rf internal/*
find . -type l -not -path './.git/*' | xargs rm

curl -sL https://github.com/google/protobuf/releases/download/v3.1.0/protobuf-cpp-3.1.0.tar.gz | tar vzxf - -C internal/ --strip-components=1

cd internal
./configure
source update_file_lists.sh
cd ..

# copy generated files we want to keep
cp internal/config.h .

# symlink so cgo compiles them
for file in $LIBPROTOBUF_LITE_SOURCES $LIBPROTOBUF_SOURCES; do
  ln -sf internal/src/$file .
done

# symlink so cgo compiles them
for file in $LIBPROTOC_SOURCES; do
  ln -sf ../../internal/src/$file cmd/protoc
done

# restore the repo to what it would look like when first cloned.
# comment this line out while updating upstream.
git clean -dxf
