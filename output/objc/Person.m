#import "Person.h"

__unsafe_unretained NSString* const kPersonFirstNameNSCodingKey = @"PERSON_FIRSTNAME";
__unsafe_unretained NSString* const kPersonLastNameNSCodingKey = @"PERSON_LASTNAME";
__unsafe_unretained NSString* const kPersonNickNameNSCodingKey = @"PERSON_NICKNAME";
__unsafe_unretained NSString* const kPersonAgeNSCodingKey = @"PERSON_AGE";
__unsafe_unretained NSString* const kPersonMainAddressNSCodingKey = @"PERSON_MAINADDRESS";
__unsafe_unretained NSString* const kPersonAddressesNSCodingKey = @"PERSON_ADDRESSES";

__unsafe_unretained NSString* const kPersonFirstNameJSONCodingKey = @"firstName";
__unsafe_unretained NSString* const kPersonLastNameJSONCodingKey = @"lastName";
__unsafe_unretained NSString* const kPersonNickNameJSONCodingKey = @"nickName";
__unsafe_unretained NSString* const kPersonAgeJSONCodingKey = @"age";
__unsafe_unretained NSString* const kPersonMainAddressJSONCodingKey = @"mainAddress";
__unsafe_unretained NSString* const kPersonAddressesJSONCodingKey = @"addresses";

@implementation Person

+ (instancetype)personWithFirstName:(NSString*)firstName lastName:(NSString*)lastName nickName:(NSString*)nickName age:(NSInteger)age mainAddress:(Address*)mainAddress addresses:(NSArray<Address*>*)addresses
{
    return [[self alloc] initWithFirstName:firstName lastName:lastName nickName:nickName age:age mainAddress:mainAddress addresses:addresses];
}

- (instancetype)initWithFirstName:(NSString*)firstName lastName:(NSString*)lastName nickName:(NSString*)nickName age:(NSInteger)age mainAddress:(Address*)mainAddress addresses:(NSArray<Address*>*)addresses{
    self = [super init];
    if (self) { 
        _firstName = [firstName copy];
        _lastName = [lastName copy];
        _nickName = [nickName copy];
        _age = age;
        _mainAddress = [mainAddress copy];
        _addresses = [addresses copy];
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

    BOOL haveEqualMainAddressProperties = (self.mainAddress == nil && person.mainAddress == nil) || [self.mainAddress isEqual:person.mainAddress];
    if (haveEqualMainAddressProperties == NO) {
        return NO;
    }

    BOOL haveEqualAddressesProperties = (self.addresses == nil && person.addresses == nil) || [self.addresses isEqualToArray:person.addresses];
    if (haveEqualAddressesProperties == NO) {
        return NO;
    }

    return YES;
}

#pragma mark -
#pragma mark NSObject (Hashing)

- (NSUInteger)hash
{
    return super.hash ^ [self.firstName hash] ^ [self.lastName hash] ^ [self.nickName hash] ^ [@(self.age) hash] ^ [self.mainAddress hash] ^ [self.addresses hash];
}


#pragma mark -
#pragma mark NSObject (Description)

- (NSString *)description
{
    NSString* existing = super.description;
    return [[existing substringToIndex:existing.length - 1] stringByAppendingFormat:@"firstName = %@, \n\tlastName = %@, \n\tnickName = %@, \n\tage = %ld, \n\tmainAddress = %@, \n\taddresses = %@>", self.firstName, self.lastName, self.nickName, self.age, self.mainAddress, self.addresses];
}

#pragma mark - 
#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.firstName forKey:kPersonFirstNameNSCodingKey];
    [encoder encodeObject:self.lastName forKey:kPersonLastNameNSCodingKey];
    [encoder encodeObject:self.nickName forKey:kPersonNickNameNSCodingKey];
    [encoder encodeInteger:self.age forKey:kPersonAgeNSCodingKey];
    [encoder encodeObject:self.mainAddress forKey:kPersonMainAddressNSCodingKey];
    [encoder encodeObject:self.addresses forKey:kPersonAddressesNSCodingKey];
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
    _mainAddress = [decoder decodeObjectForKey:kPersonMainAddressNSCodingKey];
    _addresses = [decoder decodeObjectForKey:kPersonAddressesNSCodingKey];

    return self;
}

#pragma mark -
#pragma mark NSCopying

- (id)copyWithZone:(nullable NSZone *)zone
{
    return [[self.class allocWithZone:zone] initWithFirstName:self.firstName.copy lastName:self.lastName.copy nickName:self.nickName.copy age:self.age mainAddress:self.mainAddress.copy addresses:self.addresses.copy];
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
    NSMutableDictionary* dictionary = [NSMutableDictionary dictionaryWithCapacity:6];
    
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

    if (self.mainAddress) {
        [dictionary setObject:self.mainAddress.dictionaryRepresentation forKey:kPersonMainAddressJSONCodingKey];
    }

    if (self.addresses.count > 0) {
        NSMutableArray* addresses = [NSMutableArray arrayWithCapacity:self.addresses.count];
        for (Address* object in self.addresses) {
            [addresses addObject:object.dictionaryRepresentation];
        }
        [dictionary setObject:self.addresses.copy forKey:kPersonAddressesJSONCodingKey];
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
    NSString* firstName = [self stringFromObject:[dictionary objectForKey:kPersonFirstNameJSONCodingKey]];
    NSString* lastName = [self stringFromObject:[dictionary objectForKey:kPersonLastNameJSONCodingKey]];
    NSString* nickName = [self stringFromObject:[dictionary objectForKey:kPersonNickNameJSONCodingKey]];
    NSInteger age = [[self numberFromObject:[dictionary objectForKey:kPersonAgeJSONCodingKey]] integerValue];
    Address* mainAddress = [Address modelWithDictionary:[dictionary objectForKey:kPersonMainAddressJSONCodingKey]];
    NSArray<NSDictionary*>* plainAddresses = [dictionary objectForKey:kPersonAddressesJSONCodingKey];
    NSMutableArray<Address*>* addresses = [NSMutableArray arrayWithCapacity:plainAddresses.count];
    for (NSDictionary* dictionary in plainAddresses) {
        Address* object = [Address modelWithDictionary:dictionary];
        [addresses addObject:object];
    }
    return [self personWithFirstName:firstName lastName:lastName nickName:nickName age:age mainAddress:mainAddress addresses:addresses];
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
