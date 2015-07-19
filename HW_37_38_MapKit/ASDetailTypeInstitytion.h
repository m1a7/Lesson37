//
//  ASDetailTypeInstitytion.h
//  HW_37_38_MapKit
//
//  Created by MD on 14.07.15.
//  Copyright (c) 2015 MD. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol ASDetailTypeInstitytionDelegate <NSObject>

@required

-(void)dataFromDateDetailTypeController:(NSString*) nameBuild imageNamed:(NSString*) nameImage;

@end


@interface ASDetailTypeInstitytion : UITableViewController <UITabBarDelegate, UITableViewDataSource>


@property (nonatomic, strong) NSArray*      arrayNamesType;
@property (nonatomic, strong) NSDictionary* dictNameImage;
@property (nonatomic, assign) NSInteger*    indexSelectRow;


@property (nonatomic, assign) BOOL wasSelect;
@property (nonatomic, weak) id <ASDetailTypeInstitytionDelegate> delegate;


@end
