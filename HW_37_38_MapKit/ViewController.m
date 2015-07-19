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

#import "CustomRadiusTableView.h"

@interface ViewController () <ASDetailTypeInstitytionDelegate>


@property (strong, nonatomic) CLLocationManager*  locationManager;
@property (strong, nonatomic) CLLocation*         location;


@property (strong, nonatomic)  UIPopoverController*   popover;
@property (strong, nonatomic)  CLGeocoder*            geoCoder;
@property (assign, nonatomic)  CGPoint                locationLongTouchForMeetingPoint;


@property (strong, nonatomic) ASMeetingPoint* currentMeetingPoint;
@property (strong, nonatomic) ASStudent*      currentStudent;

@property (strong, nonatomic) CustomRadiusTableView*     testView;
@property (weak, nonatomic) IBOutlet UISegmentedControl* mapTypeSegmentedControl;


@property (strong, nonatomic) MKDirections* directions;

@end




@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];

 

    [self showUserLocation:self.mapView andLocationManager:self.locationManager];
    
 

    UIBarButtonItem* zoomButton =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                  target:self action:@selector(actionShowAll:)];

    
    UIBarButtonItem* roadToMeetingButton =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                  target:self action:@selector(actionDirection:)];

    self.navigationItem.rightBarButtonItems = @[zoomButton, roadToMeetingButton];

    
     //self.navigationItem.rightBarButtonItem = zoomButton;
     self.geoCoder = [[CLGeocoder alloc] init];

    
     UILongPressGestureRecognizer* longTapGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongTap:)];
     longTapGesture.minimumPressDuration = 1.0f;
    
     [self.mapView addGestureRecognizer:longTapGesture];
    
    self.currentMeetingPoint = [[ASMeetingPoint alloc] init];
    self.currentStudent      = [[ASStudent      alloc] init];
    

 
    CGRect tmpRect = CGRectMake(CGRectGetMinX(self.view.bounds)+5, CGRectGetMinY(self.view.bounds)+10,
                                CGRectGetWidth(self.view.bounds)/2, CGRectGetHeight(self.view.bounds)/8);
    

    CustomRadiusTableView* radiusView = [[CustomRadiusTableView alloc] initWithFrame:tmpRect];

    tmpRect.size = CGSizeMake (CGRectGetWidth(self.view.bounds)/2, CGRectGetHeight(radiusView.labelRadius1.frame)*3.5f);
    radiusView.frame = tmpRect;

    self.testView = radiusView;

    [self.testView setNeedsDisplay];
    [self.mapView  addSubview:self.testView];

}

-(void) dealloc {
    
    if ([self.geoCoder isGeocoding]) {
        [self.geoCoder cancelGeocode];
    }
    
    if ([self.directions isCalculating]) {
        [self.directions cancel];
    }
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


// Кастомная анимация падения студентов

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)annotationViews
{
    for (MKAnnotationView *annView in annotationViews)
    {
        CGRect endFrame = annView.frame;
        annView.frame = CGRectOffset(endFrame, 0, -500);
        [UIView animateWithDuration:0.5
                         animations:^{ annView.frame = endFrame; }];
    }
}



