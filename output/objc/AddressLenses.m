#import "AddressLenses.h"

@implementation AddressLenses

+ (Lens<Address*, NSNumber*>*)postalCode
{
    return [Lens lensWithGet:^NSNumber*(Address* whole){
        return whole.postalCode;
    } set:^Address*(Address* whole, NSNumber* part) {
        return [whole addressBySettingPostalCode:part];
    }];
}
+ (Lens<Address*, NSString*>*)streetAddress
{
    return [Lens lensWithGet:^NSString*(Address* whole){
        return whole.streetAddress;
    } set:^Address*(Address* whole, NSString* part) {
        return [whole addressBySettingStreetAddress:part];
    }];
}
+ (Lens<Address*, NSNumber*>*)number
{
    return [Lens lensWithGet:^NSNumber*(Address* whole){
        return @(whole.number);
    } set:^Address*(Address* whole, NSNumber* part) {
        return [whole addressBySettingNumber:part.integerValue];
    }];
}
+ (Lens<Address*, NSNumber*>*)valid
{
    return [Lens lensWithGet:^NSNumber*(Address* whole){
        return @(whole.valid);
    } set:^Address*(Address* whole, NSNumber* part) {
        return [whole addressBySettingValid:part.boolValue];
    }];
}

@end

@implementation BoundLensToAddress

- (BoundLens*)postalCode 
{
    return [BoundLens lensWithParent:self sublens:[AddressLenses postalCode]];
}
- (BoundLens*)streetAddress 
{
    return [BoundLens lensWithParent:self sublens:[AddressLenses streetAddress]];
}
- (BoundLens*)number 
{
    return [BoundLens lensWithParent:self sublens:[AddressLenses number]];
}
- (BoundLens*)valid 
{
    return [BoundLens lensWithParent:self sublens:[AddressLenses valid]];
}

@end

@implementation Address (Lens)

- (BoundLensToAddress*)lens
{
    return [BoundLensToAddress lensWithInstance:self lens:[Lens identityLens]];
}

@end
