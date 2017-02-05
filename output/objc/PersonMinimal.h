#import <Foundation/Foundation.h>


@interface PersonMinimal : NSObject <NSCopying>

@property (nonatomic, copy) NSString* firstName;
@property (nonatomic, copy) NSString* lastName;
@property (nonatomic, copy) NSString* nickName;
@property (nonatomic, assign) NSInteger age;

+ (instancetype)personMinimalWithFirstName:(NSString*)firstName lastName:(NSString*)lastName nickName:(NSString*)nickName age:(NSInteger)age;

- (BOOL)isEqualToPersonMinimal:(PersonMinimal *)personMinimal;

@end
