//
//  ErrorWindow.h
//  Hello World
//
//  Created by Станислав Редреев on 06.03.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ErrorType) {
    ErrIncorectLoginOrPassword = 0,
    ErrEmptyTextField = 1,
    ErrNetworkConnectionError = 2,
    ErrValidationIncorrectEmail = 3,
    ErrValidationIncorrectPassword = 4,
};

@interface ErrorWindow : UIView

+ (ErrorWindow *)sharedErrorWindow;

//- (void)refresh;
- (void)addError:(ErrorType)errorCode;
- (void)removeError:(ErrorType)errorCode;
- (void)closeErrorWindow;

@end