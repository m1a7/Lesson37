//
//  ASDetailViewController.h
//  HW_37_38_MapKit
//
//  Created by MD on 13.07.15.
//  Copyright (c) 2015 MD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASDetailViewController : UITableViewController


@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelFamaly;
@property (weak, nonatomic) IBOutlet UILabel *labelGender;
@property (weak, nonatomic) IBOutlet UILabel *labelDateOfBirth;


@property (weak, nonatomic) IBOutlet UILabel *labelCountry;
@property (weak, nonatomic) IBOutlet UILabel *labelArea;
@property (weak, nonatomic) IBOutlet UILabel *labelCity;
@property (weak, nonatomic) IBOutlet UILabel *labelStreet;

@property (strong, nonatomic) NSDictionary* dataDict;

@end
