#import "PersonBuilder.h"

@implementation PersonBuilder
{
    NSString* _firstName;
    NSString* _lastName;
    NSString* _nickName;
    NSInteger _age;
    BOOL _canOrder;
    Address* _address;
    NSArray<Address*>* _all;
}

- (Person *)buildPerson
{
    return [Person personWithFirstName:_firstName lastName:_lastName nickName:_nickName age:_age canOrder:_canOrder address:_address all:_all];
}

#pragma mark - Initializers

+ (instancetype)builder
{
    return [self new];
}

+ (instancetype)builderWithPerson:(Person *)existingPerson
{
    PersonBuilder* builder = [self builder];
    builder = [builder withFirstName:existingPerson.firstName];
    builder = [builder withLastName:existingPerson.lastName];
    builder = [builder withNickName:existingPerson.nickName];
    builder = [builder withAge:existingPerson.age];
    builder = [builder withCanOrder:existingPerson.canOrder];
    builder = [builder withAddress:existingPerson.address];
    builder = [builder withAll:existingPerson.all];
    return builder;
}

#pragma mark - Property setters

- (instancetype)withFirstName:(NSString*)firstName
{
    _firstName = [firstName copy];
    return self;
}

- (instancetype)withLastName:(NSString*)lastName
{
    _lastName = [lastName copy];
    return self;
}

- (instancetype)withNickName:(NSString*)nickName
{
    _nickName = [nickName copy];
    return self;
}

- (instancetype)withAge:(NSInteger)age
{
    _age = age;
    return self;
}

- (instancetype)withCanOrder:(BOOL)canOrder
{
    _canOrder = canOrder;
    return self;
}

- (instancetype)withAddress:(Address*)address
{
    _address = [address copy];
    return self;
}

- (instancetype)withAll:(NSArray<Address*>*)all
{
    _all = [all copy];
    return self;
}

@end
