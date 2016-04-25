//
//  signUpViewController.h
//  myMedical
//
//  Created by Tristan Freeman on 11/5/13.
//  Copyright (c) 2013 Tristan Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "ViewController.h"
@interface signUpViewController : UIViewController <UITextFieldDelegate>
{

 IBOutlet UITextField *registerPass;
 IBOutlet UITextField *registerRePass;
 IBOutlet UITextField *registerName;
 IBOutlet UITextField *registerEmail;

}

-(IBAction)onRegisterSubmit:(id)sender;
-(IBAction)onCancel:(id)sender;

@end
