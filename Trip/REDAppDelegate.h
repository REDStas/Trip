//
//  REDAppDelegate.h
//  Trip
//
//  Created by Станислав Редреев on 11.02.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "REDStartPage.h"
#import "REDPopUp.h"

@interface REDAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
