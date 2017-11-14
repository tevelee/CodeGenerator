#import "Person.h"

__unsafe_unretained NSString* const kPersonFirstNameNSCodingKey = @"PERSON_FIRSTNAME";
__unsafe_unretained NSString* const kPersonLastNameNSCodingKey = @"PERSON_LASTNAME";
__unsafe_unretained NSString* const kPersonNickNameNSCodingKey = @"PERSON_NICKNAME";
__unsafe_unretained NSString* const kPersonAgeNSCodingKey = @"PERSON_AGE";
__unsafe_unretained NSString* const kPersonCanOrderNSCodingKey = @"PERSON_CANORDER";
__unsafe_unretained NSString* const kPersonAddressNSCodingKey = @"PERSON_ADDRESS";
__unsafe_unretained NSString* const kPersonAllNSCodingKey = @"PERSON_ALL";

__unsafe_unretained NSString* const kPersonFirstNameJSONCodingKey = @"firstName";
__unsafe_unretained NSString* const kPersonLastNameJSONCodingKey = @"lastName";
__unsafe_unretained NSString* const kPersonNickNameJSONCodingKey = @"nickName";
__unsafe_unretained NSString* const kPersonAgeJSONCodingKey = @"age";
__unsafe_unretained NSString* const kPersonCanOrderJSONCodingKey = @"canOrder";
__unsafe_unretained NSString* const kPersonAddressJSONCodingKey = @"address";
__unsafe_unretained NSString* const kPersonAllJSONCodingKey = @"all";

@implementation Person

+ (instancetype)personWithFirstName:(NSString*)firstName lastName:(NSString*)lastName nickName:(NSString*)nickName age:(NSInteger)age canOrder:(BOOL)canOrder address:(Address*)address all:(NSArray<Address*>*)all
{
    return [[self alloc] initWithFirstName:firstName lastName:lastName nickName:nickName age:age canOrder:canOrder address:address all:all];
}

- (instancetype)initWithFirstName:(NSString*)firstName lastName:(NSString*)lastName nickName:(NSString*)nickName age:(NSInteger)age canOrder:(BOOL)canOrder address:(Address*)address all:(NSArray<Address*>*)all
{
    self = [super init];
    if (self) { 
        _firstName = [firstName copy];
        _lastName = [lastName copy];
        _nickName = [nickName copy];
        _age = age;
        _canOrder = canOrder;
        _address = [address copy];
        _all = [all copy];
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

    BOOL haveEqualCanOrderProperties = self.canOrder == person.canOrder;
    if (haveEqualCanOrderProperties == NO) {
        return NO;
    }

    BOOL haveEqualAddressProperties = (self.address == nil && person.address == nil) || [self.address isEqual:person.address];
    if (haveEqualAddressProperties == NO) {
        return NO;
    }

    BOOL haveEqualAllProperties = (self.all == nil && person.all == nil) || [self.all isEqualToArray:person.all];
    if (haveEqualAllProperties == NO) {
        return NO;
    }

    return YES;
}

#pragma mark -
#pragma mark NSObject (Hashing)

- (NSUInteger)hash
{
    return super.hash
     ^ [self.firstName hash]
     ^ [self.lastName hash]
     ^ [self.nickName hash]
     ^ [@(self.age) hash]
     ^ [@(self.canOrder) hash]
     ^ [self.address hash]
     ^ [self.all hash];
}

#pragma mark -
#pragma mark NSObject (Description)

- (NSString *)description
{
    NSString* existing = super.description;
    return [[existing substringToIndex:existing.length - 1] stringByAppendingFormat:@"firstName = %@, \n\tlastName = %@, \n\tnickName = %@, \n\tage = %ld, \n\tcanOrder = %ld, \n\taddress = %@, \n\tall = %@>", self.firstName, self.lastName, self.nickName, self.age, (NSInteger)self.canOrder, self.address, self.all];
}

#pragma mark -
#pragma mark Setters

- (Person*)personBySettingFirstName:(NSString*)firstName
{
    return [[self.class alloc] initWithFirstName:firstName lastName:self.lastName.copy nickName:self.nickName.copy age:self.age canOrder:self.canOrder address:self.address.copy all:self.all.copy];
}
- (Person*)personBySettingLastName:(NSString*)lastName
{
    return [[self.class alloc] initWithFirstName:self.firstName.copy lastName:lastName nickName:self.nickName.copy age:self.age canOrder:self.canOrder address:self.address.copy all:self.all.copy];
}
- (Person*)personBySettingNickName:(NSString*)nickName
{
    return [[self.class alloc] initWithFirstName:self.firstName.copy lastName:self.lastName.copy nickName:nickName age:self.age canOrder:self.canOrder address:self.address.copy all:self.all.copy];
}
- (Person*)personBySettingAge:(NSInteger)age
{
    return [[self.class alloc] initWithFirstName:self.firstName.copy lastName:self.lastName.copy nickName:self.nickName.copy age:age canOrder:self.canOrder address:self.address.copy all:self.all.copy];
}
- (Person*)personBySettingCanOrder:(BOOL)canOrder
{
    return [[self.class alloc] initWithFirstName:self.firstName.copy lastName:self.lastName.copy nickName:self.nickName.copy age:self.age canOrder:canOrder address:self.address.copy all:self.all.copy];
}
- (Person*)personBySettingAddress:(Address*)address
{
    return [[self.class alloc] initWithFirstName:self.firstName.copy lastName:self.lastName.copy nickName:self.nickName.copy age:self.age canOrder:self.canOrder address:address all:self.all.copy];
}
- (Person*)personBySettingAll:(NSArray<Address*>*)all
{
    return [[self.class alloc] initWithFirstName:self.firstName.copy lastName:self.lastName.copy nickName:self.nickName.copy age:self.age canOrder:self.canOrder address:self.address.copy all:all];
}

#pragma mark - 
#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.firstName forKey:kPersonFirstNameNSCodingKey];
    [encoder encodeObject:self.lastName forKey:kPersonLastNameNSCodingKey];
    [encoder encodeObject:self.nickName forKey:kPersonNickNameNSCodingKey];
    [encoder encodeInteger:self.age forKey:kPersonAgeNSCodingKey];
    [encoder encodeObject:self.address forKey:kPersonAddressNSCodingKey];
    [encoder encodeObject:self.all forKey:kPersonAllNSCodingKey];
}

