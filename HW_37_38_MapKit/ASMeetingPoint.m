//
//  ASMeetingPoint.m
//  HW_37_38_MapKit
//
//  Created by MD on 14.07.15.
//  Copyright (c) 2015 MD. All rights reserved.
//

#import "ASMeetingPoint.h"
#import "UIImage+imageWithImage.h"

@implementation ASMeetingPoint
#define ARC4RANDOM_MAX      0x100000000


//-(instancetype) initWithNameBuild:(NSString*)nameBuild andNameImage:(NSString*)nameImage {
-(instancetype) initWithNameBuild:(NSString*)nameBuild image:(NSString*)nameImage location:(CLLocationCoordinate2D*) coordinate {
  self = [super init];
    
    if (self) {
     
        NSLog(@"ASMeeting init");
        self.imageDict  = @{@"TypesInstitution/ASRestaurant.png" : @0,
                            @"TypesInstitution/ASBistro.png"     : @1,
                            @"TypesInstitution/ASCafe.png"       : @2,
                            @"TypesInstitution/ASPizzeria.png"   : @3,
                            @"TypesInstitution/ASBarbecue.png"   : @4,
                            @"TypesInstitution/ASPub.png"        : @5,
                            @"TypesInstitution/ASBar.png"        : @6,
                            @"TypesInstitution/ASTheater.png"    : @7,
                            @"TypesInstitution/ASBilliards.png"  : @8,
                            @"TypesInstitution/ASBowling.png"    : @9,
                            @"TypesInstitution/ASNightClub.png"  : @10,
                            @"TypesInstitution/ASPark.png"       : @11};
        
        
    
      self.rating           = [self randomFloatBetween:1 andLargerFloat:10];
      self.capacityBuilding = [self randomIntegerBetween:10 andLargerFloat:200];
      self.coordinate       = *(coordinate);
        
      self.title    = [NSString stringWithFormat:@"%@",nameBuild];
      self.subtitle = [NSString stringWithFormat:@"Рейтинг - %.2f",self.rating];
      self.image    = [UIImage imageNamed:[NSString stringWithFormat:@"TypesInstitution/%@",nameImage]];
      self.image    = [UIImage imageWithImage:self.image scaledToSize:CGSizeMake(48, 48)];
        
       // = [MYUtil imageWithImage:myUIImageInstance scaledToSize:CGSizeMake(20, 20)];
    }
    
  return self;
}

#pragma mark - Generate Random Number

-(double)randomFloatBetween:(double)num1 andLargerFloat:(double)num2
{
    double range = num2 - num1;
    double val = ((double)arc4random() / ARC4RANDOM_MAX) * range + num1;
    
    return val;
}

-(NSInteger)randomIntegerBetween:(NSInteger)num1 andLargerFloat:(NSInteger)num2
{
    NSInteger range = num2 - num1;
    NSInteger val = ((NSInteger)arc4random() / ARC4RANDOM_MAX) * range + num1;
    
    return val;
}



@end
