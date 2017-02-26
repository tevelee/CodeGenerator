//
//  ViewController.m
//  ObjectiveC
//
//  Created by László Teveli on 2016. 10. 17..
//  Copyright © 2016. László Teveli. All rights reserved.
//

#import "ViewController.h"
#import "AddressBuilder.h"
#import "PersonBuilder.h"
#import "PersonLenses.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Address* address = [Address addressWithPostalCode:@1052 streetAddress:@"Karoly korut 6" number:NumberEnumOne valid:YES];
    Person* person = [Person personWithFirstName:@"Laszlo" lastName:@"Teveli" nickName:@"Teve" age:25 canOrder:YES address:address all:@[]];
    
    PersonBuilder* builder = [[PersonBuilder builderWithPerson:person] withAge:26];
    person = builder.buildPerson;
    
    person = [person personBySettingAge:26];
    person = [person.lens.firstName set:@"Laz"];
    person = [person.lens.address.streetAddress set:@"Karoly körút 6."];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