- (nullable instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _firstName = [decoder decodeObjectForKey:kPersonFirstNameNSCodingKey];
    _lastName = [decoder decodeObjectForKey:kPersonLastNameNSCodingKey];
    _nickName = [decoder decodeObjectForKey:kPersonNickNameNSCodingKey];
    _age = [decoder decodeIntegerForKey:kPersonAgeNSCodingKey];
    _address = [decoder decodeObjectForKey:kPersonAddressNSCodingKey];
    _all = [decoder decodeObjectForKey:kPersonAllNSCodingKey];

    return self;
}

#pragma mark -
#pragma mark NSCopying

- (id)copyWithZone:(nullable NSZone *)zone
{
    return [[self.class allocWithZone:zone] initWithFirstName:self.firstName.copy lastName:self.lastName.copy nickName:self.nickName.copy age:self.age canOrder:self.canOrder address:self.address.copy all:self.all.copy];
}

#pragma mark -
#pragma mark JSON Encoding

- (NSString*)jsonRepresentation
{
    NSError* error = nil;
    NSData* data = [NSJSONSerialization dataWithJSONObject:self.dictionaryRepresentation options:NSJSONWritingPrettyPrinted error:&error];
    if (data && error == nil) {
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    } else {
        return nil;
    }
}

- (NSDictionary<NSString*, id>*)dictionaryRepresentation
{
    NSMutableDictionary* dictionary = [NSMutableDictionary dictionaryWithCapacity:7];
    
    if (self.firstName) {
        [dictionary setObject:self.firstName.copy forKey:kPersonFirstNameJSONCodingKey];
    }

    if (self.lastName) {
        [dictionary setObject:self.lastName.copy forKey:kPersonLastNameJSONCodingKey];
    }

    if (self.nickName) {
        [dictionary setObject:self.nickName.copy forKey:kPersonNickNameJSONCodingKey];
    }

    [dictionary setObject:@(self.age) forKey:kPersonAgeJSONCodingKey];

    [dictionary setObject:@(self.canOrder) forKey:kPersonCanOrderJSONCodingKey];

    if (self.address) {
        [dictionary setObject:self.address.dictionaryRepresentation forKey:kPersonAddressJSONCodingKey];
    }

    if (self.all.count > 0) {
        NSMutableArray* all = [NSMutableArray arrayWithCapacity:self.all.count];
        for (Address* object in self.all) {
            [all addObject:object.dictionaryRepresentation];
        }
        [dictionary setObject:all.copy forKey:kPersonAllJSONCodingKey];
    }

    return dictionary;
}
#pragma mark -
#pragma mark JSON Decoding

+ (instancetype)modelWithJSON:(NSString*)json
{
    NSData* data = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError* error = nil;
    NSDictionary* dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (dictionary && error == nil) {
        return [self modelWithDictionary:dictionary];
    } else {
        return nil;
    }
}

+ (instancetype)modelWithDictionary:(NSDictionary<NSString*, id>*)dictionary
{
    if (dictionary == nil) {
        return nil;
    }
    NSString* firstName = [self stringFromObject:[dictionary objectForKey:kPersonFirstNameJSONCodingKey]];
    NSString* lastName = [self stringFromObject:[dictionary objectForKey:kPersonLastNameJSONCodingKey]];
    NSString* nickName = [self stringFromObject:[dictionary objectForKey:kPersonNickNameJSONCodingKey]];
    NSInteger age = [[self numberFromObject:[dictionary objectForKey:kPersonAgeJSONCodingKey]] integerValue];
    BOOL canOrder = [[self numberFromObject:[dictionary objectForKey:kPersonCanOrderJSONCodingKey]] boolValue];
    Address* address = [Address modelWithDictionary:[dictionary objectForKey:kPersonAddressJSONCodingKey]];
    NSArray<NSDictionary*>* plainAll = [dictionary objectForKey:kPersonAllJSONCodingKey];
    NSMutableArray<Address*>* all = [NSMutableArray arrayWithCapacity:plainAll.count];
    for (NSDictionary* dictionary in plainAll) {
        Address* object = [Address modelWithDictionary:dictionary];
        [all addObject:object];
    }
    return [self personWithFirstName:firstName lastName:lastName nickName:nickName age:age canOrder:canOrder address:address all:all];
}

+ (NSNumber*)numberFromObject:(id)object
{
    if ([object isKindOfClass:[NSNumber class]]) {
        return object;
    } else if ([object isKindOfClass:[NSString class]]) {
        return [NSNumber numberWithDouble:[object doubleValue]];
    } else {
        return nil;
    }
}

+ (NSString*)stringFromObject:(id)object
{
    if ([object isKindOfClass:[NSString class]]) {
        return object;
    } else if ([object isKindOfClass:[NSNumber class]]) {
        return [object stringValue];
    } else {
        return nil;
    }
}

@end
