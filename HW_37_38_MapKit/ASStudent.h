//
//  ASStudent.h
//  HW_37_38_MapKit
//
//  Created by MD on 11.07.15.
//  Copyright (c) 2015 MD. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>


@interface ASStudent : NSObject  <MKAnnotation>


typedef enum ASGender {
    
    ASMale   = 0,
    ASFemale = 1
    
} ASGender;


@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;


@property (strong, nonatomic) NSString* firstname;
@property (strong, nonatomic) NSString* lastname;
@property (strong, nonatomic) NSString* dateOfBirth;
@property (strong, nonatomic) NSString* genderString;


@property (assign, nonatomic) ASGender    genderEnum;
@property (weak,   nonatomic) UIImage*    image;



//-(instancetype) initWithName:(NSString*)name andFamaly:(NSString*)famaly andUserLocation:(CLLocation *)newLocation;
-(instancetype) initWithName:(NSString*)name andFamaly:(NSString*)famaly andMeetingPointLocation:(CLLocationCoordinate2D)pointCoordinate;


@end
