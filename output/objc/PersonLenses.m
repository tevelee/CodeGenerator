#import "PersonLenses.h"

@implementation PersonLenses

+ (Lens<Person*, NSString*>*)firstName
{
    return [Lens lensWithGet:^NSString*(Person* whole){
        return whole.firstName;
    } set:^Person*(Person* whole, NSString* part) {
        return [whole personBySettingFirstName:part];
    }];
}
+ (Lens<Person*, NSString*>*)lastName
{
    return [Lens lensWithGet:^NSString*(Person* whole){
        return whole.lastName;
    } set:^Person*(Person* whole, NSString* part) {
        return [whole personBySettingLastName:part];
    }];
}
+ (Lens<Person*, NSString*>*)nickName
{
    return [Lens lensWithGet:^NSString*(Person* whole){
        return whole.nickName;
    } set:^Person*(Person* whole, NSString* part) {
        return [whole personBySettingNickName:part];
    }];
}
+ (Lens<Person*, NSNumber*>*)age
{
    return [Lens lensWithGet:^NSNumber*(Person* whole){
        return @(whole.age);
    } set:^Person*(Person* whole, NSNumber* part) {
        return [whole personBySettingAge:part.integerValue];
    }];
}
+ (Lens<Person*, NSNumber*>*)canOrder
{
    return [Lens lensWithGet:^NSNumber*(Person* whole){
        return @(whole.canOrder);
    } set:^Person*(Person* whole, NSNumber* part) {
        return [whole personBySettingCanOrder:part.boolValue];
    }];
}
+ (Lens<Person*, Address*>*)address
{
    return [Lens lensWithGet:^Address*(Person* whole){
        return whole.address;
    } set:^Person*(Person* whole, Address* part) {
        return [whole personBySettingAddress:part];
    }];
}

@end

@implementation BoundLensToPerson

- (BoundLens*)firstName 
{
    return [BoundLens lensWithParent:self sublens:[PersonLenses firstName]];
}
- (BoundLens*)lastName 
{
    return [BoundLens lensWithParent:self sublens:[PersonLenses lastName]];
}
- (BoundLens*)nickName 
{
    return [BoundLens lensWithParent:self sublens:[PersonLenses nickName]];
}
- (BoundLens*)age 
{
    return [BoundLens lensWithParent:self sublens:[PersonLenses age]];
}
- (BoundLens*)canOrder 
{
    return [BoundLens lensWithParent:self sublens:[PersonLenses canOrder]];
}
- (BoundLensToAddress *)address 
{
    return [BoundLensToAddress lensWithParent:self sublens:[PersonLenses address]];
}

@end

@implementation Person (Lens)

- (BoundLensToPerson*)lens
{
    return [BoundLensToPerson lensWithInstance:self lens:[Lens identityLens]];
}

@end
