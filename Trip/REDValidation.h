//
//  REDValidation.h
//  Trip
//
//  Created by Станислав Редреев on 07.03.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ValidationType) {
    ValidationEmail = 0,
    ValidationPassword = 1,
    ValidationLogin = 2,
    ValidationFirstOrLastName = 3,
};

@interface REDValidation : NSObject

+ (REDValidation *)sharedValidationService;

- (BOOL)validationText:(NSString *)text withValidationType:(ValidationType)type;

//- (BOOL)emailValidation:(NSString *)text;
//- (BOOL)passwordValidation:(NSString *)text;
//- (BOOL)loginValidation:(NSString *)text;
//- (BOOL)firstAndLastNameValidation:(NSString *)text;

@end