// Анимация перетаскивания

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState
   fromOldState:(MKAnnotationViewDragState)oldState {
    

    if (newState == MKAnnotationViewDragStateStarting) {
        
        ASMeetingPoint *meetingPoint = (ASMeetingPoint <MKAnnotation> *)[[view superAnnotationView]annotation];
     
        
        [UIView animateWithDuration:0.2f
                              delay:0
                            options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                         animations:^{

                             [self.mapView removeOverlays:meetingPoint.arrayOverlayCircle];
                             //[self.mapView removeOverlays:meetingPoint.arrayPolyline];
                             
                             if (![meetingPoint.arrayPolyline isEqual:nil]) {
                                 [self.mapView removeOverlays:meetingPoint.arrayPolyline];
                                 [meetingPoint.arrayPolyline removeAllObjects];

                             }
                             
                             
                             //[meetingPoint.arrayPolyline removeAllObjects];
                              meetingPoint.arrayOverlayCircle = nil;
                             //[meetingPoint.arrayOverlayCircle removeAllObjects];
                             
                           
                             
                             self.currentMeetingPoint = nil;
                             [self allRecounting:self.currentMeetingPoint];
                       
                             view.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
                             view.alpha     = 0.5f;

                         }
                         completion:nil];
    } else
        if ((newState == MKAnnotationViewDragStateCanceling) || (newState == MKAnnotationViewDragStateEnding)) {
            
            ASMeetingPoint *meetingPoint = (ASMeetingPoint <MKAnnotation> *)[[view superAnnotationView]annotation];

            [UIView animateWithDuration:0.25f
                                  delay:0
                                options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                             animations:^{
                                 
                                 view.transform = CGAffineTransformMakeScale(1.f, 1.f);
                                 view.alpha     = 1.f;
                                 
                             }
                             completion:^(BOOL finished) {
                                 view.dragState = MKAnnotationViewDragStateNone;

                                // [self.mapView removeOverlays:self.currentMeetingPoint.arrayPolyline];
                                
                                 //[self.currentMeetingPoint.arrayPolyline removeAllObjects];
                                 
                                 if ([[[meetingPoint.arrayStudents objectAtIndex:0]polyline] isEqual:nil]) {
                                     [self actionDirection:nil];

                                 }
                                 
                                 //[self actionDirection:nil];
                                 [self addOverlayCircleWithCoordinate:meetingPoint];
                                 self.currentMeetingPoint = meetingPoint;

                                 
                                 
                             }];
        }
}



-(void) mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
     if ([view.annotation isKindOfClass:[ASMeetingPoint class]]) {
         
         ASMeetingPoint *meeting = (ASMeetingPoint <MKAnnotation> *)[[view superAnnotationView]annotation];

         self.currentMeetingPoint = meeting;
       
         [self allRecounting:self.currentMeetingPoint];

     }
    
    if ([view.annotation isKindOfClass:[ASStudent class]]) {

        ASStudent *student = (ASStudent <MKAnnotation> *)[[view superAnnotationView]annotation];
        self.currentStudent = student;
    }
    
    
}


// Создание annotation view ASStudent

-(MKAnnotationView *) creatASStudntPin:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    
    static NSString* identifier = @"ASStudentPin";
   
    MKAnnotationView* pin = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!pin) {
        
        pin = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];

        __weak ASStudent *weakSelf = annotation;
        
        if ([weakSelf isKindOfClass:[ASStudent class]] && ![weakSelf.image isEqual:nil]) {
            pin.image = weakSelf.image;
            
        } else {
            
            pin.image = [UIImage imageNamed:@"meeting@3x.jpg"];
        }
        
        UIButton* infoButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [infoButton addTarget:self action:@selector(actionInfo:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
        UIImage  *removeImage            = [UIImage imageNamed:@"delete.png"];
        UIButton *removeAnnotationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        removeAnnotationButton.bounds = CGRectMake( 0, 0, 30 , 30);
        [removeAnnotationButton setImage:removeImage forState:UIControlStateNormal];
        [removeAnnotationButton addTarget:self action:@selector(actionRemoveStudents:) forControlEvents:UIControlEventTouchUpInside];
        
        
        pin.rightCalloutAccessoryView = infoButton;
        pin.leftCalloutAccessoryView  = removeAnnotationButton;
        pin.canShowCallout = YES;
        
 
        NSLog (@"\nCreating Student  \nTitle = %@\n Image = %@\n\n",weakSelf.title,weakSelf.image);

    } else {
        
        ASStudent* tmpStudent = annotation;
        pin.image = tmpStudent.image;
    }

    self.currentStudent = annotation;

   return pin;
}


// Создание annotation view ASMeetingPoint


