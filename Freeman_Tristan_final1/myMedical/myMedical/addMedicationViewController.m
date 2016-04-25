//
//  addMedicationViewController.m
//  myMedical
//
//  Created by Tristan Freeman on 11/6/13.
//  Copyright (c) 2013 Tristan Freeman. All rights reserved.
//

#import "addMedicationViewController.h"
#import <Parse/Parse.h>
#import "medListControllerViewController.h"

@interface addMedicationViewController ()

@end

@implementation addMedicationViewController

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
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //Add tap gesture to resign the keyboard
    UITapGestureRecognizer *onTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignKeyboard)];
    onTap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:onTap];
}

// Resigns keyboard from tap gesture
-(void) resignKeyboard
{
    [self.view endEditing:YES];
}
//handles cancel action
-(IBAction)onCancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//handles save action
-(IBAction)onSave:(id)sender
{
    //alerts user that medication was saved
    UIAlertView *savedAlert = [[UIAlertView alloc]initWithTitle:@"Success!" message:@"Your medication info was saved" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    //created PFObject with class name "Medication" and sets user input as specific key
    PFObject *newObject = [PFObject objectWithClassName:@"Medication"];
    [newObject setObject:medName.text forKey:@"name"];
    [newObject setObject:medForm.text forKey:@"form"];
    [newObject setObject:medStrength.text forKey:@"strength"];
    [newObject setObject:medQty.text forKey:@"quantity"];
    [newObject setObject:medTaken.text forKey:@"taken"];
    [newObject setObject:medRx.text forKey:@"rxNumber"];
    [newObject setObject:medScriber.text forKey:@"scriber"];
    [newObject setObject:medNotes.text forKey:@"notes"];
    //checks for nil and saves in background
    if (newObject !=nil) {
        [newObject saveInBackground];
        [savedAlert show];
        [self dismissViewControllerAnimated:YES completion:nil];

    }else{
        NSLog(@"There was an error saving.");
    }
    }


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
