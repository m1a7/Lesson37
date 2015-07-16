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
    
   NSLog(@"Type Instityte Controller dealloc -> pasDataBack ");
   
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
    
    NSLog(@"Type Instityte Controller | passDataBack ");
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    
    if (![selectedIndexPath isEqual:nil]) {
        
    
    NSString* nameBuild = [self.arrayNamesType objectAtIndex:selectedIndexPath.row];
    NSString* nameImage = [self.dictNameImage valueForKey:nameBuild];

       /*
        if ([self.delegate respondsToSelector:@selector(dataFromDateDetailTypeController::)])
          {
              NSLog(@"Сука это passDataBack в самом внутри");
            [self.delegate dataFromDateDetailTypeController:nameBuild imageNamed:nameImage];
          }*/
    [self.delegate dataFromDateDetailTypeController:nameBuild imageNamed:nameImage];
    //selectedIndexPath = nil;
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Ошибкачка" message:@"nil в passDataBack" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    
}



/*
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