-(MKAnnotationView *) creatASMeetingPin:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    

    static NSString* identifier = @"ASMeetingPin";
    
    MKAnnotationView* pin = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if (!pin) {
        
        pin = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
       
        ASMeetingPoint *point = annotation;

        pin.image = point.image;
  
        UIButton* addStudentButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [addStudentButton addTarget:self action:@selector(actionAddStudent:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIImage  *removeImage            = [UIImage imageNamed:@"delete.png"];
        UIButton *removeAnnotationButton = [UIButton buttonWithType:UIButtonTypeCustom];
      
        removeAnnotationButton.bounds = CGRectMake( 0, 0, 30 , 30);
        [removeAnnotationButton setImage:removeImage forState:UIControlStateNormal];
        [removeAnnotationButton addTarget:self action:@selector(actionRemoveAnnotation:) forControlEvents:UIControlEventTouchUpInside];

        
        
        pin.rightCalloutAccessoryView = addStudentButton;
        pin.leftCalloutAccessoryView  = removeAnnotationButton;
        
        pin.canShowCallout = YES;
        pin.draggable = YES;
        
        self.currentMeetingPoint = point;


        NSLog (@"\nCreating Meeting Point \nTitle = %@\n\n",point.title);

    } else {
    
        ASMeetingPoint* tmpPoint = annotation;
     
        pin.image = tmpPoint.image;
        self.currentMeetingPoint = tmpPoint;

    }
    
    [self addOverlayCircleWithCoordinate:self.currentMeetingPoint];
    
    return pin;
    
}


#pragma mark - User Location

-(void) showUserLocation:(MKMapView*) mapView andLocationManager:(CLLocationManager*) locationManager {
    
    locationManager = [[CLLocationManager alloc ] init];
    locationManager.delegate = self;
    
    
    NSLog(@"USER LOCATION --- %f %f", locationManager.location.coordinate.latitude,locationManager.location.coordinate.longitude);
    
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




#pragma mark - Add Student Around ASMeetingPoint


- (void) actionAddStudent:(UIButton*) sender {

    MKAnnotationView* annotationView = [sender superAnnotationView];

    ASNameFamalyAndImage* obj = [[ASNameFamalyAndImage alloc] init];

    
    ASMeetingPoint *meeting = (ASMeetingPoint <MKAnnotation> *)[[sender superAnnotationView]annotation];
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = 60.0;
    coordinate.longitude = 10.0;
    
    
    for (int i=0; i<=10; i++) {
        NSString* name   = [obj.arrayNames objectAtIndex:   arc4random()%[obj.arrayNames count]];
        NSString* famaly = [obj.arrayFamaly objectAtIndex:  arc4random()%[obj.arrayFamaly count]];
        
       ASStudent* std = [[ASStudent alloc] initWithName:name andFamaly:famaly andMeetingPointLocation:meeting.coordinate];
       [meeting.arrayStudents addObject:std];
    
    }
    [self.mapView addAnnotations:meeting.arrayStudents];

    self.currentMeetingPoint = meeting;
    obj = nil;

    [self.mapView removeOverlays:meeting.arrayOverlayCircle];
    [self addOverlayCircleWithCoordinate:meeting];
  
}





- (void) actionRemoveAnnotation:(UIButton*) sender {

    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"What to do with annotations ?"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:@"All Remove"
                                                    otherButtonTitles:@"Only Meeting Point", @"Only Students",  nil];

    
    actionSheet.tag = 100;
    
    ASMeetingPoint *meetingPoint = (ASMeetingPoint <MKAnnotation> *)[[sender superAnnotationView]annotation];
    self.currentMeetingPoint = meetingPoint;


    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {

        [actionSheet showFromRect:[(UIButton *)sender frame] inView:self.view animated:YES];
    }
    else{
        [actionSheet showInView:self.view];
    }

    
}


- (void) actionRemoveStudents:(UIButton*) sender {

 
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"What to do with student ?"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:@"Remove"
                                                    otherButtonTitles: nil];
    
    
    actionSheet.tag = 200;

    ASStudent* student = (ASStudent <MKAnnotation> *)[[sender superAnnotationView]annotation];
    self.currentStudent = student;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        [actionSheet showFromRect:[(UIButton *)sender frame] inView:self.view animated:YES];
    }
    else{
        [actionSheet showInView:self.view];
    }
}



