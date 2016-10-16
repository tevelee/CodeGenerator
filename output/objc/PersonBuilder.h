#import <Foundation/Foundation.h>
#import "Person.h"

@interface PersonBuilder : NSObject

- (Person *)build;

#pragma mark - Initializers

+ (instancetype)builder;
+ (instancetype)builderFromPerson:(Person *)existingPerson;

#pragma mark - Property setters

- (instancetype)withFirstName:(NSString*)firstName;
- (instancetype)withLastName:(NSString*)lastName;
- (instancetype)withNickName:(NSString*)nickName;
- (instancetype)withAge:(NSInteger)age;
- (instancetype)withAddress:(Address*)address;

@end
