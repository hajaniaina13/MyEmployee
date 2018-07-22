//
//  AppDelegate.h
//  MyStore
//
//  Created by ensor_mac on 22/07/2018.
//  Copyright © 2018 ensor_mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

