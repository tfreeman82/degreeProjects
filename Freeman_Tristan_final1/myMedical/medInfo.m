//
//  medInfo.m
//  myMedical
//
//  Created by Tristan Freeman on 11/13/13.
//  Copyright (c) 2013 Tristan Freeman. All rights reserved.
//

#import "medInfo.h"
#import <Parse/PFObject+Subclass.h>

@implementation medInfo
@dynamic nameOfMed, medForm, medStrength, medQty, medTaken, medRx, medScriber, medNotes;

+ (NSString *)parseClassName {
    return @"Medication";
}

-(id)initWithMedName:(NSString*)name form:(NSString*)form strength:(NSString*)strength qty:(NSString*)qty taken:(NSString*)taken rx:(NSString*)rx scriber:(NSString*)scriber notes:(NSString*)notes
{
    if ((self = [super init])) {
        nameOfMed = name;
        medForm = form;
        medStrength = strength;
        medQty = qty;
        medTaken = taken;
        medRx = rx;
        medScriber = scriber;
        medNotes = notes;
    }
    return self;
}
@end
