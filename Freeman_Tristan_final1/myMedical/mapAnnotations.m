//
//  mapAnnotations.m
//  myMedical
//
//  Created by Tristan Freeman on 11/14/13.
//  Copyright (c) 2013 Tristan Freeman. All rights reserved.
//

#import "mapAnnotations.h"

@implementation mapAnnotations
@synthesize name, address, coordinate;

- (id)initWithName:(NSString*)locName address:(NSString*)locAddress coordinate:(CLLocationCoordinate2D)locCoordinate
{
    if ((self = [super init])) {
        name = locName;
        address = locAddress;
        coordinate = locCoordinate;
    }
    return self;
}
-(NSString*)title{
    if ([name isKindOfClass:[NSNull class]]) 
        return @"Unkown charge";
    else
        return name;
}

-(NSString*)subtitle{
    return address;
}
@end
