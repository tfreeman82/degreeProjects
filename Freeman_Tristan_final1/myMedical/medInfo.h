//
//  medInfo.h
//  myMedical
//
//  Created by Tristan Freeman on 11/13/13.
//  Copyright (c) 2013 Tristan Freeman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface medInfo : PFObject <PFSubclassing>
{
    NSString *nameOfMed;
    NSString *medForm;
    NSString *medStrength;
    NSString *medQty;
    NSString *medTaken;
    NSString *medRx;
    NSString *medScriber;
    NSString *medNotes;
}
+ (NSString *)parseClassName;

-(id)initWithMedName:(NSString*)name form:(NSString*)form strength:(NSString*)strength qty:(NSString*)qty taken:(NSString*)taken rx:(NSString*)rx scriber:(NSString*)scriber notes:(NSString*)notes;

@property(retain)NSString *nameOfMed;
@property(retain)NSString *medForm;
@property(retain)NSString *medStrength;
@property(retain)NSString *medQty;
@property(retain)NSString *medTaken;
@property(retain)NSString *medRx;
@property(retain)NSString *medScriber;
@property(retain)NSString *medNotes;

@end
