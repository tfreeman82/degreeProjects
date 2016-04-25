//
//  pharmacyViewController.h
//  myMedical
//
//  Created by Tristan Freeman on 11/5/13.
//  Copyright (c) 2013 Tristan Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "mapAnnotations.h"

#define kGOOGLE_API_KEY @"AIzaSyDg-_JQ_xMNtr0JxB74eoZ-YD1N9z6qQgc"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)


@interface pharmacyViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>
{
    
    
    CLLocationManager *locationManager;

    int currentDist;
    BOOL firstLaunch;
    CLLocationCoordinate2D currentLocation;
    
}
@property (nonatomic, strong)IBOutlet MKMapView *pharmaMap;


-(IBAction)onSearch:(id)sender;

@end
