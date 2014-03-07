//
//  ErrorWindow.m
//  Hello World
//
//  Created by Станислав Редреев on 06.03.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import "ErrorWindow.h"

#import <QuartzCore/QuartzCore.h>

#define kErrorTitleWidth 265
#define kRemoveMasageTimerInterval  7.0

@implementation ErrorWindow
{
    UIView *mainView;
    CGRect lastErrorViewFrame;
    
    NSMutableDictionary *errorData;
    NSMutableArray *errorList;
    
    NSTimer *addMasageTimer;
    NSTimer *removeMasageTimer;
}

static ErrorWindow *sharedErrorWindow = nil;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        mainView = [[UIView alloc] initWithFrame:CGRectMake(10, 25, 300, 200)];
        [self addSubview:mainView];
        
        errorList = [[NSMutableArray alloc] init];
        errorData = [[NSMutableDictionary alloc] init];
        [self createErrorData];
        [self createTestData];
        
        removeMasageTimer = [NSTimer scheduledTimerWithTimeInterval:kRemoveMasageTimerInterval target:self selector:@selector(removeOldestErrorMessage) userInfo:nil repeats:YES];
        addMasageTimer = [NSTimer scheduledTimerWithTimeInterval:8.0 target:self selector:@selector(removeError:) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)createTestData
{
//    [errorList addObject:[NSString stringWithFormat:@"%i", ErrIncorectLoginOrPassword]];
//    [errorList addObject:[NSString stringWithFormat:@"%i", ErrNetworkConnectionError]];
//    [errorList addObject:[NSString stringWithFormat:@"%i", ErrEmptyTextField]];
}

- (void)createErrorData
{
    [errorData setObject:@"Неправильный логин или пароль. Повторите вашу попыдку ввсести данные." forKey:@"0"];
    [errorData setObject:@"Пустые поля" forKey:@"1"];
    [errorData setObject:@"Ошибка соединения с сетью" forKey:@"2"];
}

+ (ErrorWindow *)sharedErrorWindow
{
    @synchronized([ErrorWindow class])
    {
        if (!sharedErrorWindow)
            sharedErrorWindow = [[ErrorWindow alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
        
        return sharedErrorWindow;
    }
    return nil;
}

+ (id)alloc
{
    @synchronized([ErrorWindow class])
    {
        NSAssert(sharedErrorWindow == nil, @"Attempted to allocate a second instance of a singleton.");
        sharedErrorWindow = [super alloc];
        return sharedErrorWindow;
    }
    return nil;
}

#pragma mark - Private Methods

- (NSString *)errorMessage:(NSString *)errorCode
{
    return [errorData objectForKey:errorCode];
}

- (void)refresh
{
    NSInteger errorListCount = [errorList count];
    if (errorListCount != 0 || [[mainView subviews] count] != 0)
    {
        NSArray *viewsToRemove = [mainView subviews];
        for (UIView *view in viewsToRemove) {
            [view removeFromSuperview];
        }
        
        lastErrorViewFrame = CGRectMake(0, 0, 0, 0);
        
        for (NSInteger i = 0; i < errorListCount; i++) {
            NSInteger invert_i = errorListCount - 1 - i;
            [self createErrorBody:invert_i];
        }
        
        [mainView setFrame:CGRectMake(mainView.frame.origin.x, mainView.frame.origin.y, mainView.frame.size.width, lastErrorViewFrame.origin.y + lastErrorViewFrame.size.height)];
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, lastErrorViewFrame.origin.y + lastErrorViewFrame.size.height + self.frame.origin.y)];
    }
    else
    {
        [self removeFromSuperview];
    }
    
}

- (void)createErrorBody:(NSInteger)i
{
    NSString *errorText = [self errorMessage:[errorList objectAtIndex:i]];
    UIFont *errorTitleFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:10.0];
    CGSize titleSize = [errorText sizeWithFont:errorTitleFont constrainedToSize:CGSizeMake(kErrorTitleWidth, 999) lineBreakMode:NSLineBreakByWordWrapping];
    
    UIView *errorView = [[UIView alloc] init];
    errorView.layer.cornerRadius = 7.0;
    errorView.layer.masksToBounds = YES;
    [errorView setBackgroundColor:[UIColor blackColor]];
    [errorView setAlpha:.75];
    [errorView setFrame:CGRectMake(0, lastErrorViewFrame.origin.y + lastErrorViewFrame.size.height + 3, mainView.frame.size.width, titleSize.height + 2 * 2)];
    
    UILabel *errorTitle = [[UILabel alloc] init];
    [errorTitle setTextColor:[UIColor whiteColor]];
    [errorTitle setNumberOfLines:0];
    [errorTitle setFont:errorTitleFont];
    [errorTitle setText:errorText];
    [errorTitle setFrame:CGRectMake(25, 1, kErrorTitleWidth, titleSize.height)];
    [errorView addSubview:errorTitle];
    
    UIImageView *errorIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"errorIcon"]];
    [errorIcon setFrame:CGRectMake(3, 2, 12, 12)];
    [errorView addSubview:errorIcon];
    
    [mainView addSubview:errorView];
    
    lastErrorViewFrame = errorView.frame;
}

- (void)removeOldestErrorMessage
{
    if ([errorList count] > 0) {
        [errorList removeObjectAtIndex:0];
        [self refresh];
    }
    else
    {
        if (removeMasageTimer != nil)
        {
            [removeMasageTimer invalidate];
            removeMasageTimer = nil;
        }
    }
}

#pragma mark - Interface Method

- (void)addError:(ErrorType)errorCode
{
    errorCode = ErrNetworkConnectionError;
    BOOL isErrorCodeExist = NO;
    for (NSString *code in errorList) {
        if ([[NSString stringWithFormat:@"%i", errorCode] isEqualToString:code])
            isErrorCodeExist = YES;
    }
    
    if (!isErrorCodeExist) {
        [errorList addObject:[NSString stringWithFormat:@"%i", errorCode]];
        [self refresh];
        if (removeMasageTimer == nil)
            removeMasageTimer = [NSTimer scheduledTimerWithTimeInterval:kRemoveMasageTimerInterval target:self selector:@selector(removeOldestErrorMessage) userInfo:nil repeats:YES];
    }
}

- (void)removeError:(ErrorType)errorCode
{
    errorCode = ErrNetworkConnectionError;
    NSInteger errorListCount = [errorList count];
    for (NSInteger i = 0; i < errorListCount; i++) {
        if ([[NSString stringWithFormat:@"%i", errorCode] isEqualToString:[errorList objectAtIndex:i]])
        {
            [errorList removeObjectAtIndex:i];
            [self refresh];
            return;
        }
    }
}

- (void)closeErrorWindow
{
    [errorList removeAllObjects];
    if (removeMasageTimer != nil)
    {
        [removeMasageTimer invalidate];
        removeMasageTimer = nil;
    }
    [self refresh];
    [self removeFromSuperview];
}

@end