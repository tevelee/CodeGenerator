#import <Foundation/Foundation.h>
#import "Address.h"
#import "Lenses.h"

@interface AddressLenses : NSObject

+ (Lens<Address*, NSNumber*>*)postalCode;
+ (Lens<Address*, NSString*>*)streetAddress;
+ (Lens<Address*, NSNumber*>*)number;
+ (Lens<Address*, NSNumber*>*)valid;

@end

@interface BoundLensToAddress<__covariant Whole> : BoundLens

- (BoundLens<Whole, NSNumber*>*)postalCode;
- (BoundLens<Whole, NSString*>*)streetAddress;
- (BoundLens<Whole, NSNumber*>*)number;
- (BoundLens<Whole, NSNumber*>*)valid;

@end

@interface Address (Lens)

- (BoundLensToAddress*)lens;

@end
