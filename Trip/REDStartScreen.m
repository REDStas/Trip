//
//  REDStartPage.m
//  Trip
//
//  Created by Станислав Редреев on 11.02.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import "REDStartScreen.h"
#import "API.h"

@interface REDStartScreen ()
{
    ErrorWindow *errorWindow;
}

- (IBAction)pressButton:(id)sender;
- (IBAction)login:(id)sender;

@end

@implementation REDStartScreen

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressButton:(id)sender {
//    self.otherWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    self.popUp = [[REDPopUp alloc] initWithNibName:@"REDPopUp" bundle:nil];
//    //otherWindow.hidden = NO;
//    self.otherWindow.rootViewController = self.popUp;
//    self.otherWindow.clipsToBounds = YES;
//    self.otherWindow.windowLevel = UIWindowLevelStatusBar;
//    //self.otherWindow.backgroundColor = [UIColor redColor];
//    [self.otherWindow makeKeyAndVisible];
//    [[API sharedAPI] singUpwWithEmail:@"test@gmail.com" password:@"12345" success:^(id JSON) {
//        NSLog(@"%@", JSON);
//    } error:^(id ERROR) {
//
//    }];]
    
    //[errorWindow closeErrorWindow];
    
}

- (IBAction)login:(id)sender {
    loginScreen = [[REDLoginScreen alloc] initWithNibName:@"REDLoginScreen" bundle:nil];
    [self presentViewController:loginScreen animated:YES completion:^{
        
    }];
    
//    errorWindow = [ErrorWindow sharedErrorWindow];
//    [self.view addSubview:errorWindow];
//    [errorWindow addError:ErrEmptyTextField];
}
@end
