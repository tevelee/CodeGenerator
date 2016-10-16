#import "Address.h"

__unsafe_unretained NSString* const kAddressPostalCodeKey = @"ADDRESS_POSTALCODE";
__unsafe_unretained NSString* const kAddressStreetAddressKey = @"ADDRESS_STREETADDRESS";
__unsafe_unretained NSString* const kAddressNumberKey = @"ADDRESS_NUMBER";

@implementation Address

+ (instancetype)addressWithPostalCode:(NSNumber*)postalCode streetAddress:(NSString*)streetAddress number:(NSInteger)number
{
    return [[self alloc] initWithPostalCode:postalCode streetAddress:streetAddress number:number];
}

- (instancetype)initWithPostalCode:(NSNumber*)postalCode streetAddress:(NSString*)streetAddress number:(NSInteger)number{
    self = [super init];
    if (self) { 
        _postalCode = [postalCode copy];
        _streetAddress = [streetAddress copy];
        _number = number;
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
    
    return YES;
}

#pragma mark -
#pragma mark NSObject (Hashing)

- (NSUInteger)hash
{
    return super.hash ^ [self.postalCode hash] ^ [self.streetAddress hash] ^ [@(self.number) hash];
}

#pragma mark -
#pragma mark NSObject (Description)

- (NSString *)description
{
    NSString* existing = super.description;
    return [[existing substringToIndex:existing.length - 1] stringByAppendingFormat:@"postalCode = %@, \n\tstreetAddress = %@, \n\tnumber = %ld>", self.postalCode, self.streetAddress, self.number];
}

#pragma mark - 
#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.postalCode forKey:kAddressPostalCodeKey];
    [encoder encodeObject:self.streetAddress forKey:kAddressStreetAddressKey];
    [encoder encodeInteger:self.number forKey:kAddressNumberKey];
}

- (nullable instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _postalCode = [decoder decodeObjectForKey:kAddressPostalCodeKey];
    _streetAddress = [decoder decodeObjectForKey:kAddressStreetAddressKey];
    _number = [decoder decodeIntegerForKey:kAddressNumberKey];

    return self;
}

#pragma mark -
#pragma mark NSCopying

- (id)copyWithZone:(nullable NSZone *)zone
{
    return [[self.class allocWithZone:zone] initWithPostalCode:self.postalCode.copy streetAddress:self.streetAddress.copy number:self.number];
}

@end
