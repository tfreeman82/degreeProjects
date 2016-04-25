//
//  ViewController.h
//  myMedical
//
//  Created by Tristan Freeman on 11/5/13.
//  Copyright (c) 2013 Tristan Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>
{
    IBOutlet UITextField *loginName;
    IBOutlet UITextField *loginPass;
}
-(IBAction)onLogin:(id)sender;
-(IBAction)onSignUp:(id)sender;

@property (nonatomic, strong)IBOutlet UITextField *loginName;
@property (nonatomic, strong)IBOutlet UITextField *loginPass;

@end
