#import <Foundation/Foundation.h>
#import "Person.h"
#import "Lenses.h"
#import "AddressLenses.h"

@interface PersonLenses : NSObject

+ (Lens<Person*, NSString*>*)firstName;
+ (Lens<Person*, NSString*>*)lastName;
+ (Lens<Person*, NSString*>*)nickName;
+ (Lens<Person*, NSNumber*>*)age;
+ (Lens<Person*, NSNumber*>*)canOrder;
+ (Lens<Person*, Address*>*)address;

@end

@interface BoundLensToPerson<__covariant Whole> : BoundLens

- (BoundLens<Whole, NSString*>*)firstName;
- (BoundLens<Whole, NSString*>*)lastName;
- (BoundLens<Whole, NSString*>*)nickName;
- (BoundLens<Whole, NSNumber*>*)age;
- (BoundLens<Whole, NSNumber*>*)canOrder;
- (BoundLensToAddress<Whole>*)address;

@end

@interface Person (Lens)

- (BoundLensToPerson*)lens;

@end
