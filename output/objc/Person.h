#import <Foundation/Foundation.h>
#import "Address.h"

FOUNDATION_EXPORT __unsafe_unretained NSString* const kPersonFirstNameKey;
FOUNDATION_EXPORT __unsafe_unretained NSString* const kPersonLastNameKey;
FOUNDATION_EXPORT __unsafe_unretained NSString* const kPersonNickNameKey;
FOUNDATION_EXPORT __unsafe_unretained NSString* const kPersonAgeKey;
FOUNDATION_EXPORT __unsafe_unretained NSString* const kPersonAddressKey;

@interface Person : NSObject <NSCoding, NSCopying>

@property (nonatomic, copy, readonly) NSString* firstName;
@property (nonatomic, copy, readonly) NSString* lastName;
@property (nonatomic, copy, readonly) NSString* nickName;
@property (nonatomic, assign, readonly) NSInteger age;
@property (nonatomic, copy, readonly) Address* address;

+ (instancetype)personWithFirstName:(NSString*)firstName lastName:(NSString*)lastName nickName:(NSString*)nickName age:(NSInteger)age address:(Address*)address;

- (BOOL)isEqualToPerson:(Person *)person;

@end
