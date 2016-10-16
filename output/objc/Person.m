#import "Person.h"

__unsafe_unretained NSString* const kPersonFirstNameKey = @"PERSON_FIRSTNAME";
__unsafe_unretained NSString* const kPersonLastNameKey = @"PERSON_LASTNAME";
__unsafe_unretained NSString* const kPersonNickNameKey = @"PERSON_NICKNAME";
__unsafe_unretained NSString* const kPersonAgeKey = @"PERSON_AGE";
__unsafe_unretained NSString* const kPersonAddressKey = @"PERSON_ADDRESS";

@implementation Person

+ (instancetype)personWithFirstName:(NSString*)firstName lastName:(NSString*)lastName nickName:(NSString*)nickName age:(NSInteger)age address:(Address*)address
{
    return [[self alloc] initWithFirstName:firstName lastName:lastName nickName:nickName age:age address:address];
}

- (instancetype)initWithFirstName:(NSString*)firstName lastName:(NSString*)lastName nickName:(NSString*)nickName age:(NSInteger)age address:(Address*)address{
    self = [super init];
    if (self) { 
        _firstName = [firstName copy];
        _lastName = [lastName copy];
        _nickName = [nickName copy];
        _age = age;
        _address = [address copy];
    }
    return self;
}

#pragma mark -
#pragma mark NSObject (Equality)

- (BOOL)isEqual:(id)object
{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[Person class]]) {
        return NO;
    }
    
    return [self isEqualToPerson:(Person *)object];
}

- (BOOL)isEqualToPerson:(Person *)person
{
    if (person == nil) {
        return NO;
    }

    BOOL haveEqualFirstNameProperties = (self.firstName.length == 0 && person.firstName.length == 0) || [self.firstName isEqualToString:person.firstName];
    if (haveEqualFirstNameProperties == NO) {
        return NO;
    }
    BOOL haveEqualLastNameProperties = (self.lastName.length == 0 && person.lastName.length == 0) || [self.lastName isEqualToString:person.lastName];
    if (haveEqualLastNameProperties == NO) {
        return NO;
    }
    BOOL haveEqualNickNameProperties = (self.nickName.length == 0 && person.nickName.length == 0) || [self.nickName isEqualToString:person.nickName];
    if (haveEqualNickNameProperties == NO) {
        return NO;
    }
    BOOL haveEqualAgeProperties = self.age == person.age;
    if (haveEqualAgeProperties == NO) {
        return NO;
    }
    BOOL haveEqualAddressProperties = (self.address == nil && person.address == nil) || [self.address isEqual:person.address];
    if (haveEqualAddressProperties == NO) {
        return NO;
    }
    
    return YES;
}

#pragma mark -
#pragma mark NSObject (Hashing)

- (NSUInteger)hash
{
    return super.hash ^ [self.firstName hash] ^ [self.lastName hash] ^ [self.nickName hash] ^ [@(self.age) hash] ^ [self.address hash];
}

#pragma mark -
#pragma mark NSObject (Description)

- (NSString *)description
{
    NSString* existing = super.description;
    return [[existing substringToIndex:existing.length - 1] stringByAppendingFormat:@"firstName = %@, \n\tlastName = %@, \n\tnickName = %@, \n\tage = %ld, \n\taddress = %@>", self.firstName, self.lastName, self.nickName, self.age, self.address];
}

#pragma mark - 
#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.firstName forKey:kPersonFirstNameKey];
    [encoder encodeObject:self.lastName forKey:kPersonLastNameKey];
    [encoder encodeObject:self.nickName forKey:kPersonNickNameKey];
    [encoder encodeInteger:self.age forKey:kPersonAgeKey];
    [encoder encodeObject:self.address forKey:kPersonAddressKey];
}

- (nullable instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _firstName = [decoder decodeObjectForKey:kPersonFirstNameKey];
    _lastName = [decoder decodeObjectForKey:kPersonLastNameKey];
    _nickName = [decoder decodeObjectForKey:kPersonNickNameKey];
    _age = [decoder decodeIntegerForKey:kPersonAgeKey];
    _address = [decoder decodeObjectForKey:kPersonAddressKey];

    return self;
}

#pragma mark -
#pragma mark NSCopying

- (id)copyWithZone:(nullable NSZone *)zone
{
    return [[self.class allocWithZone:zone] initWithFirstName:self.firstName.copy lastName:self.lastName.copy nickName:self.nickName.copy age:self.age address:self.address.copy];
}

@end
