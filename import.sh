#!/usr/bin/env sh

set -eu

rm -rf *.cc internal/*
curl -sL https://github.com/google/protobuf/archive/v3.0.0-alpha-3.tar.gz | tar zxf - -C internal --strip-components=1
(cd internal && ./autogen.sh && ./configure && make -C src google/protobuf/stubs/pbconfig.h)
patch -p1 < gitignore.patch

# stuff we need to compile. Roughly:
# grep -F '.cc' internal/src/Makefile.am | grep -vE '(test|gzip|mock|compiler)' | sed -E 's/ +\\?//g' | sort | uniq
SOURCES='
google/protobuf/any.cc
google/protobuf/any.pb.cc
google/protobuf/api.pb.cc
google/protobuf/arena.cc
google/protobuf/arenastring.cc
google/protobuf/descriptor.cc
google/protobuf/descriptor.pb.cc
google/protobuf/descriptor_database.cc
google/protobuf/duration.pb.cc
google/protobuf/dynamic_message.cc
google/protobuf/empty.pb.cc
google/protobuf/extension_set.cc
google/protobuf/extension_set_heavy.cc
google/protobuf/field_mask.pb.cc
google/protobuf/generated_message_reflection.cc
google/protobuf/generated_message_util.cc
google/protobuf/io/coded_stream.cc
google/protobuf/io/printer.cc
google/protobuf/io/strtod.cc
google/protobuf/io/tokenizer.cc
google/protobuf/io/zero_copy_stream.cc
google/protobuf/io/zero_copy_stream_impl.cc
google/protobuf/io/zero_copy_stream_impl_lite.cc
google/protobuf/map_field.cc
google/protobuf/message.cc
google/protobuf/message_lite.cc
google/protobuf/reflection_ops.cc
google/protobuf/repeated_field.cc
google/protobuf/service.cc
google/protobuf/source_context.pb.cc
google/protobuf/struct.pb.cc
google/protobuf/stubs/atomicops_internals_x86_gcc.cc
google/protobuf/stubs/atomicops_internals_x86_msvc.cc
google/protobuf/stubs/common.cc
google/protobuf/stubs/once.cc
google/protobuf/stubs/stringprintf.cc
google/protobuf/stubs/structurally_valid.cc
google/protobuf/stubs/strutil.cc
google/protobuf/stubs/substitute.cc
google/protobuf/text_format.cc
google/protobuf/timestamp.pb.cc
google/protobuf/type.pb.cc
google/protobuf/unknown_field_set.cc
google/protobuf/wire_format.cc
google/protobuf/wire_format_lite.cc
google/protobuf/wrappers.pb.cc
'

# symlink so cgo compiles them
for file in $SOURCES; do
  ln -sf internal/src/$file .
done

# copy generated files we want to keep
cp internal/config.h .

# stuff we need to compile. Roughly:
# grep -F '.cc' internal/src/Makefile.am | grep -vE '(test|gzip|mock)' | grep compiler | grep -vF = | sed -E 's/[ \\]//g' | sort | uniq
PROTOC_SOURCES='
google/protobuf/compiler/code_generator.cc
google/protobuf/compiler/command_line_interface.cc
google/protobuf/compiler/cpp/cpp_enum.cc
google/protobuf/compiler/cpp/cpp_enum_field.cc
google/protobuf/compiler/cpp/cpp_extension.cc
google/protobuf/compiler/cpp/cpp_field.cc
google/protobuf/compiler/cpp/cpp_file.cc
google/protobuf/compiler/cpp/cpp_generator.cc
google/protobuf/compiler/cpp/cpp_helpers.cc
google/protobuf/compiler/cpp/cpp_map_field.cc
google/protobuf/compiler/cpp/cpp_message.cc
google/protobuf/compiler/cpp/cpp_message_field.cc
google/protobuf/compiler/cpp/cpp_primitive_field.cc
google/protobuf/compiler/cpp/cpp_service.cc
google/protobuf/compiler/cpp/cpp_string_field.cc
google/protobuf/compiler/csharp/csharp_enum.cc
google/protobuf/compiler/csharp/csharp_enum_field.cc
google/protobuf/compiler/csharp/csharp_extension.cc
google/protobuf/compiler/csharp/csharp_field_base.cc
google/protobuf/compiler/csharp/csharp_generator.cc
google/protobuf/compiler/csharp/csharp_helpers.cc
google/protobuf/compiler/csharp/csharp_message.cc
google/protobuf/compiler/csharp/csharp_message_field.cc
google/protobuf/compiler/csharp/csharp_primitive_field.cc
google/protobuf/compiler/csharp/csharp_repeated_enum_field.cc
google/protobuf/compiler/csharp/csharp_repeated_message_field.cc
google/protobuf/compiler/csharp/csharp_repeated_primitive_field.cc
google/protobuf/compiler/csharp/csharp_source_generator_base.cc
google/protobuf/compiler/csharp/csharp_umbrella_class.cc
google/protobuf/compiler/csharp/csharp_writer.cc
google/protobuf/compiler/importer.cc
google/protobuf/compiler/java/java_context.cc
google/protobuf/compiler/java/java_doc_comment.cc
google/protobuf/compiler/java/java_enum.cc
google/protobuf/compiler/java/java_enum_field.cc
google/protobuf/compiler/java/java_enum_field_lite.cc
google/protobuf/compiler/java/java_extension.cc
google/protobuf/compiler/java/java_field.cc
google/protobuf/compiler/java/java_file.cc
google/protobuf/compiler/java/java_generator.cc
google/protobuf/compiler/java/java_generator_factory.cc
google/protobuf/compiler/java/java_helpers.cc
google/protobuf/compiler/java/java_lazy_message_field.cc
google/protobuf/compiler/java/java_lazy_message_field_lite.cc
google/protobuf/compiler/java/java_map_field.cc
google/protobuf/compiler/java/java_map_field_lite.cc
google/protobuf/compiler/java/java_message.cc
google/protobuf/compiler/java/java_message_builder.cc
google/protobuf/compiler/java/java_message_builder_lite.cc
google/protobuf/compiler/java/java_message_field.cc
google/protobuf/compiler/java/java_message_field_lite.cc
google/protobuf/compiler/java/java_message_lite.cc
google/protobuf/compiler/java/java_name_resolver.cc
google/protobuf/compiler/java/java_primitive_field.cc
google/protobuf/compiler/java/java_primitive_field_lite.cc
google/protobuf/compiler/java/java_service.cc
google/protobuf/compiler/java/java_shared_code_generator.cc
google/protobuf/compiler/java/java_string_field.cc
google/protobuf/compiler/java/java_string_field_lite.cc
google/protobuf/compiler/javanano/javanano_enum.cc
google/protobuf/compiler/javanano/javanano_enum_field.cc
google/protobuf/compiler/javanano/javanano_extension.cc
google/protobuf/compiler/javanano/javanano_field.cc
google/protobuf/compiler/javanano/javanano_file.cc
google/protobuf/compiler/javanano/javanano_generator.cc
google/protobuf/compiler/javanano/javanano_helpers.cc
google/protobuf/compiler/javanano/javanano_map_field.cc
google/protobuf/compiler/javanano/javanano_message.cc
google/protobuf/compiler/javanano/javanano_message_field.cc
google/protobuf/compiler/javanano/javanano_primitive_field.cc
google/protobuf/compiler/objectivec/objectivec_enum.cc
google/protobuf/compiler/objectivec/objectivec_enum_field.cc
google/protobuf/compiler/objectivec/objectivec_extension.cc
google/protobuf/compiler/objectivec/objectivec_field.cc
google/protobuf/compiler/objectivec/objectivec_file.cc
google/protobuf/compiler/objectivec/objectivec_generator.cc
google/protobuf/compiler/objectivec/objectivec_helpers.cc
google/protobuf/compiler/objectivec/objectivec_map_field.cc
google/protobuf/compiler/objectivec/objectivec_message.cc
google/protobuf/compiler/objectivec/objectivec_message_field.cc
google/protobuf/compiler/objectivec/objectivec_oneof.cc
google/protobuf/compiler/objectivec/objectivec_primitive_field.cc
google/protobuf/compiler/parser.cc
google/protobuf/compiler/plugin.cc
google/protobuf/compiler/plugin.pb.cc
google/protobuf/compiler/python/python_generator.cc
google/protobuf/compiler/ruby/ruby_generator.cc
google/protobuf/compiler/subprocess.cc
google/protobuf/compiler/zip_writer.cc
'

# symlink so cgo compiles them
for file in $PROTOC_SOURCES; do
  ln -sf ../../internal/src/$file cmd/protoc/
done

# restore the repo to what it would look like when first cloned
git clean -dxf
