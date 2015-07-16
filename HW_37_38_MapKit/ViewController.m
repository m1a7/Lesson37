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

#import "ASDetailTypeInstitytion.h"
#import "ASMeetingPoint.h"

#import "TestVC.h"
#import "SuperTestView.h"

@interface ViewController () <ASDetailTypeInstitytionDelegate>


@property (strong, nonatomic) CLLocationManager*  locationManager;
@property (strong, nonatomic) CLLocation*         location;
@property (strong, nonatomic) NSMutableArray*     arrayStudents;

@property (strong, nonatomic)  UIPopoverController*   popover;
@property (strong, nonatomic)  CLGeocoder* geoCoder;
@property (assign, nonatomic)  CGPoint locationLongTouchForMeetingPoint;
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
    self.geoCoder = [[CLGeocoder alloc] init];

    
   UILongPressGestureRecognizer* longTapGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongTap:)];
   longTapGesture.minimumPressDuration = 1.0f;
   //longTapGesture.allowableMovement = 100.0f;
    
    [self.mapView addGestureRecognizer:longTapGesture];
    
    

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
    
    NSLog (@" viewForAnnotation Fork");

    if ([annotation isKindOfClass:[ASStudent class]]) {
        return [self creatASStudntPin:mapView viewForAnnotation:annotation];
    }
    
    
    if ([annotation isKindOfClass:[ASMeetingPoint class]]) {
        return [self creatASMeetingPin:mapView viewForAnnotation:annotation];
    }
  
    
    
return nil;
}

/*
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    [mapView deselectAnnotation:view.annotation animated:YES];
    
    TestVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TestVC"];
    
    
    vc.preferredContentSize = CGSizeMake(150, 90);
    
    UIPopoverController* pop = [[UIPopoverController alloc] initWithContentViewController:vc];
    
    
    pop.delegate = self;
    self.popover = pop;

    [pop presentPopoverFromRect:view.bounds inView:view
      permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}*/

-(void) mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    /*
    if ([view.annotation isKindOfClass:[ASStudent class]]) {
   
        ASStudent* std = view.annotation;
    
    [mapView deselectAnnotation:view.annotation animated:YES];
    
    TestVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TestVC"];
    
    
    vc.preferredContentSize = CGSizeMake(150, 90);
    
    UIPopoverController* pop = [[UIPopoverController alloc] initWithContentViewController:vc];
    
    
    pop.delegate = self;
    self.popover = pop;
    
    [pop presentPopoverFromRect:view.bounds inView:view
       permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
  }*/
    
    if ([view.annotation isKindOfClass:[ASMeetingPoint class]]) {
        
        ASMeetingPoint* meeting = view.annotation;
        
        [mapView deselectAnnotation:view.annotation animated:YES];
        
        SuperTestView* testView = [[[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:self options:nil] lastObject];
        
        testView.bounds = CGRectMake(CGRectGetMinY(view.frame), CGRectGetMinX(view.frame), 150, 80);
        testView.labelText.bounds = CGRectMake(CGRectGetMinY(view.frame), CGRectGetMinX(view.frame), 150, 80);
        testView.labelText.text = @"Text Hard Core";
        [self.view addSubview:testView];
        
    }
    
/*
    if([view.annotation isKindOfClass:[ASStudent class]]) {
        CalloutAnnotation *calloutAnnotation = [[CalloutAnnotation alloc] initForAnnotation:view.annotation];
        [mapView addAnnotation:calloutAnnotation];
        dispatch_async(dispatch_get_main_queue(), ^{
            [mapView selectAnnotation:calloutAnnotation animated:YES];
        });
    }*/
    
}

-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    
    
    for (UIView* subview in view.subviews) {
        
        [subview removeFromSuperview];
    }
    
}


-(MKAnnotationView *) creatASStudntPin:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    
    static NSString* identifier = @"ASStudentPin";
   
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
        //pin.draggable = YES;
        
    } else {
        pin.annotation = annotation;
    }

   return pin;
}


-(MKAnnotationView *) creatASMeetingPin:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    
    NSLog (@"creatASMeetingPin viewForAnnotation Identifier");

    static NSString* identifier = @"ASMeetingPin";
    
    MKAnnotationView* pin = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if (!pin) {
        
        pin = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        
          __weak ASMeetingPoint *weakSelf = annotation;
        
          if ([weakSelf isKindOfClass:[ASMeetingPoint class]] && ![weakSelf.image isEqual:nil]) {
              pin.image = weakSelf.image;
          } else {
              pin.image = [UIImage imageNamed:@"meeting@3x.jpg"];
          }
        
        pin.canShowCallout = YES;
        pin.draggable = YES;
        weakSelf = nil;
    } else {
        pin.annotation = annotation;
    }
    
    
    return pin;
}







