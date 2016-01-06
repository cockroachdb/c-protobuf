// Package protobuf uses the cgo compilation facilities to build the
// Protobuf C++ library. Note that support for zlib is not compiled
// in.
package protobuf

// #cgo CXXFLAGS: -std=c++11
// #cgo CPPFLAGS: -DLANG_CXX11 -DHAVE_CONFIG_H -DHAVE_PTHREAD -Iinternal/src
import "C"
