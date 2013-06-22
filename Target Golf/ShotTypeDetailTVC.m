//
//  LWShotTypeDetailTVC.m
//  Target Golf
//
//  Created by Claire Wright on 11/06/2013.
//  Copyright (c) 2013 Claire Wright. All rights reserved.
//

#import "ShotTypeDetailTVC.h"
#import "AddShotTypeVC.h"

@interface ShotTypeDetailTVC ()

@end

@implementation ShotTypeDetailTVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    

}
                                  
                                  

-(void)viewWillAppear:(BOOL)animated
{
    
    self.navigationController.navigationBarHidden = NO;
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"ShotType" inManagedObjectContext:self.context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    // Set example predicate and sort orderings...
    // NSNumber *minimumSalary = ...;
    // NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(lastName LIKE[c] 'Worsley') AND (salary > %@)", minimumSalary];
    // [request setPredicate:predicate];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"lastUsed" ascending:YES];
    [request setSortDescriptors:@[sortDescriptor]];
    
    NSError *error;
    clubs = [self.context executeFetchRequest:request error:&error];
    if (clubs == nil)
    {
        // Deal with error...
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return clubs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Club Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    ShotType *clubForRow = [clubs objectAtIndex:indexPath.row];
    
    [cell.textLabel setText:[NSString stringWithFormat:@"%@",clubForRow.club]];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@", clubForRow.length]];

    return cell;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"Select Shot"])
    {
        // Get reference to the destination view controller
        // AddShotTypeVC *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        
        // [vc setCurrentShotType:[self currentShotType]];
        // [vc setContext:[self context]];
    }
}

-(void) addButtonPressed
{
    [self performSegueWithIdentifier:@"Club Details" sender:self];
}
                                  
//TODO: Add editing and deletion of objects http://www.appcoda.com/core-data-tutorial-update-delete/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (IBAction)unwindFromAddClubCancel:(UIStoryboardSegue *)segue {
    
    // AddShotTypeVC *sourceVC = segue.sourceViewController;
    
}

- (IBAction)unwindFromAddClubSave:(UIStoryboardSegue *)segue {
    
    // AddShotTypeVC *sourceVC = segue.sourceViewController;
    
    // self.currentShotType.club = sourceVC.clubTypeTextField.text;
    // self.currentShotType.length = sourceVC.clubSwingLengthTextField.text;
    self.currentShotType.lastUsed = [NSDate date];

    NSError *error = nil;
    if (![self.context save:&error]) {
        // Handle the error.
    }
    
    [self.tableView reloadData];
}


@end
