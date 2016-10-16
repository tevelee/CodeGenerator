//
//  ViewController.m
//  Example
//
//  Created by László Teveli on 2016. 10. 17..
//  Copyright © 2016. László Teveli. All rights reserved.
//

#import "ViewController.h"
#import "AddressBuilder.h"
#import "PersonBuilder.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Address* address = [Address addressWithPostalCode:@1052 streetAddress:@"Karoly korut" number:6];
    Person* person = [Person personWithFirstName:@"a" lastName:@"b" nickName:@"c" age:10 address:address];
    person = [[[PersonBuilder builderFromPerson:person] withLastName:@"Teveli"] build];
}

@end
