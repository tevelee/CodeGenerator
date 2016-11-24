#import "AddressBuilder.h"

@implementation AddressBuilder
{
    NSNumber* _postalCode;
    NSString* _streetAddress;
    NumberEnum _number;
    NSArray<NSString*>* _items;
    NSDictionary<NSString*, NSNumber*>* _map;
}

- (Address *)build
{
    return [Address addressWithPostalCode:_postalCode streetAddress:_streetAddress number:_number items:_items map:_map];
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
    builder = [builder withItems:existingAddress.items];
    builder = [builder withMap:existingAddress.map];
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

- (instancetype)withItems:(NSArray<NSString*>*)items
{
    _items = [items copy];
    return self;
}

- (instancetype)withMap:(NSDictionary<NSString*, NSNumber*>*)map
{
    _map = [map copy];
    return self;
}

@end
