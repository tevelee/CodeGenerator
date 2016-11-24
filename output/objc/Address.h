#import <Foundation/Foundation.h>
#import "Enum.h"

FOUNDATION_EXPORT __unsafe_unretained NSString* const kAddressPostalCodeNSCodingKey;
FOUNDATION_EXPORT __unsafe_unretained NSString* const kAddressStreetAddressNSCodingKey;
FOUNDATION_EXPORT __unsafe_unretained NSString* const kAddressNumberNSCodingKey;
FOUNDATION_EXPORT __unsafe_unretained NSString* const kAddressItemsNSCodingKey;
FOUNDATION_EXPORT __unsafe_unretained NSString* const kAddressMapNSCodingKey;

FOUNDATION_EXPORT __unsafe_unretained NSString* const kAddressPostalCodeJSONCodingKey;
FOUNDATION_EXPORT __unsafe_unretained NSString* const kAddressStreetAddressJSONCodingKey;
FOUNDATION_EXPORT __unsafe_unretained NSString* const kAddressNumberJSONCodingKey;
FOUNDATION_EXPORT __unsafe_unretained NSString* const kAddressItemsJSONCodingKey;
FOUNDATION_EXPORT __unsafe_unretained NSString* const kAddressMapJSONCodingKey;

@interface Address : NSObject <NSCoding, NSCopying>

@property (nonatomic, copy, readonly) NSNumber* postalCode;
@property (nonatomic, copy, readonly) NSString* streetAddress;
@property (nonatomic, assign, readonly) NumberEnum number;
@property (nonatomic, copy, readonly) NSArray<NSString*>* items;
@property (nonatomic, copy, readonly) NSDictionary<NSString*, NSNumber*>* map;

+ (instancetype)addressWithPostalCode:(NSNumber*)postalCode streetAddress:(NSString*)streetAddress number:(NumberEnum)number items:(NSArray<NSString*>*)items map:(NSDictionary<NSString*, NSNumber*>*)map;

- (BOOL)isEqualToAddress:(Address *)address;

#pragma mark - JSON Encoding

- (NSString*)jsonRepresentation;
- (NSDictionary<NSString*, id>*)dictionaryRepresentation;

#pragma mark - JSON Decoding

+ (instancetype)modelWithJSON:(NSString*)json;
+ (instancetype)modelWithDictionary:(NSDictionary<NSString*, id>*)dictionary;

@end
