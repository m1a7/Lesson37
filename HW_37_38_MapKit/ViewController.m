//
//  ViewController.m
//  HW_37_38_MapKit
//
//  Created by MD on 11.07.15.
//  Copyright (c) 2015 MD. All rights reserved.
//

#import "ViewController.h"
#import "ASStudent.h"
#import "ASNameFamalyAndImage.h"
#import "ASDetailViewController.h"
#import "UIView+MKAnnotationView.h"

@interface ViewController ()


@property (strong, nonatomic) CLLocationManager* locationManager;
@property (strong, nonatomic) CLLocation*        location;
@property (strong, nonatomic) NSMutableArray* arrayStudents;

@property (strong, nonatomic)  UIPopoverController*   popover;
@property (strong, nonatomic) CLGeocoder* geoCoder;

@end




@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

 
    [self showUserLocation:self.mapView andLocationManager:self.locationManager];


    ASNameFamalyAndImage* obj = [[ASNameFamalyAndImage alloc] init];

    
    for (int i=0; i<=10; i++) {
        NSString* name   = [obj.arrayNames objectAtIndex:   arc4random()%[obj.arrayNames count]];
        NSString* famaly = [obj.arrayFamaly objectAtIndex:  arc4random()%[obj.arrayFamaly count]];
        
        ASStudent* std = [[ASStudent alloc] initWithName:name andFamaly:famaly andUserLocation: self.locationManager.location];
        [self.mapView addAnnotation:std];
    }
    obj = nil;

    UIBarButtonItem* zoomButton =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                  target:self action:@selector(actionShowAll:)];

    self.navigationItem.rightBarButtonItem = zoomButton;
    //[self actionShowAll:nil];
    self.geoCoder = [[CLGeocoder alloc] init];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    static NSString* identifier = @"Annotation";
    
    MKAnnotationView* pin = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if (!pin) {
       
        pin = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];

        __weak ASStudent *weakSelf = annotation;
        
        if ([weakSelf isKindOfClass:[ASStudent class]] && ![weakSelf.image isEqual:nil]) {
            pin.image = weakSelf.image;
       
        }
        
        UIButton* infoButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [infoButton addTarget:self action:@selector(actionInfo:) forControlEvents:UIControlEventTouchUpInside];
        
        pin.rightCalloutAccessoryView = infoButton;
        pin.canShowCallout = YES;
        pin.draggable = YES;

    } else {
        pin.annotation = annotation;
    }

return pin;
}






- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState
   fromOldState:(MKAnnotationViewDragState)oldState {
    

    if (newState == MKAnnotationViewDragStateStarting) {
        
        [UIView animateWithDuration:0.2f
                              delay:0
                            options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             
                             view.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
                             view.alpha     = 0.5f;
                             
                         }
                         completion:nil];
    } else
        if ((newState == MKAnnotationViewDragStateCanceling) || (newState == MKAnnotationViewDragStateEnding)) {
            
            [UIView animateWithDuration:0.25f
                                  delay:0
                                options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                             animations:^{
                                 
                                 view.transform = CGAffineTransformMakeScale(1.f, 1.f);
                                 view.alpha     = 1.f;
                                 
                             }
                             completion:^(BOOL finished) {
                                 view.dragState = MKAnnotationViewDragStateNone;
                             }];
        }
    
}






#pragma mark - User Location

-(void) showUserLocation:(MKMapView*) mapView andLocationManager:(CLLocationManager*) locationManager {
    
    locationManager = [[CLLocationManager alloc ] init];
    locationManager.delegate = self;
    
    
    NSLog(@"--- %f", locationManager.location.coordinate.latitude);
    
    [locationManager requestAlwaysAuthorization];
    [locationManager startUpdatingLocation];
    [mapView setShowsUserLocation:YES];
    
    self.locationManager = locationManager;
    
}


-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
     self.location = locations.lastObject;
}


#pragma mark - action button method

- (void) actionShowAll:(UIBarButtonItem*) sender {
    
    MKMapRect zoomRect = MKMapRectNull;
    
    for (id <MKAnnotation> annotation in self.mapView.annotations) {
        
        CLLocationCoordinate2D location = annotation.coordinate;
        
        MKMapPoint center = MKMapPointForCoordinate(location);
        
        static double delta = 20000;
        
        MKMapRect rect = MKMapRectMake(center.x - delta, center.y - delta, delta * 2, delta * 2);
        
        zoomRect = MKMapRectUnion(zoomRect, rect);
    }
    
    zoomRect = [self.mapView mapRectThatFits:zoomRect];
    
    [self.mapView setVisibleMapRect:zoomRect
                        edgePadding:UIEdgeInsetsMake(50, 50, 50, 50)
                           animated:YES];
    
}



- (void) actionInfo:(UIButton*) sender {

    MKAnnotationView* annotationView = [sender superAnnotationView];
    
    ASStudent *std = (ASStudent <MKAnnotation> *)[[sender superAnnotationView]annotation];

    
    if (!annotationView) {
        return;
    }
    
    CLLocationCoordinate2D coordinate = annotationView.annotation.coordinate;
    
    CLLocation* location = [[CLLocation alloc] initWithLatitude:coordinate.latitude
                                                      longitude:coordinate.longitude];
    
    if ([self.geoCoder isGeocoding]) {
        [self.geoCoder cancelGeocode];
    }
    
    
    [self.geoCoder
     reverseGeocodeLocation:location
     completionHandler:^(NSArray *placemarks, NSError *error) {
         
         NSString* message = nil;
         
         NSMutableDictionary*  messageDict = [NSMutableDictionary new];
         NSDictionary*         tmpIntitialDict = @{@"name"   : std.firstname,
                                                   @"famaly" : std.lastname,
                                                   @"gender" : std.genderString,
                                                   @"date"   : std.dateOfBirth };
         if (error) {
             
             message = [error localizedDescription];
             
             [[[UIAlertView alloc]
               initWithTitle:@"Ошибка"
               message:message
               delegate:nil
               cancelButtonTitle:@"OK"
               otherButtonTitles:nil] show];
             
         } else {
             
             if ([placemarks count] > 0) {
                 
                 MKPlacemark* placeMark = [placemarks firstObject];
                 messageDict  = placeMark.addressDictionary;
                 [messageDict addEntriesFromDictionary:tmpIntitialDict];
                 
             } else {
                 message = @"No Placemarks Found";
             }
         }
     
         [self showPopover:sender messageDictionary:messageDict];
     
     }];

}


- (void) showPopover:(UIButton*) sender messageDictionary:(NSDictionary*) dict {
    
    

    ASDetailViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ASDetailViewController"];
    
    vc.dataDict = dict;

    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        vc.preferredContentSize = CGSizeMake(300, 300);
        
        UIPopoverController* pop = [[UIPopoverController alloc] initWithContentViewController:vc];
        
        
        pop.delegate = self;
        self.popover = pop;
        
        CGRect newBounds = sender.frame;
        newBounds.origin.x -= 10;
        newBounds.origin.y -= 10;
        newBounds.size.width += 25;
        newBounds.size.height += 25;

        
        [pop presentPopoverFromRect:newBounds//[sender frame]
                             inView:sender
           permittedArrowDirections:UIPopoverArrowDirectionAny
                           animated:YES];
    }
    else {
        [self showControllerAsModal:vc];
    }
}


-(void) showControllerAsModal:(UIViewController*) vc {
    
    
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self presentViewController:nav
                       animated:YES
                     completion:nil];
}




@end
