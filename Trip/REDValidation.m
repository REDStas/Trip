//
//  REDValidation.m
//  Trip
//
//  Created by Станислав Редреев on 07.03.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import "REDValidation.h"

@implementation REDValidation

static REDValidation *sharedValidation = nil;

- (id)init;
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (REDValidation *)sharedErrorWindow
{
    @synchronized([REDValidation class])
    {
        if (!sharedValidation)
            sharedValidation = [[REDValidation alloc] init];
        
        return sharedValidation;
    }
    return nil;
}

+ (id)alloc
{
    @synchronized([REDValidation class])
    {
        NSAssert(sharedValidation == nil, @"Attempted to allocate a second instance of a singleton.");
        sharedValidation = [super alloc];
        return sharedValidation;
    }
    return nil;
}

@end