-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    ASMeetingPoint *meetingPoint = self.currentMeetingPoint;

    NSLog(@"meetingPoint title %@",meetingPoint.title);
    NSLog(@"Было meetingPoint arrayStudents %@",meetingPoint.arrayStudents);
    NSLog(@"Было meetingPoint mapView.annotations %@",self.mapView.annotations);
    NSLog(@"Было meetingPoint mapView.annotations %@",self.mapView.annotations);

    if (actionSheet.tag == 100) {

 
        if (buttonIndex == 0) {
            [self.mapView removeAnnotations:self.currentMeetingPoint.arrayStudents];
            [self.mapView removeAnnotation:self.currentMeetingPoint];
        
            [self.mapView removeOverlays:self.currentMeetingPoint.arrayOverlayCircle];
            [self.mapView removeOverlays:self.currentMeetingPoint.arrayPolyline];

            
            [self.currentMeetingPoint.arrayStudents removeAllObjects];
            [self.currentMeetingPoint.arrayPolyline removeAllObjects];
            self.currentMeetingPoint = nil;

            
            [self allRecounting:self.currentMeetingPoint];

            

        }
        
        if (buttonIndex == 1) {
            [self.mapView removeAnnotation:self.currentMeetingPoint];
            [self.mapView removeOverlays:self.currentMeetingPoint.arrayOverlayCircle];
            [self.mapView removeOverlays:self.currentMeetingPoint.arrayPolyline];

            self.currentMeetingPoint = nil;
          
            [self allRecounting:self.currentMeetingPoint];

        }
        
        if (buttonIndex == 2) {
            
            [self.mapView removeAnnotations:self.currentMeetingPoint.arrayStudents];
            [self.mapView removeOverlays:self.currentMeetingPoint.arrayPolyline];

            
            [self.currentMeetingPoint.arrayPolyline removeAllObjects];
            [self.currentMeetingPoint.arrayStudents removeAllObjects];
           

            self.currentMeetingPoint = nil;
            
           
            [self allRecounting:self.currentMeetingPoint];
            
            
            
            
            //////
            
        }
     }
 
    if (actionSheet.tag == 200) {
        
     
         if (buttonIndex == 0) {
         
             [self.mapView removeOverlay:self.currentStudent.polyline];
             
             [self.mapView removeAnnotation:self.currentStudent];
             [self.currentMeetingPoint.arrayPolyline removeObject:self.currentStudent.polyline];
             
             [self.currentMeetingPoint.arrayStudents removeObject:self.currentStudent];
            
       
            
             [self allRecounting:self.currentMeetingPoint];
             self.currentStudent = nil;
         }
    }
    
    NSLog(@"\n\n\nСтало meetingPoint arrayStudents %@",meetingPoint.arrayStudents);
    NSLog(@"Стало meetingPoint mapView.annotations %@",self.mapView.annotations);
    
}


#pragma mark - Show all student on screen


- (void) actionShowAll:(UIBarButtonItem*) sender {
    
    MKMapRect zoomRect = MKMapRectNull;
    
    for (id <MKAnnotation> annotation in self.mapView.annotations) {
      
        
        
        if ([annotation isKindOfClass:[MKUserLocation class]]) {
            continue;
        }
        
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


#pragma mark - Button for student callout


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

#pragma mark -  Show Popover method

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
    

    if (sender.state == UIGestureRecognizerStateEnded) {

        CGPoint location = [sender locationInView:self.view];

        NSLog (@" UIGestureRecognizerStateEnded ");
        
        
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

    
    ASMeetingPoint* meetingPoint = [[ASMeetingPoint alloc] initWithNameBuild:nameBuild image:nameImage location:coordinateStudent2d];

    [self.mapView addAnnotation:meetingPoint];

}

#pragma mark - Delegate method popover


- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    
    NSLog (@" popoverControllerDidDismissPopover ");

    self.popover = nil;
    
}

- (IBAction)mapTypeChanged:(UISegmentedControl *)sender {
    
    switch (self.mapTypeSegmentedControl.selectedSegmentIndex) {
        case 0:
            self.mapView.mapType = MKMapTypeStandard;
            break;
        case 1:
            self.mapView.mapType = MKMapTypeHybrid;
            break;
        case 2:
            self.mapView.mapType = MKMapTypeSatellite;
            break;
        default:
            break;
    }

}

#pragma  mark - Render Overlay

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView  rendererForOverlay:(id <MKOverlay>)overlay
{
    
    if ([overlay isKindOfClass:[MKCircle class]]) {
        
        MKCircleRenderer *circleRender = [[MKCircleRenderer alloc] initWithCircle:(MKCircle *)overlay];
        circleRender.strokeColor = [UIColor greenColor];
        circleRender.fillColor   = [[UIColor blueColor]colorWithAlphaComponent:0.08];
        
        circleRender.lineWidth = 1.2f;
        
        return circleRender;
        
    }
    
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        
        MKPolylineRenderer* renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        renderer.lineWidth = 2.f;
        renderer.strokeColor = [UIColor redColor];
        renderer.lineCap = 2.5f;
        
        return renderer;
    }
    
    
    return nil;
}



