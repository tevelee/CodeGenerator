#import <Foundation/Foundation.h>
#import "Address.h"

FOUNDATION_EXPORT __unsafe_unretained NSString* const kPersonFirstNameNSCodingKey;
FOUNDATION_EXPORT __unsafe_unretained NSString* const kPersonLastNameNSCodingKey;
FOUNDATION_EXPORT __unsafe_unretained NSString* const kPersonNickNameNSCodingKey;
FOUNDATION_EXPORT __unsafe_unretained NSString* const kPersonAgeNSCodingKey;
FOUNDATION_EXPORT __unsafe_unretained NSString* const kPersonCanOrderNSCodingKey;
FOUNDATION_EXPORT __unsafe_unretained NSString* const kPersonAddressNSCodingKey;
FOUNDATION_EXPORT __unsafe_unretained NSString* const kPersonAllNSCodingKey;

FOUNDATION_EXPORT __unsafe_unretained NSString* const kPersonFirstNameJSONCodingKey;
FOUNDATION_EXPORT __unsafe_unretained NSString* const kPersonLastNameJSONCodingKey;
FOUNDATION_EXPORT __unsafe_unretained NSString* const kPersonNickNameJSONCodingKey;
FOUNDATION_EXPORT __unsafe_unretained NSString* const kPersonAgeJSONCodingKey;
FOUNDATION_EXPORT __unsafe_unretained NSString* const kPersonCanOrderJSONCodingKey;
FOUNDATION_EXPORT __unsafe_unretained NSString* const kPersonAddressJSONCodingKey;
FOUNDATION_EXPORT __unsafe_unretained NSString* const kPersonAllJSONCodingKey;

@interface Person : NSObject <NSCoding, NSCopying>

@property (nonatomic, copy, readonly) NSString* firstName;
@property (nonatomic, copy, readonly) NSString* lastName;
@property (nonatomic, copy, readonly) NSString* nickName;
@property (nonatomic, assign, readonly) NSInteger age;
@property (nonatomic, assign, readonly, getter = canOrder) BOOL canOrder;
@property (nonatomic, copy, readonly) Address* address;
@property (nonatomic, copy, readonly) NSArray<Address*>* all;

+ (instancetype)personWithFirstName:(NSString*)firstName lastName:(NSString*)lastName nickName:(NSString*)nickName age:(NSInteger)age canOrder:(BOOL)canOrder address:(Address*)address all:(NSArray<Address*>*)all;

- (BOOL)isEqualToPerson:(Person *)person;

#pragma mark - Setters

- (Person*)personBySettingFirstName:(NSString*)firstName;
- (Person*)personBySettingLastName:(NSString*)lastName;
- (Person*)personBySettingNickName:(NSString*)nickName;
- (Person*)personBySettingAge:(NSInteger)age;
- (Person*)personBySettingCanOrder:(BOOL)canOrder;
- (Person*)personBySettingAddress:(Address*)address;
- (Person*)personBySettingAll:(NSArray<Address*>*)all;

#pragma mark - JSON Encoding

- (NSString*)jsonRepresentation;
- (NSDictionary<NSString*, id>*)dictionaryRepresentation;

#pragma mark - JSON Decoding

+ (instancetype)modelWithJSON:(NSString*)json;
+ (instancetype)modelWithDictionary:(NSDictionary<NSString*, id>*)dictionary;

@end
