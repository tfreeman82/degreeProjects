//
//  AppDelegate.m
//  myMedical
//
//  Created by Tristan Freeman on 11/5/13.
//  Copyright (c) 2013 Tristan Freeman. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import <GoogleMaps/GoogleMaps.h>
#import "ViewController.h"
#import "medListControllerViewController.h"
#import "pharmacyViewController.h"
#import "medInfo.h"
#import "medicationManager.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [GMSServices provideAPIKey:@"AIzaSyDxV2MZR0bMDQLIRBdt0e6w95GMuX5BwBs"];
    [medInfo registerSubclass];
    [Parse setApplicationId:@"x9nq9DmjymmvyTRNksAjZxiE8XDlxG6PiKsKCFWj" clientKey:@"Jc0kZcthPpqmmNL0uLGN1IHdAtQ4NCuyhJT7iEJh"];
    
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];

   
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    //UIViewController *viewController1 = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
    //UINavigationController *mainNav = [[UINavigationController alloc]initWithRootViewController:viewController1];
    
    //UIViewController *viewcontroller2 = [[MedListViewController alloc]initWithNibName:@"MedListViewController" bundle:nil];
    
    UIViewController *viewController3 = [[pharmacyViewController alloc]initWithNibName:@"pharmacyViewController" bundle:nil];
    
    medListControllerViewController *tableController = [[medListControllerViewController alloc]init];
    
    
    UINavigationController *medNav = [[UINavigationController alloc]initWithRootViewController:tableController];
    
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:0.788 green:0.682 blue:0.553 alpha:1] /*#c9ae8d*/];
     [[UITabBar appearance]setTintColor:[UIColor colorWithRed:0.788 green:0.682 blue:0.553 alpha:1] /*#c9ae8d*/];
    //UINavigationController *pharmaNav = [[UINavigationController alloc]initWithRootViewController:viewController3];
    [[UITabBarItem appearance] setTitleTextAttributes:@{UITextAttributeTextColor: [UIColor blackColor]} forState:UIControlStateNormal];
        self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    self.tabBarController = [[UITabBarController alloc]init];
        
    self.tabBarController.viewControllers = @[medNav, viewController3];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
