//
//  ASDetailTypeInstitytion.m
//  HW_37_38_MapKit
//
//  Created by MD on 14.07.15.
//  Copyright (c) 2015 MD. All rights reserved.
//

#import "ASDetailTypeInstitytion.h"
#import "ViewController.h"


@interface ASDetailTypeInstitytion ()

@end



@implementation ASDetailTypeInstitytion


-(void) loadView {
    
    [super loadView];
    

    NSArray* tmpArray   = @[@"Restaurant", @"Bistro",      @"Cafe",
                            @"Pizzeria",   @"Barbecue",    @"Pub",
                            @"Bar",        @"Theater",     @"Billiards",
                            @"Bowling",    @"Night Club",  @"Park"];
    

    NSDictionary* tmpDict = @{@"Restaurant"  :@"ASRestaurant.png",
                              @"Bistro"      : @"ASBistro.png",
                              @"Cafe"        : @"ASCafe.png",
                              @"Pizzeria"    : @"ASPizzeria.png",
                              @"Barbecue"    : @"ASBarbecue.png",
                              @"Pub"         : @"ASPub.png",
                              @"Bar"         : @"ASBar.png",
                              @"Theater"     : @"ASTheater.png",
                              @"Billiards"   : @"ASBilliards.png",
                              @"Bowling"     : @"ASBowling.png",
                              @"Night Club"   : @"ASNightClub.png",
                              @"Park"        : @"ASPark.png"};
    
    self.arrayNamesType = tmpArray;
    self.dictNameImage = tmpDict;
}



- (void)viewDidLoad
{
    
    [super viewDidLoad];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        UIBarButtonItem* backButtonItem = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                           target:self
                                           action:@selector(backAction:)];
        
        self.navigationItem.leftBarButtonItem = backButtonItem;
    }

    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc {
    
   NSLog(@"Type Instityte Controller dealloc");

    if (self.wasSelect == YES) {
    [self passDataBack];
    }

}


#pragma mark - UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrayNamesType count];
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Identifier";
    
    UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }


    NSString* keyImage  = [NSString stringWithFormat:@"%@",[self.arrayNamesType objectAtIndex:indexPath.row]];
    NSString* nameImage = [NSString stringWithFormat:@"TypesInstitution/%@",[self.dictNameImage valueForKey:keyImage]];
    
    cell.textLabel.text   =  [self.arrayNamesType objectAtIndex:indexPath.row];

    cell.imageView.image  =  [UIImage imageNamed:nameImage];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath   *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    self.wasSelect = YES;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}


#pragma mark - Action method

-(void) backAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Pass data

-(void)passDataBack {
    
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    
    if (![selectedIndexPath isEqual:nil]) {
        
    
    NSString* nameBuild = [self.arrayNamesType objectAtIndex:selectedIndexPath.row];
    NSString* nameImage = [self.dictNameImage valueForKey:nameBuild];

        
    NSLog(@"\nPassDataBack \nName Build = %@\nName Image = %@\n\n",nameBuild,nameImage);
   

    [self.delegate dataFromDateDetailTypeController:nameBuild imageNamed:nameImage];
    
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Ошибочка" message:@"nil в passDataBack" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    
}


@end
