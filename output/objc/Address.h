#import <Foundation/Foundation.h>
#import "Enum.h"

FOUNDATION_EXPORT __unsafe_unretained NSString* const kAddressPostalCodeNSCodingKey;
FOUNDATION_EXPORT __unsafe_unretained NSString* const kAddressStreetAddressNSCodingKey;
FOUNDATION_EXPORT __unsafe_unretained NSString* const kAddressNumberNSCodingKey;
FOUNDATION_EXPORT __unsafe_unretained NSString* const kAddressValidNSCodingKey;

FOUNDATION_EXPORT __unsafe_unretained NSString* const kAddressPostalCodeJSONCodingKey;
FOUNDATION_EXPORT __unsafe_unretained NSString* const kAddressStreetAddressJSONCodingKey;
FOUNDATION_EXPORT __unsafe_unretained NSString* const kAddressNumberJSONCodingKey;
FOUNDATION_EXPORT __unsafe_unretained NSString* const kAddressValidJSONCodingKey;

@interface Address : NSObject <NSCoding, NSCopying>

@property (nonatomic, copy, readonly) NSNumber* postalCode;
@property (nonatomic, copy, readonly) NSString* streetAddress;
@property (nonatomic, assign, readonly) NumberEnum number;
@property (nonatomic, assign, readonly, getter = isValid) BOOL valid;

+ (instancetype)addressWithPostalCode:(NSNumber*)postalCode streetAddress:(NSString*)streetAddress number:(NumberEnum)number valid:(BOOL)isValid;

- (BOOL)isEqualToAddress:(Address *)address;

#pragma mark - Setters

- (Address*)addressBySettingPostalCode:(NSNumber*)postalCode;
- (Address*)addressBySettingStreetAddress:(NSString*)streetAddress;
- (Address*)addressBySettingNumber:(NumberEnum)number;
- (Address*)addressBySettingValid:(BOOL)valid;

#pragma mark - JSON Encoding

- (NSString*)jsonRepresentation;
- (NSDictionary<NSString*, id>*)dictionaryRepresentation;

#pragma mark - JSON Decoding

+ (instancetype)modelWithJSON:(NSString*)json;
+ (instancetype)modelWithDictionary:(NSDictionary<NSString*, id>*)dictionary;

@end
