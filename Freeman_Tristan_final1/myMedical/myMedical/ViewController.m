//
//  ViewController.m
//  myMedical
//
//  Created by Tristan Freeman on 11/5/13.
//  Copyright (c) 2013 Tristan Freeman. All rights reserved.
//

#import "ViewController.h"
#import "medListControllerViewController.h"
#import "signUpViewController.h"
#import <Parse/Parse.h>

@interface ViewController ()

@end

@implementation ViewController
@synthesize loginName, loginPass;

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor colorWithRed:0.929 green:0.91 blue:0.694 alpha:1]; /*#ede8b1*/
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Add tap gesture to resign the keyboard
    UITapGestureRecognizer *onTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignKeyboard)];
    onTap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:onTap];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

// Resigns keyboard from tap gesture
-(void) resignKeyboard
{
    [self.view endEditing:YES];
}

- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {

    
    medListControllerViewController *medListViewController = [[medListControllerViewController alloc]initWithNibName:@"medListControllerViewController" bundle:nil];
    //[self dismissViewControllerAnimated:YES completion:NULL];
        
    [self presentViewController:medListViewController animated:YES completion:nil];
   
    
}
//action for logging user into app
-(IBAction)onLogin:(id)sender
{
    //logs user into app in background with user input
    [PFUser logInWithUsernameInBackground:loginName.text password:loginPass.text block:^(PFUser *user, NSError *error) {
        if (!error) {
            NSLog(@"Log-in Successful!");
            loginName.text = nil;
            loginPass.text = nil;

            [self dismissViewControllerAnimated:YES completion:nil];
           
        }else{
            UIAlertView *loginAlert = [[UIAlertView alloc]initWithTitle:@"Login Error" message:@"Please check your username and password" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [loginAlert show];
        }
    }];
}
//action for registering new user
-(IBAction)onSignUp:(id)sender
{
    signUpViewController *signUpView = [[signUpViewController alloc]initWithNibName:@"signUpViewController" bundle:nil];
    if (signUpView !=nil) {
        [self presentViewController:signUpView animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
