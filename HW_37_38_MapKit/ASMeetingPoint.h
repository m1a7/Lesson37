//
//  ASMeetingPoint.h
//  HW_37_38_MapKit
//
//  Created by MD on 14.07.15.
//  Copyright (c) 2015 MD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>
#import <UIKit/UIKit.h>




@interface ASMeetingPoint : NSObject <MKAnnotation>


typedef enum ASTypesPublicInstitution {
    
    ASRestaurant  = 0,
    ASBistro      = 1,
    ASCafe        = 2,
    ASPizzeria    = 3,
    ASBarbecue    = 4,
    ASPub         = 5,
    ASBar         = 6,
    
    ASTheater     = 7,
    ASBilliards   = 8,
    ASBowling     = 9,
    ASNightClub   = 10,
    ASPark        = 11
    
} ASTypesPublicInstitution;


-(instancetype) initWithNameBuild:(NSString*)nameBuild image:(NSString*)nameImage location:(CLLocationCoordinate2D) coordinate;


@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy)   NSString *title;
@property (nonatomic, copy)   NSString *subtitle;


@property (nonatomic, assign) CGFloat    rating;
@property (nonatomic, assign) NSInteger  capacityBuilding;

@property (nonatomic, assign) ASTypesPublicInstitution    typeInstitute;

@property (strong,   nonatomic) UIImage*    image;
@property (nonatomic, strong)   NSDictionary* imageDict;


@property (strong, nonatomic) NSMutableArray*     arrayStudents;
@property (strong, nonatomic) NSMutableArray*     arrayOverlayCircle;
@property (strong, nonatomic) NSMutableArray*     arrayPolyline;

-(double)randomFloatBetween:(double)num1 andLargerFloat:(double)num2;
-(NSInteger)randomIntegerBetween:(NSInteger)num1 andLargerFloat:(NSInteger)num2;
@end
