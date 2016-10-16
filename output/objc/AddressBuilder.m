#import "AddressBuilder.h"

@implementation AddressBuilder
{
    NSNumber* _postalCode;
    NSString* _streetAddress;
    NSInteger _number;
}
- (Address *)build
{
    return [Address addressWithPostalCode:_postalCode streetAddress:_streetAddress number:_number];
}

#pragma mark - Initializers

+ (instancetype)builder
{
    return [self new];
}

+ (instancetype)builderFromAddress:(Address *)existingAddress
{
    AddressBuilder* builder = [self builder];
    builder = [builder withPostalCode:existingAddress.postalCode];
    builder = [builder withStreetAddress:existingAddress.streetAddress];
    builder = [builder withNumber:existingAddress.number];
    return builder;
}

#pragma mark - Property setters

- (instancetype)withPostalCode:(NSNumber*)postalCode
{
    _postalCode = [postalCode copy];
    return self;
}

- (instancetype)withStreetAddress:(NSString*)streetAddress
{
    _streetAddress = [streetAddress copy];
    return self;
}

- (instancetype)withNumber:(NSInteger)number
{
    _number = number;
    return self;
}


@end
