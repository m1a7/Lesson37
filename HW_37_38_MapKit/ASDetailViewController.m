//
//  ASDetailViewController.m
//  HW_37_38_MapKit
//
//  Created by MD on 13.07.15.
//  Copyright (c) 2015 MD. All rights reserved.
//

#import "ASDetailViewController.h"

@interface ASDetailViewController ()

@end

@implementation ASDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.labelName.text   = [NSString stringWithFormat:@"Name   : %@", [self.dataDict objectForKey:@"name"]];
    self.labelFamaly.text = [NSString stringWithFormat:@"Famaly : %@", [self.dataDict objectForKey:@"famaly"]];
    self.labelGender.text = [NSString stringWithFormat:@"Gender : %@", [self.dataDict objectForKey:@"gender"]];
    self.labelDateOfBirth.text = [NSString stringWithFormat:@"Date of Birth : %@",[self.dataDict objectForKey:@"date"]];

    
    /*
     City = "Santa Clara";
     Country = "United States";
     CountryCode = US;
     FormattedAddressLines =     (
     "3260 Warburton Ave",
     "Santa Clara, CA  95051-2727",
     "United States"
     );
     Name = "3260 Warburton Ave";
     PostCodeExtension = 2727;
     State = CA;
     Street = "3260 Warburton Ave";
     SubAdministrativeArea = "Santa Clara";
     SubLocality = "Calabazas Cabrillo";
     SubThoroughfare = 3260;
     Thoroughfare = "Warburton Ave";
     ZIP = 95051;*/

    self.labelCountry.text = [NSString stringWithFormat:@"Country : %@",   [self.dataDict objectForKey:@"Country"]];
    self.labelArea.text    = [NSString stringWithFormat:@"State   : %@",   [self.dataDict objectForKey:@"State"]];
    self.labelCity.text    = [NSString stringWithFormat:@"City    : %@",   [self.dataDict objectForKey:@"City"]];
    self.labelStreet.text  = [NSString stringWithFormat:@"Street  : %@",   [self.dataDict objectForKey:@"Name"]];

    
    UIBarButtonItem* backButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(backAction:)];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    self.navigationItem.title = @"Detailed information";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) backAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
