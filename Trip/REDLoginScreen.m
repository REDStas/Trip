//
//  REDLoginScreen.m
//  Trip
//
//  Created by Станислав Редреев on 06.03.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import "REDLoginScreen.h"

#import "REDValidation.h"
#import "ErrorWindow.h"

@interface REDLoginScreen ()
{
    IBOutlet UIImageView *backgroundAnimationView;
    
    IBOutlet UILabel *headerLoginLabel;
    IBOutlet UITextField *userNameEmailTextField;
    IBOutlet UITextField *passwordTextField;
    IBOutlet UISwitch *autosaveCheckbox;
    IBOutlet UILabel *autosaveLabel;
    IBOutlet UIButton *loginButton;
    
    IBOutlet UILabel *registrationLabel;
    IBOutlet UIButton *registrationButton;
    
    REDValidation *validationService;
    ErrorWindow *errorWindow;
}

- (IBAction)pressLoginButton:(id)sender;
- (IBAction)pressRegistrationButton:(id)sender;

@end

@implementation REDLoginScreen

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    validationService = [REDValidation sharedValidationService];
    errorWindow = [ErrorWindow sharedErrorWindow];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:errorWindow];
    [self customizeElements];
    //[self.view addSubview:errorWindow];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customizeElements
{
    backgroundAnimationView.animationImages = [NSArray arrayWithObjects:
                                         [UIImage imageNamed:@"1bg.png"],
                                         //[UIImage imageNamed:@"image2.gif"],
                                         //[UIImage imageNamed:@"image3.gif"],
                                         [UIImage imageNamed:@"2bg.png"], nil];
    backgroundAnimationView.animationDuration = 5.0f;
    backgroundAnimationView.animationRepeatCount = 0;
    [backgroundAnimationView startAnimating];
    
    
    
    [UIView
     animateWithDuration:5.0f
     delay:1000
     options:UIViewAnimationOptionTransitionCrossDissolve
     animations:^{
         backgroundAnimationView.alpha = 0;
         backgroundAnimationView.alpha = 1;
     }
     completion:^(BOOL finished){
         //backgroundAnimationView.hidden = YES;
     }
     ];
    

//    [UIView transitionWithView:backgroundAnimationView duration:5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
//        backgroundAnimationView.image = [UIImage imageNamed:@"1bg.png"];
//    } completion:^(BOOL done){
//        [UIView transitionWithView:backgroundAnimationView duration:5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
//            backgroundAnimationView.image = [UIImage imageNamed:@"2bg.png"];
//        } completion:^(BOOL done){
//            [UIView transitionWithView:backgroundAnimationView duration:5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
//                backgroundAnimationView.image = [UIImage imageNamed:@"1bg.png"];
//            } completion:^(BOOL done){
//            }];
//        }];
//    }];
}


#pragma mark - Keyboard Delegate

-(void)keyboardWillAppear {
    // Move current view up / down with Animation
    if (self.view.frame.origin.y >= 0)
    {
        [self moveViewUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self moveViewUp:NO];
    }
}

-(void)keyboardWillDisappear {
    if (self.view.frame.origin.y >= 0)
    {
        [self moveViewUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self moveViewUp:NO];
    }
}

-(void)moveViewUp:(BOOL)bMovedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.4]; // to slide the view up
    
    CGRect rect = self.view.frame;
    if (bMovedUp) {
        // 1. move the origin of view up so that the text field will come above the keyboard
        rect.origin.y -= 60.0;
        
        // 2. increase the height of the view to cover up the area behind the keyboard
        //rect.size.height += 60.0;
    } else {
        // revert to normal state of the view.
        rect.origin.y += 60.0;
        //rect.size.height -= 60.0;
    }
    
    self.view.frame = rect;
    
    [UIView commitAnimations];
}

#pragma mark - IBOutlets

- (IBAction)pressLoginButton:(id)sender {
    if (![validationService validationText:userNameEmailTextField.text withValidationType:ValidationEmail]) {
        [errorWindow addError:ErrValidationIncorrectEmail];
        //[errorWindow re]
    }
    if (![validationService validationText:userNameEmailTextField.text withValidationType:ValidationPassword]) {
        [errorWindow addError:ErrValidationIncorrectPassword];
    }
}

- (IBAction)pressRegistrationButton:(id)sender {
}
@end
