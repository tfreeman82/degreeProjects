//
//  mapAnnotations.h
//  myMedical
//
//  Created by Tristan Freeman on 11/14/13.
//  Copyright (c) 2013 Tristan Freeman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface mapAnnotations : NSObject <MKAnnotation>
{
    
    NSString *name;
    NSString *address;
    CLLocationCoordinate2D coordinate;
    
}

@property (copy) NSString *name;
@property (copy) NSString *address;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate;

@end
