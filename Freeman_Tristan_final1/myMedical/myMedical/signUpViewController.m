//
//  signUpViewController.m
//  myMedical
//
//  Created by Tristan Freeman on 11/5/13.
//  Copyright (c) 2013 Tristan Freeman. All rights reserved.
//

#import "signUpViewController.h"
#import "ViewController.h"
#import "MedListViewController.h"

@interface signUpViewController ()

@end

@implementation signUpViewController

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
    self.view.backgroundColor = [UIColor colorWithRed:0.929 green:0.91 blue:0.694 alpha:1]; /*#ede8b1*/
    
    //Add tap gesture to resign the keyboard
    UITapGestureRecognizer *onTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignKeyboard)];
    onTap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:onTap];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

// Resigns keyboard from tap gesture
-(void) resignKeyboard
{
    [self.view endEditing:YES];
}

// handles user canceling registration
-(IBAction)onCancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
// action for registration submit calls checkFields method
-(IBAction)onRegisterSubmit:(id)sender
{
    [self checkFields];
    
}
// method checks to see if fields are empty and alerts user if information is missing
-(void)checkFields
{
    if ([registerName.text isEqualToString:@""] || [registerPass.text isEqualToString:@""] || [registerRePass.text isEqualToString:@""] || [registerEmail.text isEqualToString:@""]) {
        UIAlertView *fieldsAlert = [[UIAlertView alloc]initWithTitle:@"Missing Information!" message:@"Please complete all fields" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [fieldsAlert show];
    }else{
        // if fields are complete, checks to see if passwords match
        [self checkPasswordsMatch];
    }
}
//method to check that passwords match
-(void)checkPasswordsMatch
{
    //checks to see if register password field matches password re-entry field and alert if they don't match
    if (![registerPass.text isEqualToString:registerRePass.text]) {
        UIAlertView *noMatch = [[UIAlertView alloc]initWithTitle:@"Password Error" message:@"Passwords to not match." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [noMatch show];
    }else{
        //if passwords match, calls registerNewUser
        [self registerNewUser];
    }
}
// method to create new user
-(void)registerNewUser
{
    //creates new PFUser
    PFUser *newUser = [PFUser user];
    //saves username, password, and email as user inputted text
    newUser.username = registerName.text;
    newUser.password = registerPass.text;
    newUser.email = registerEmail.text;
    //signs up user in background and if successful, dismisses registration view
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSLog(@"Registration Succedded!");
           
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            UIAlertView *registerError = [[UIAlertView alloc]initWithTitle:@"Registration Failed" message:@"There was an error in registration" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [registerError show];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
