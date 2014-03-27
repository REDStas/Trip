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

+ (REDValidation *)sharedValidationService
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

#pragma mark - Interface Methods

- (BOOL)validationText:(NSString *)text withValidationType:(ValidationType)type
{
    switch (type) {
        case ValidationEmail:
            return [self emailValidation:text];
            break;
        case ValidationLogin:
            return [self loginValidation:text];
            break;
        case ValidationPassword:
            return [self passwordValidation:text];
            break;
        case ValidationFirstOrLastName:
            return [self firstAndLastNameValidation:text];
            break;
            
        default:
            return NO;
            break;
    }
}

- (BOOL)emailValidation:(NSString *)text
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest =[NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:text];
}

- (BOOL)passwordValidation:(NSString *)text
{
    NSString *emailRegex = @"^.*(?=.{10,})(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=]).*$";
    NSPredicate *emailTest =[NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:text];
}

- (BOOL)loginValidation:(NSString *)text
{
    if (text.length < 5 || text.length > 100)
        return NO;
    return YES;
}

- (BOOL)firstAndLastNameValidation:(NSString *)text
{
    if (text.length < 3 || text.length > 100)
        return NO;
    return YES;
}


/*
 Must be at least 10 characters
 Must contain at least one one lower case letter, one upper case letter, one digit and one special character
 Valid special characters are -   @#$%^&+=
 ^.*(?=.{10,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=]).*$
 */

@end
