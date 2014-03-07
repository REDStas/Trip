//
//  REDStartPage.h
//  Trip
//
//  Created by Станислав Редреев on 11.02.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "REDPopUp.h"
#import "REDLoginScreen.h"
#import "ErrorWindow.h"

@interface REDStartScreen : UIViewController
{
    REDLoginScreen *loginScreen;
}

@property (strong, nonatomic) UIWindow* otherWindow;
@property (strong, nonatomic) REDPopUp *popUp;


@end
