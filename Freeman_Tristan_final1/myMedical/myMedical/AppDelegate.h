//
//  AppDelegate.h
//  myMedical
//
//  Created by Tristan Freeman on 11/5/13.
//  Copyright (c) 2013 Tristan Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;
@property (nonatomic, strong) UITabBarController *tabBarController;
@property (nonatomic, strong) UITabBarController *medTabBar;

@end
