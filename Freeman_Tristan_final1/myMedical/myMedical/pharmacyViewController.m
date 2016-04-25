//
//  pharmacyViewController.m
//  myMedical
//
//  Created by Tristan Freeman on 11/5/13.
//  Copyright (c) 2013 Tristan Freeman. All rights reserved.
//

#import "pharmacyViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "mapAnnotations.h"

@interface pharmacyViewController ()

@end

@implementation pharmacyViewController 
@synthesize pharmaMap;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Pharmacy Locator";
        self.tabBarController.tabBarItem.title = @"Pharmacy Locator";
        self.tabBarItem.image = [UIImage imageNamed:@"74-location.png"];
    }
    return self;
}

- (void)viewDidLoad
{
    
    
    //make this controller the map view delegate
    self.pharmaMap.delegate = self;
    // set up own location on map
    [self.pharmaMap setShowsUserLocation:YES];
    
    locationManager = [[CLLocationManager alloc]init];
    
    //make this controller the location manager delegate
    [locationManager setDelegate:self];
    // sets distance filter to none
    [locationManager setDistanceFilter:kCLDistanceFilterNone];
    //sets accuracy to best
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    self.tabBarController.tabBarItem.image = [UIImage imageNamed:@"74-location.png"];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    

    firstLaunch = YES;
    }
//IBAction for pharmacy search
-(IBAction)onSearch:(id)sender
{
    //creates sender pointer for UIBarButtonItem
    UIBarButtonItem *button = (UIBarButtonItem*)sender;
    //converts button title to lower case string and saves as NSString
    NSString *buttonTitle = [button.title lowercaseString];
    //callse queryGooglePlaces and uses button title as search param
   [self queryGooglePlaces:buttonTitle];   
}

-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views{
    
    CLLocationCoordinate2D center = [mapView centerCoordinate];
    
    MKCoordinateRegion region;
    //if the first launch of app, zoom into user location
    if (firstLaunch) {
        region = MKCoordinateRegionMakeWithDistance(locationManager.location.coordinate, 1000, 1000);
        firstLaunch = NO;
    }else{
        region = MKCoordinateRegionMakeWithDistance(center, currentDist, currentDist);
    }
    
    [mapView setRegion:region animated:YES];
}

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    //sets up visible area of map
    MKMapRect mRect = self.pharmaMap.visibleMapRect;
    //calculates east point of map
    MKMapPoint eastPoint = MKMapPointMake(MKMapRectGetMinX(mRect), MKMapRectGetMidY(mRect));
    //calculates west point of map
    MKMapPoint westPoint = MKMapPointMake(MKMapRectGetMaxX(mRect), MKMapRectGetMidY(mRect));
    
    //saves currentDist as meters between east and west map points
    currentDist = MKMetersBetweenMapPoints(eastPoint, westPoint);
    currentLocation = self.pharmaMap.centerCoordinate;
}
// Queries google places
-(void)queryGooglePlaces:(NSString*)googleType {
    // saves url as string
    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=50000&types=%@&sensor=true&key=%@", currentLocation.latitude, currentLocation.longitude, googleType, kGOOGLE_API_KEY];
    //saves string as NSURL
    NSURL *requestURL = [NSURL URLWithString:url];

    // asynchronous call on background to fetch data
    dispatch_async(kBgQueue, ^{
    NSData *data = [NSData dataWithContentsOfURL:requestURL];
        if (data !=nil) {
            //calls retrievedData method to run on main thread with url 
            [self performSelectorOnMainThread:@selector(retrievedData:) withObject:data waitUntilDone:YES];
        }else{
            NSLog(@"Something went wrong.");
        }

         
    });
   
}

-(void)viewDidUnload{
    [self setPharmaMap:nil];
    [super viewDidUnload];
}
// method to retrieve data and save as an array
-(void)retrievedData:(NSData*)response
{
    NSError *error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:response
                          options:kNilOptions
                          error:&error];
    
    NSArray* locations = [json objectForKey:@"results"];
    NSLog(@"Google Data: %@", locations);
    [self plotLocations:locations];
}

-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString *ident = @"MapPoint";
    
    //checks to see if the annotation is of the mapAnnotations class. If it is, the resusable annotation view is called.
    if([annotation isKindOfClass:[mapAnnotations class]]){
        MKPinAnnotationView *annotationView = (MKPinAnnotationView*) [self.pharmaMap dequeueReusableAnnotationViewWithIdentifier:ident];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:ident];
        }else{
            annotationView.annotation = annotation;
        }
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        annotationView.animatesDrop = YES;
        return annotationView;
    }
    return nil;
}
// method to plot locations on map
-(void)plotLocations:(NSArray*)data
{
    //loops through annotations and checks to see if annotation is mapAnnotations class
    for (id<MKAnnotation> annotation in pharmaMap.annotations){
        if ([annotation isKindOfClass:[mapAnnotations class]]) {
            [pharmaMap removeAnnotation:annotation];
        }
    }
    //loops through data and saves annotation information in dictionaries and strings
    for (int i=0; i<[data count]; i++){
        NSDictionary *place = [data objectAtIndex:i];
        
        NSDictionary *geometry = [place objectForKey:@"geometry"];
        
        NSDictionary *location = [geometry objectForKey:@"location"];
        
        NSString *name = [place objectForKey:@"name"];
        NSString *vicinity = [place objectForKey:@"vicinity"];
        
        CLLocationCoordinate2D placeCoord;
        
        placeCoord.latitude = [[location objectForKey:@"lat"]doubleValue];
        placeCoord.longitude = [[location objectForKey:@"lng"]doubleValue];
        //calls custom annotations object and assigns values
        mapAnnotations *placeObj = [[mapAnnotations alloc]initWithName:name address:vicinity coordinate:placeCoord];
        [pharmaMap addAnnotation:placeObj];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
