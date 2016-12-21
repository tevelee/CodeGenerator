#import "AddressBuilder.h"

@implementation AddressBuilder
{
    NSNumber* _postalCode;
    NSString* _streetAddress;
    NumberEnum _number;
    BOOL _valid;
}

- (Address *)build
{
    return [Address addressWithPostalCode:_postalCode streetAddress:_streetAddress number:_number valid:_valid];
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
    builder = [builder withValid:existingAddress.isValid];
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

- (instancetype)withNumber:(NumberEnum)number
{
    _number = number;
    return self;
}

- (instancetype)withValid:(BOOL)valid
{
    _valid = valid;
    return self;
}

@end
