//
//  medicationDetailsViewController.m
//  myMedical
//
//  Created by Tristan Freeman on 11/5/13.
//  Copyright (c) 2013 Tristan Freeman. All rights reserved.
//

#import "medicationDetailsViewController.h"
#import "medListControllerViewController.h"
#import "medInfo.h"
#import "medicationManager.h"

@interface medicationDetailsViewController ()

@end

@implementation medicationDetailsViewController
@synthesize nameLabel, formLabel, strengthLabel, qtyLabel, takenLabel, rxLabel, prescriberLabel, notesLabel;
@synthesize details, recievedDictionary;

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
    // creates string for each key in recievedDictionary
    NSString *name = [recievedDictionary objectForKey:@"name"];
    NSString *form = [recievedDictionary objectForKey:@"form"];
    NSString *strength = [recievedDictionary objectForKey:@"strength"];
    NSString *qty = [recievedDictionary objectForKey:@"quantity"];
    NSString *taken = [recievedDictionary objectForKey:@"taken"];
    NSString *rx = [recievedDictionary objectForKey:@"rxNumber"];
    NSString *scriber = [recievedDictionary objectForKey:@"scriber"];
    NSString *notes = [recievedDictionary objectForKey:@"notes"];
    
    
        //assigns labels as each saved string
        nameLabel.text = name;
        formLabel.text = form;
        strengthLabel.text = strength;
        qtyLabel.text = qty;
        takenLabel.text = taken;
        rxLabel.text = rx;
        prescriberLabel.text = scriber;
        notesLabel.text = notes;
        
    
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


-(IBAction)onBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
