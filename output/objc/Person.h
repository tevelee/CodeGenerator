#import <Foundation/Foundation.h>
#import "Address.h"

FOUNDATION_EXPORT __unsafe_unretained NSString* const kPersonFirstNameNSCodingKey;
FOUNDATION_EXPORT __unsafe_unretained NSString* const kPersonLastNameNSCodingKey;
FOUNDATION_EXPORT __unsafe_unretained NSString* const kPersonNickNameNSCodingKey;
FOUNDATION_EXPORT __unsafe_unretained NSString* const kPersonAgeNSCodingKey;
FOUNDATION_EXPORT __unsafe_unretained NSString* const kPersonAddressesNSCodingKey;

FOUNDATION_EXPORT __unsafe_unretained NSString* const kPersonFirstNameJSONCodingKey;
FOUNDATION_EXPORT __unsafe_unretained NSString* const kPersonLastNameJSONCodingKey;
FOUNDATION_EXPORT __unsafe_unretained NSString* const kPersonNickNameJSONCodingKey;
FOUNDATION_EXPORT __unsafe_unretained NSString* const kPersonAgeJSONCodingKey;
FOUNDATION_EXPORT __unsafe_unretained NSString* const kPersonAddressesJSONCodingKey;

@interface Person : NSObject <NSCoding, NSCopying>

@property (nonatomic, copy, readonly) NSString* firstName;
@property (nonatomic, copy, readonly) NSString* lastName;
@property (nonatomic, copy, readonly) NSString* nickName;
@property (nonatomic, assign, readonly) NSInteger age;
@property (nonatomic, copy, readonly) NSArray<Address*>* addresses;

+ (instancetype)personWithFirstName:(NSString*)firstName lastName:(NSString*)lastName nickName:(NSString*)nickName age:(NSInteger)age addresses:(NSArray<Address*>*)addresses;

- (BOOL)isEqualToPerson:(Person *)person;

#pragma mark - JSON Encoding

- (NSString*)jsonRepresentation;
- (NSDictionary<NSString*, id>*)dictionaryRepresentation;

#pragma mark - JSON Decoding

+ (instancetype)modelWithJSON:(NSString*)json;
+ (instancetype)modelWithDictionary:(NSDictionary<NSString*, id>*)dictionary;

@end
