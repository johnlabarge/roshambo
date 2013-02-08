//
//  AppDelegate.h
//  roshambo
//
//  Created by La Barge, John on 2/6/13.
//  Copyright (c) 2013 La Barge, John. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "TransitionController.h"

@interface RoshamboAppDelegate : UIResponder <UIApplicationDelegate> {
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
}
- (NSManagedObjectContext *) managedObjectContext;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) TransitionController *transitionController;

@end
