#import "PersonMinimal.h"


@implementation PersonMinimal

+ (instancetype)personMinimalWithFirstName:(NSString*)firstName lastName:(NSString*)lastName nickName:(NSString*)nickName age:(NSInteger)age
{
    return [[self alloc] initWithFirstName:firstName lastName:lastName nickName:nickName age:age];
}

- (instancetype)initWithFirstName:(NSString*)firstName lastName:(NSString*)lastName nickName:(NSString*)nickName age:(NSInteger)age
{
    self = [super init];
    if (self) { 
        _firstName = [firstName copy];
        _lastName = [lastName copy];
        _nickName = [nickName copy];
        _age = age;
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
    
    if (![object isKindOfClass:[PersonMinimal class]]) {
        return NO;
    }
    
    return [self isEqualToPersonMinimal:(PersonMinimal *)object];
}

- (BOOL)isEqualToPersonMinimal:(PersonMinimal *)personMinimal
{
    if (personMinimal == nil) {
        return NO;
    }

    BOOL haveEqualFirstNameProperties = (self.firstName.length == 0 && personMinimal.firstName.length == 0) || [self.firstName isEqualToString:personMinimal.firstName];
    if (haveEqualFirstNameProperties == NO) {
        return NO;
    }

    BOOL haveEqualLastNameProperties = (self.lastName.length == 0 && personMinimal.lastName.length == 0) || [self.lastName isEqualToString:personMinimal.lastName];
    if (haveEqualLastNameProperties == NO) {
        return NO;
    }

    BOOL haveEqualNickNameProperties = (self.nickName.length == 0 && personMinimal.nickName.length == 0) || [self.nickName isEqualToString:personMinimal.nickName];
    if (haveEqualNickNameProperties == NO) {
        return NO;
    }

    BOOL haveEqualAgeProperties = self.age == personMinimal.age;
    if (haveEqualAgeProperties == NO) {
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
     ^ [@(self.age) hash];
}

#pragma mark -
#pragma mark NSObject (Description)

- (NSString *)description
{
    NSString* existing = super.description;
    return [[existing substringToIndex:existing.length - 1] stringByAppendingFormat:@"firstName = %@, \n\tlastName = %@, \n\tnickName = %@, \n\tage = %ld>", self.firstName, self.lastName, self.nickName, self.age];
}

#pragma mark -
#pragma mark NSCopying

- (id)copyWithZone:(nullable NSZone *)zone
{
    return [[self.class allocWithZone:zone] initWithFirstName:self.firstName.copy lastName:self.lastName.copy nickName:self.nickName.copy age:self.age];
}

@end
