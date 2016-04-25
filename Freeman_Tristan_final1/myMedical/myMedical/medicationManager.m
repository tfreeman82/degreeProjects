//
//  medicationManager.m
//  myMedical
//
//  Created by Tristan Freeman on 11/6/13.
//  Copyright (c) 2013 Tristan Freeman. All rights reserved.
//

#import "medicationManager.h"
#import <Parse/Parse.h>
#import "medicationDetailsViewController.h"
#import "medListControllerViewController.h"

@implementation medicationManager

@synthesize medicationArray;

static medicationManager* _instance = nil;

+(medicationManager*)getData{
    if (_instance == nil) {
        _instance = [[self alloc]init];
    }
    return _instance;
}

-(id)init
{
    if ((self = [super init]))
    {
        medicationArray = [[NSMutableArray alloc]init];
    }
   return self;
}

@end
