//
//  AppDelegate.h
//  MoviePrototype1
//
//  Created by TIVA on 10/19/16.
//  Copyright © 2016 TIVA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