- (void)addOverlayCircleWithCoordinate:(ASMeetingPoint*)meetingPoint {
    
    if (![meetingPoint isEqual:nil]) {
        
    
    MKCircle *circle1 = [MKCircle circleWithCenterCoordinate:meetingPoint.coordinate radius:500];
    MKCircle *circle2 = [MKCircle circleWithCenterCoordinate:meetingPoint.coordinate  radius:1000];
    MKCircle *circle3 = [MKCircle circleWithCenterCoordinate:meetingPoint.coordinate  radius:1500];

    NSArray *overlayArray = @[circle1,circle2,circle3];

    meetingPoint.arrayOverlayCircle = overlayArray;
    
        [self allRecounting:meetingPoint];

        [self.mapView addOverlays:meetingPoint.arrayOverlayCircle];
   }
}


- (NSArray *)countStudentInCircleCoordinate:(ASMeetingPoint*) point  andRadius:(int)radius  {


    NSMutableArray *tempArray = [[NSMutableArray alloc]init];

    CLLocation* meetingLocation = [[CLLocation alloc] initWithLatitude:point.coordinate.latitude longitude:point.coordinate.longitude];

     int count = 0;
    
      for (id <MKAnnotation> annotation in self.mapView.annotations) {
       
          if ([annotation isKindOfClass:[ASStudent class]]) {
              
              CLLocation *tempLocation = [[CLLocation alloc]initWithLatitude:annotation.coordinate.latitude longitude:annotation.coordinate.longitude];
             
              CLLocationDistance dist = [meetingLocation distanceFromLocation:tempLocation];
              
              if (radius > dist) {
                  count++;
                  
                  [tempArray addObject:annotation];
              }
              
          }
        
          
      }
    
    if (radius == 500) {
        self.testView.labelRadius1.text = [NSString stringWithFormat:@"Radius %d student %d",radius,count];
    } else if (radius == 1000) {
        self.testView.labelRadius2.text = [NSString stringWithFormat:@"Radius %d student %d",radius,count];
    } else if (radius == 1500) {
        self.testView.labelRadius3.text = [NSString stringWithFormat:@"Radius %d student %d",radius,count];
    }

    return tempArray;

}


-(void) recountingStudentInCircleCoordinate:(ASMeetingPoint*) point andRadius:(int) radius {
    
    
    if (![point isEqual:nil]) {
        
    
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    
    CLLocation* meetingLocation = [[CLLocation alloc] initWithLatitude:point.coordinate.latitude longitude:point.coordinate.longitude];
    int count = 0;
    
    for (id <MKAnnotation> annotation in self.mapView.annotations) {
        
        if ([annotation isKindOfClass:[ASStudent class]]) {
            
            CLLocation *tempLocation = [[CLLocation alloc]initWithLatitude:annotation.coordinate.latitude longitude:annotation.coordinate.longitude];
            
            CLLocationDistance dist = [meetingLocation distanceFromLocation:tempLocation];
            
            if (radius > dist) {
                count++;
                
                [tempArray addObject:annotation];
            }
        }
    }
    
        if (radius == 500) {
            self.testView.labelRadius1.text = [NSString stringWithFormat:@"Radius %d student %d",radius,count];
        } else if (radius == 1000) {
            self.testView.labelRadius2.text = [NSString stringWithFormat:@"Radius %d student %d",radius,count];
        } else if (radius == 1500) {
            self.testView.labelRadius3.text = [NSString stringWithFormat:@"Radius %d student %d",radius,count];
        }
    
    
    } else {
        
        self.testView.labelRadius1.text = @"Radius 500 student  0";
        self.testView.labelRadius2.text = @"Radius 1000 student 0";
        self.testView.labelRadius3.text = @"Radius 1500 student 0";

        
    }
}


