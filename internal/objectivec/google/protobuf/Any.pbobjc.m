// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: google/protobuf/any.proto

#import "GPBProtocolBuffers_RuntimeSupport.h"
#import "google/protobuf/Any.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma mark - GPBAnyRoot

@implementation GPBAnyRoot

@end

static GPBFileDescriptor *GPBAnyRoot_FileDescriptor(void) {
  // This is called by +initialize so there is no need to worry
  // about thread safety of the singleton.
  static GPBFileDescriptor *descriptor = NULL;
  if (!descriptor) {
    descriptor = [[GPBFileDescriptor alloc] initWithPackage:@"google.protobuf"
                                                     syntax:GPBFileSyntaxProto3];
  }
  return descriptor;
}

#pragma mark - GPBAny

@implementation GPBAny

@dynamic typeURL;
@dynamic value;

typedef struct GPBAny_Storage {
  uint32_t _has_storage_[1];
  NSString *typeURL;
  NSData *value;
} GPBAny_Storage;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = NULL;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "typeURL",
        .number = GPBAny_FieldNumber_TypeURL,
        .hasIndex = 0,
        .flags = GPBFieldOptional | GPBFieldTextFormatNameCustom,
        .type = GPBTypeString,
        .offset = offsetof(GPBAny_Storage, typeURL),
        .defaultValue.valueString = nil,
        .typeSpecific.className = NULL,
        .fieldOptions = NULL,
      },
      {
        .name = "value",
        .number = GPBAny_FieldNumber_Value,
        .hasIndex = 1,
        .flags = GPBFieldOptional,
        .type = GPBTypeData,
        .offset = offsetof(GPBAny_Storage, value),
        .defaultValue.valueData = nil,
        .typeSpecific.className = NULL,
        .fieldOptions = NULL,
      },
    };
#if GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    const char *extraTextFormatInfo = NULL;
#else
    static const char *extraTextFormatInfo = "\001\001\004\241!!\000";
#endif  // GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    descriptor = [GPBDescriptor allocDescriptorForClass:[GPBAny class]
                                              rootClass:[GPBAnyRoot class]
                                                   file:GPBAnyRoot_FileDescriptor()
                                                 fields:fields
                                             fieldCount:sizeof(fields) / sizeof(GPBMessageFieldDescription)
                                                 oneofs:NULL
                                             oneofCount:0
                                                  enums:NULL
                                              enumCount:0
                                                 ranges:NULL
                                             rangeCount:0
                                            storageSize:sizeof(GPBAny_Storage)
                                             wireFormat:NO
                                    extraTextFormatInfo:extraTextFormatInfo];
  }
  return descriptor;
}

@end


// @@protoc_insertion_point(global_scope)
