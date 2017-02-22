#!/usr/bin/env bash

set -eu

rm -rf internal/*
find . -type l -not -path './.git/*' -exec rm {} \;

curl -sL https://github.com/google/protobuf/releases/download/v3.2.0/protobuf-cpp-3.2.0.tar.gz | tar vzxf - -C internal/ --strip-components=1

cd internal
./configure
source update_file_lists.sh
cd ..

# copy generated files we want to keep
cp internal/config.h .

# symlink so cgo compiles them
for file in $LIBPROTOBUF_LITE_SOURCES $LIBPROTOBUF_SOURCES; do
  ln -sf "internal/src/$file" .
done

# symlink so cgo compiles them
for file in $LIBPROTOC_SOURCES; do
  ln -sf "../../internal/src/$file" cmd/protoc
done

git clean -dXf
