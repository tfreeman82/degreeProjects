//
//  medicationDetailsViewController.h
//  myMedical
//
//  Created by Tristan Freeman on 11/5/13.
//  Copyright (c) 2013 Tristan Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "medicationManager.h"
#import "medInfo.h"
#import "medListControllerViewController.h"

@interface medicationDetailsViewController : UIViewController
{
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *formLabel;
    IBOutlet UILabel *strengthLabel;
    IBOutlet UILabel *qtyLabel;
    IBOutlet UILabel *takenLabel;
    IBOutlet UILabel *rxLabel;
    IBOutlet UILabel *prescriberLabel;
    IBOutlet UILabel *notesLabel;
  
    medInfo *details;
    
    
}
@property (nonatomic, strong)IBOutlet UILabel *nameLabel;
@property (nonatomic, strong)IBOutlet UILabel *formLabel;
@property (nonatomic, strong)IBOutlet UILabel *strengthLabel;
@property (nonatomic, strong)IBOutlet UILabel *qtyLabel;
@property (nonatomic, strong)IBOutlet UILabel *takenLabel;
@property (nonatomic, strong)IBOutlet UILabel *rxLabel;
@property (nonatomic, strong)IBOutlet UILabel *prescriberLabel;
@property (nonatomic, strong)IBOutlet UILabel *notesLabel;
@property (nonatomic, strong)medInfo *details;
@property (nonatomic, strong)PFObject *receivedObject;
@property (nonatomic, strong)NSMutableArray *receivedObjects;
@property (nonatomic, strong)NSMutableDictionary *recievedDictionary;

-(IBAction)onBack:(id)sender;


@end
