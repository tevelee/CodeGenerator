//
//  Lenses.h
//  Example
//
//  Created by László Teveli on 2016. 12. 21..
//  Copyright © 2016. László Teveli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Lens <__covariant Whole, __covariant Part> : NSObject

@property (nonatomic, copy, readonly) Whole(^get)(Whole whole);
@property (nonatomic, copy, readonly) Whole(^set)(Whole whole, Part part);

+ (instancetype)lensWithGet:(Whole(^)(Whole whole))get set:(Whole(^)(Whole whole, Part part))set;
+ (instancetype)identityLens;

- (Lens*)compose:(Lens*)lens;

@end

@class BoundLens;

@interface BoundLensStorage <__covariant Whole, __covariant Part> : NSObject

@property (nonatomic, weak, readonly) Whole instance;
@property (nonatomic, strong, readonly) Lens<Whole, Part>* lens;

+ (instancetype)storageWithInstance:(id)instance lens:(Lens*)lens;

@end

@interface BoundLens <__covariant Whole, __covariant Part> : Lens

@property (nonatomic, strong, readonly) BoundLensStorage<Whole, Part>* storage;

+ (instancetype)lensWithInstance:(id)instance lens:(Lens*)parent;
+ (instancetype)lensWithParent:(BoundLens*)parent sublens:(Lens*)sublens;

- (Part)get;
- (Whole)set:(Part)part;

@end
