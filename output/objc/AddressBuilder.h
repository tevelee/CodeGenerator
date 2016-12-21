#import <Foundation/Foundation.h>
#import "Address.h"

@interface AddressBuilder : NSObject

- (Address *)build;

#pragma mark - Initializers

+ (instancetype)builder;
+ (instancetype)builderFromAddress:(Address *)existingAddress;

#pragma mark - Property setters

- (instancetype)withPostalCode:(NSNumber*)postalCode;
- (instancetype)withStreetAddress:(NSString*)streetAddress;
- (instancetype)withNumber:(NumberEnum)number;
- (instancetype)withValid:(BOOL)valid;

@end