// Анимация перетаскивания

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState
   fromOldState:(MKAnnotationViewDragState)oldState {
    
   // [self mapView:mapView didSelectAnnotationView:someAnnotationView];
    //[self mapView:mapView didSelectAnnotationView:view];
    //[self mapView:mapView didDeselectAnnotationView:view];
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
        MKMapPoint center               = MKMapPointForCoordinate(location);
        static double delta = 20000;
        MKMapRect rect = MKMapRectMake (center.x - delta, center.y - delta, delta * 2, delta * 2);
        zoomRect       = MKMapRectUnion(zoomRect, rect);
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
               initWithTitle:@"Ошибка"  message:message
               delegate:nil             cancelButtonTitle:@"OK"
               otherButtonTitles:nil]   show];
               messageDict = tmpIntitialDict;
           } else {
             
             if ([placemarks count] > 0) {
                 
                 MKPlacemark* placeMark = [placemarks firstObject];
                 messageDict  = placeMark.addressDictionary;
                 [messageDict addEntriesFromDictionary:tmpIntitialDict];
                 
             } else {
                 message = @"No Placemarks Found";
             }
         }
     
         [self showPopoverDetailController:sender messageDictionary:messageDict];
     
     }];

}

// Calling ASDetailViewController - Name/Famaly/Gender ...
- (void) showPopoverDetailController:(UIButton*) sender messageDictionary:(NSDictionary*) dictWithAdress {
    
    

    ASDetailViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ASDetailViewController"];
    vc.dataDict = dictWithAdress;

    [self callPopoverOrModalController:vc popoverController:self.popover andSender:sender];
    
}


// Calling ASDetailTypeInstitytion - Menu Resturan/Coffe/Bar/Pub

- (void) showPopoverDetailTypeController:(UIButton*) sender  {
    
    NSLog (@" showPopoverDetailTypeController ");

    ASDetailTypeInstitytion* vc = [[ASDetailTypeInstitytion alloc] init];
    vc.delegate = self;
    [self callPopoverOrModalController:vc popoverController:self.popover andSender:sender];
    vc = nil;
}




-(void) callPopoverOrModalController:(UIViewController*) vc popoverController:(UIPopoverController*) popover  andSender:(UIButton*) sender{
    
    NSLog (@" callPopoverOrModalController ");

    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        vc.preferredContentSize = CGSizeMake(300, 300);
        
        UIPopoverController* pop = [[UIPopoverController alloc] initWithContentViewController:vc];
        
        
        pop.delegate = self;
        self.popover = pop;
        //popover = pop;
        
       
        CGRect newBounds = sender.frame;
        newBounds.origin.x -= 10;
        newBounds.origin.y -= 10;
        newBounds.size.width += 25;
        newBounds.size.height += 25;
        
        UIView* forInViewParametr;
        
        
        if ([vc isKindOfClass:[ASDetailViewController class]]) {
            forInViewParametr = sender;
        } else
        
        if ([vc isKindOfClass:[ASDetailTypeInstitytion class]]) {
            forInViewParametr = self.view;
        }
        else {
             forInViewParametr = self.view;
        }
        
        
        
        [self.popover presentPopoverFromRect:newBounds // newBounds//[sender frame]
                             inView:forInViewParametr//sender // self.view // Корень зла здесь
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


#pragma mark - Gesture method 

-(void) handleLongTap:(UILongPressGestureRecognizer*) sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        NSLog(@"Long press Ended");
    
    NSLog (@" handleLongTap ");

    CGPoint location = [sender locationInView:self.view];
    
    self.locationLongTouchForMeetingPoint = location;
    
    CGRect  rect     = CGRectMake(location.x, location.y, 25, 25);
    
    UIButton* button = [[UIButton alloc] initWithFrame:rect];
    
   [self showPopoverDetailTypeController:button];
    }

}






#pragma mark - Pass Data


-(void)dataFromDateDetailTypeController:(NSString*) nameBuild imageNamed:(NSString*) nameImage
{
    NSLog (@" dataFromDateDetailTypeController ");

    CLLocationCoordinate2D coordinateStudent2d = [self.mapView convertPoint:self.locationLongTouchForMeetingPoint
                                                       toCoordinateFromView:self.view];

    
    ASMeetingPoint* meetingPoint = [[ASMeetingPoint alloc] initWithNameBuild:nameBuild image:nameImage location:&coordinateStudent2d];

    [self.mapView addAnnotation:meetingPoint];
   // self.locationLongTouchForMeetingPoint = CGPointZero;

}


- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    
    NSLog (@" popoverControllerDidDismissPopover ");

    self.popover = nil;
    
}
@end
