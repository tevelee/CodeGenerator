#import "Address.h"

__unsafe_unretained NSString* const kAddressPostalCodeNSCodingKey = @"ADDRESS_POSTALCODE";
__unsafe_unretained NSString* const kAddressStreetAddressNSCodingKey = @"ADDRESS_STREETADDRESS";
__unsafe_unretained NSString* const kAddressNumberNSCodingKey = @"ADDRESS_NUMBER";
__unsafe_unretained NSString* const kAddressValidNSCodingKey = @"ADDRESS_VALID";

__unsafe_unretained NSString* const kAddressPostalCodeJSONCodingKey = @"postal_code";
__unsafe_unretained NSString* const kAddressStreetAddressJSONCodingKey = @"streetAddress";
__unsafe_unretained NSString* const kAddressNumberJSONCodingKey = @"number";
__unsafe_unretained NSString* const kAddressValidJSONCodingKey = @"valid";

@implementation Address

+ (instancetype)addressWithPostalCode:(NSNumber*)postalCode streetAddress:(NSString*)streetAddress number:(NumberEnum)number valid:(BOOL)valid
{
    return [[self alloc] initWithPostalCode:postalCode streetAddress:streetAddress number:number valid:valid];
}

- (instancetype)initWithPostalCode:(NSNumber*)postalCode streetAddress:(NSString*)streetAddress number:(NumberEnum)number valid:(BOOL)valid{
    self = [super init];
    if (self) { 
        _postalCode = [postalCode copy];
        _streetAddress = [streetAddress copy];
        _number = number;
        _valid = valid;
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
    
    if (![object isKindOfClass:[Address class]]) {
        return NO;
    }
    
    return [self isEqualToAddress:(Address *)object];
}

- (BOOL)isEqualToAddress:(Address *)address
{
    if (address == nil) {
        return NO;
    }

    BOOL haveEqualPostalCodeProperties = (self.postalCode == nil && address.postalCode == nil) || [self.postalCode isEqualToNumber:address.postalCode];
    if (haveEqualPostalCodeProperties == NO) {
        return NO;
    }

    BOOL haveEqualStreetAddressProperties = (self.streetAddress.length == 0 && address.streetAddress.length == 0) || [self.streetAddress isEqualToString:address.streetAddress];
    if (haveEqualStreetAddressProperties == NO) {
        return NO;
    }

    BOOL haveEqualNumberProperties = self.number == address.number;
    if (haveEqualNumberProperties == NO) {
        return NO;
    }

    BOOL haveEqualValidProperties = self.isValid == address.isValid;
    if (haveEqualValidProperties == NO) {
        return NO;
    }

    return YES;
}

#pragma mark -
#pragma mark NSObject (Hashing)

- (NSUInteger)hash
{
    return super.hash ^ [self.postalCode hash] ^ [self.streetAddress hash] ^ [@(self.number) hash] ^ [@(self.isValid) hash];
}


#pragma mark -
#pragma mark NSObject (Description)

- (NSString *)description
{
    NSString* existing = super.description;
    return [[existing substringToIndex:existing.length - 1] stringByAppendingFormat:@"postalCode = %@, \n\tstreetAddress = %@, \n\tnumber = %ld, \n\tvalid = %ld>", self.postalCode, self.streetAddress, self.number, (NSInteger)self.isValid];
}

#pragma mark - 
#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.postalCode forKey:kAddressPostalCodeNSCodingKey];
    [encoder encodeObject:self.streetAddress forKey:kAddressStreetAddressNSCodingKey];
    [encoder encodeInt:self.number forKey:kAddressNumberNSCodingKey];
}

- (nullable instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _postalCode = [decoder decodeObjectForKey:kAddressPostalCodeNSCodingKey];
    _streetAddress = [decoder decodeObjectForKey:kAddressStreetAddressNSCodingKey];
    _number = [decoder decodeIntForKey:kAddressNumberNSCodingKey];

    return self;
}

#pragma mark -
#pragma mark NSCopying

- (id)copyWithZone:(nullable NSZone *)zone
{
    return [[self.class allocWithZone:zone] initWithPostalCode:self.postalCode.copy streetAddress:self.streetAddress.copy number:self.number valid:self.isValid];
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
    NSMutableDictionary* dictionary = [NSMutableDictionary dictionaryWithCapacity:4];
    
    if (self.postalCode) {
        [dictionary setObject:self.postalCode.copy forKey:kAddressPostalCodeJSONCodingKey];
    }

    if (self.streetAddress) {
        [dictionary setObject:self.streetAddress.copy forKey:kAddressStreetAddressJSONCodingKey];
    }

    [dictionary setObject:@(self.number) forKey:kAddressNumberJSONCodingKey];

    [dictionary setObject:@(self.isValid) forKey:kAddressValidJSONCodingKey];

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
    NSNumber* postalCode = [self numberFromObject:[dictionary objectForKey:kAddressPostalCodeJSONCodingKey]];
    NSString* streetAddress = [self stringFromObject:[dictionary objectForKey:kAddressStreetAddressJSONCodingKey]];
    NumberEnum number = [[self numberFromObject:[dictionary objectForKey:kAddressNumberJSONCodingKey]] intValue];
    BOOL valid = [dictionary objectForKey:kAddressValidJSONCodingKey];
    return [self addressWithPostalCode:postalCode streetAddress:streetAddress number:number valid:valid];
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
