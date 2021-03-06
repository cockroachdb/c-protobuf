package main

import (
	"os"
	"unsafe"

	_ "github.com/cockroachdb/c-protobuf"
)

// #cgo CXXFLAGS: -std=c++11
// #cgo CPPFLAGS: -I../.. -I../../internal/src
// #cgo !strictld,darwin LDFLAGS: -Wl,-undefined -Wl,dynamic_lookup
// #cgo !strictld,!darwin LDFLAGS: -Wl,-unresolved-symbols=ignore-all
//
// int cmain(int argc, char* argv[]);
import "C"

func main() {
	cargs := make([]*C.char, len(os.Args))
	for i, a := range os.Args {
		cargs[i] = C.CString(a)
	}
	C.cmain(C.int(len(os.Args)), (**C.char)(unsafe.Pointer(&cargs[0])))
}
