//
//  addMedicationViewController.h
//  myMedical
//
//  Created by Tristan Freeman on 11/6/13.
//  Copyright (c) 2013 Tristan Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addMedicationViewController : UIViewController
{
    IBOutlet UITableView *addMedTable;
    IBOutlet UITextField *medName;
    IBOutlet UITextField *medForm;
    IBOutlet UITextField *medStrength;
    IBOutlet UITextField *medQty;
    IBOutlet UITextField *medTaken;
    IBOutlet UITextField *medRx;
    IBOutlet UITextField *medScriber;
    IBOutlet UITextField *medNotes;
    
}

-(IBAction)onCancel:(id)sender;
-(IBAction)onSave:(id)sender;

@end
