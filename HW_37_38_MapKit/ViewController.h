//
//  ViewController.h
//  HW_37_38_MapKit
//
//  Created by MD on 11.07.15.
//  Copyright (c) 2015 MD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface ViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, UIPopoverControllerDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;


@end