-(void) allRecounting:(ASMeetingPoint*) point {

    [self recountingStudentInCircleCoordinate:point andRadius:500];
    [self recountingStudentInCircleCoordinate:point andRadius:1000];
    [self recountingStudentInCircleCoordinate:point andRadius:1500];
    
    
}


#pragma mark - Direction



- (void) actionDirection:(UIBarButtonItem*) sender {
    

    for (ASStudent* student in self.currentMeetingPoint.arrayStudents) {
        
        
        
        CLLocation* meetingLocation = [[CLLocation alloc] initWithLatitude:self.currentMeetingPoint.coordinate.latitude longitude:self.currentMeetingPoint.coordinate.longitude];
        CLLocation *studentLocation = [[CLLocation alloc]initWithLatitude:student.coordinate.latitude longitude:student.coordinate.longitude];

        CLLocationDistance dist = [meetingLocation distanceFromLocation:studentLocation];
        
        if (dist >= 1500) {
            BOOL xet = nextBool(25);
            if (xet) continue; else break;
        
        } else if (dist >= 1000) {
            
            BOOL xet = nextBool(50);
            if (xet) continue; else break;
        
           }
        
        
        
        if ([self.directions isCalculating]) {
            [self.directions cancel];
        }
        
        MKDirectionsRequest* request = [[MKDirectionsRequest alloc] init];

        // Meeting Point
        MKPlacemark* sourceMeetingPointMark = [[MKPlacemark alloc] initWithCoordinate:self.currentMeetingPoint.coordinate
                                                                    addressDictionary:nil];
        MKMapItem*   sourceMeetingPointItem = [[MKMapItem alloc] initWithPlacemark:sourceMeetingPointMark];
        request.source = sourceMeetingPointItem;
        
        
       // Student point
        MKPlacemark* destinationStudentMark = [[MKPlacemark alloc] initWithCoordinate:student.coordinate
                                                       addressDictionary:nil];
        MKMapItem*  destinationStudentItem = [[MKMapItem alloc] initWithPlacemark:destinationStudentMark];
        request.destination = destinationStudentItem;

        
        // Рассчет
        
        request.transportType = MKDirectionsTransportTypeAutomobile;
        request.requestsAlternateRoutes = NO; // !!!!!

        
        self.directions = [[MKDirections alloc] initWithRequest:request];
        
        [self.directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
            
            if (error) {
                [self showAlertWithTitle:@"Error" andMessage:[error localizedDescription]];
            } else if ([response.routes count] == 0) {
                [self showAlertWithTitle:@"Error" andMessage:@"No routes found"];
            } else {
                
                
                NSMutableArray* array = [NSMutableArray array];
                
                for (MKRoute* route in response.routes) {
                   
                    student.polyline = route.polyline;
                    
                    [self.currentMeetingPoint.arrayPolyline addObject:student.polyline];
                }
                
                [self.mapView addOverlays:self.currentMeetingPoint.arrayPolyline level:MKOverlayLevelAboveRoads];
            }
            
        }];
        
        
    }
}


bool nextBool(double probability)
{
    return rand() <  probability * ((double)RAND_MAX + 1.0);
}




- (void) showAlertWithTitle:(NSString*) title andMessage:(NSString*) message {
    [[[UIAlertView alloc]
      initWithTitle:title
      message:message
      delegate:nil
      cancelButtonTitle:@"OK"
      otherButtonTitles:nil] show];
}




@end
