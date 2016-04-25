//
//  medListControllerViewController.h
//  myMedical
//
//  Created by Tristan Freeman on 11/11/13.
//  Copyright (c) 2013 Tristan Freeman. All rights reserved.
//

#import <Parse/Parse.h>
#import "medicationManager.h"

@interface medListControllerViewController : PFQueryTableViewController
{
    NSArray *medArray;
    NSMutableDictionary *medDictionary;
    NSMutableDictionary *detailDictionary;
    NSMutableArray *meds;
    NSDictionary *receivedDict;
       
}
@property (nonatomic, strong)NSMutableArray *meds;
@property (nonatomic, strong)NSMutableDictionary *medDictionary;
@property (nonatomic, strong)NSMutableDictionary *detailDictionary;
@property (nonatomic, strong)NSMutableArray *allObjects;

@end
