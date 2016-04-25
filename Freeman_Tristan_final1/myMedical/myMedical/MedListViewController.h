//
//  MedListViewController.h
//  myMedical
//
//  Created by Tristan Freeman on 11/5/13.
//  Copyright (c) 2013 Tristan Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MedListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *medTable;
    NSMutableArray *medArray;
}

-(IBAction)onLogOut:(id)sender;
-(IBAction)onAddMed:(id)sender;

@property NSMutableArray *medName, *medStrength, *medForm;

@end
