#import "PersonBuilder.h"

@implementation PersonBuilder
{
    NSString* _firstName;
    NSString* _lastName;
    NSString* _nickName;
    NSInteger _age;
    NSArray<Address*>* _addresses;
}

- (Person *)build
{
    return [Person personWithFirstName:_firstName lastName:_lastName nickName:_nickName age:_age addresses:_addresses];
}

#pragma mark - Initializers

+ (instancetype)builder
{
    return [self new];
}

+ (instancetype)builderFromPerson:(Person *)existingPerson
{
    PersonBuilder* builder = [self builder];
    builder = [builder withFirstName:existingPerson.firstName];
    builder = [builder withLastName:existingPerson.lastName];
    builder = [builder withNickName:existingPerson.nickName];
    builder = [builder withAge:existingPerson.age];
    builder = [builder withAddresses:existingPerson.addresses];
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

- (instancetype)withAddresses:(NSArray<Address*>*)addresses
{
    _addresses = [addresses copy];
    return self;
}

@end
