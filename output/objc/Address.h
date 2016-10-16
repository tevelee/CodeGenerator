#import <Foundation/Foundation.h>

FOUNDATION_EXPORT __unsafe_unretained NSString* const kAddressPostalCodeKey;
FOUNDATION_EXPORT __unsafe_unretained NSString* const kAddressStreetAddressKey;
FOUNDATION_EXPORT __unsafe_unretained NSString* const kAddressNumberKey;

@interface Address : NSObject <NSCoding, NSCopying>

@property (nonatomic, copy, readonly) NSNumber* postalCode;
@property (nonatomic, copy, readonly) NSString* streetAddress;
@property (nonatomic, assign, readonly) NSInteger number;

+ (instancetype)addressWithPostalCode:(NSNumber*)postalCode streetAddress:(NSString*)streetAddress number:(NSInteger)number;

- (BOOL)isEqualToAddress:(Address *)address;

@end
