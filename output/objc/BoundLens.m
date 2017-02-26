//
//  BoundLens.m
//  Example
//
//  Created by László Teveli on 2016. 12. 21..
//  Copyright © 2016. László Teveli. All rights reserved.
//

#import "BoundLens.h"

@implementation Lens

+ (instancetype)lensWithGet:(id(^)(id whole))get set:(id(^)(id whole, id part))set
{
    return [[self alloc] initWithGet:get set:set];
}

- (instancetype)initWithGet:(id(^)(id whole))get set:(id(^)(id whole, id part))set
{
    self = [super init];
    if (self) {
        _get = get;
        _set = set;
    }
    return self;
}

+ (instancetype)identityLens
{
    return [self lensWithGet:^id(id whole) {
        return whole;
    } set:^id(id whole, id part) {
        return whole;
    }];
}

@end

@implementation BoundLensStorage

+ (instancetype)storageWithInstance:(id)instance lens:(Lens*)lens
{
    return [[self alloc] initWithInstance:instance lens:lens];
}

- (instancetype)initWithInstance:(id)instance lens:(Lens*)lens
{
    self = [super init];
    if (self)
    {
        _instance = instance;
        _lens = lens;
    }
    return self;
}

@end

@implementation BoundLens

+ (instancetype)lensWithInstance:(id)instance parentLens:(Lens*)parent
{
    return [[self alloc] initWithInstance:instance parentLens:parent];
}

- (instancetype)initWithInstance:(id)instance parentLens:(Lens*)parent
{
    self = [super init];
    if (self)
    {
        _storage = [BoundLensStorage storageWithInstance:instance lens:parent];
    }
    return self;
}

- (id)get
{
    return self.storage.lens.get(self.storage.instance);
}

- (id)set:(id)part
{
    return self.storage.lens.set(self.storage.instance, part);
}

@end
