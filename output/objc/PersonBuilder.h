#import <Foundation/Foundation.h>
#import "Person.h"

@interface PersonBuilder : NSObject

- (Person *)buildPerson;

#pragma mark - Initializers

+ (instancetype)builder;
+ (instancetype)builderWithPerson:(Person *)existingPerson;

#pragma mark - Property setters

- (instancetype)withFirstName:(NSString*)firstName;
- (instancetype)withLastName:(NSString*)lastName;
- (instancetype)withNickName:(NSString*)nickName;
- (instancetype)withAge:(NSInteger)age;
- (instancetype)withCanOrder:(BOOL)canOrder;
- (instancetype)withAddress:(Address*)address;
- (instancetype)withAll:(NSArray<Address*>*)all;

@end
