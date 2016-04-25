//
//  medicationManager.h
//  myMedical
//
//  Created by Tristan Freeman on 11/6/13.
//  Copyright (c) 2013 Tristan Freeman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface medicationManager : NSObject
{
    NSMutableArray *medicationArray;
    
}
+(medicationManager*)getData;

@property (nonatomic, retain)NSMutableArray *medicationArray;
@end
