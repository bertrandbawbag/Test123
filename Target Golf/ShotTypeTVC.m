//
//  ShotTypeTVC.m
//  Target Golf
//
//  Created by Claire Wright on 18/06/2013.
//  Copyright (c) 2013 Claire Wright. All rights reserved.
//

#import "ShotTypeTVC.h"
#import "Club.h"

@interface ShotTypeTVC ()

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) UIBarButtonItem *rightBarButtonItem;
@property (nonatomic,strong) NSIndexPath *checkedCell;

@end

@implementation ShotTypeTVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = FALSE;
    
    NSError *error;
    
    if (![[self fetchedResultsController] performFetch:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
    // [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    // Configure the cell to show the book's title
    Club *club = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    [cell.textLabel setText:[NSString stringWithFormat:@"%@ %@", club.number, club.type]];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@", club.length]];
    
    if ([self.checkedCell isEqual:indexPath]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else  {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections]objectAtIndex:section];
    
    NSLog(@"%i", [sectionInfo numberOfObjects]);
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Club Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSManagedObjectContext *moc = [self.fetchedResultsController managedObjectContext];
        
        // delete the object
        [moc deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error;
        if(![moc save:&error])  {
            // TODO: Proper error handling
            NSLog(@"Unresolved error %@, %@",error,[error userInfo]);
            abort();
        }
        
        // Delete the row from the data source - commented out to avoid assertion failure - called to avoid double call to numberOFRowsInSection
        // [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return NO;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    if (editing) {
        self.rightBarButtonItem = self.navigationItem.rightBarButtonItem;
        self.navigationItem.rightBarButtonItem = nil;
    }
    else {
        self.navigationItem.rightBarButtonItem = self.rightBarButtonItem;
        self.rightBarButtonItem = nil;
    }
}

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
    
    if(self.checkedCell)   {
        UITableViewCell *unCheckCell = [tableView cellForRowAtIndexPath:self.checkedCell];
        unCheckCell.accessoryType = UITableViewCellAccessoryNone;
    }
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.checkedCell = indexPath;
    
    [self.delegate selectedClub: (Club *) [self.fetchedResultsController objectAtIndexPath:indexPath]];
 
}

#pragma mark - Fetched Results Controller

-(NSFetchedResultsController *) fetchedResultsController
{
    if (_fetchedResultsController != nil)   {
        return _fetchedResultsController;
    }
    
    // create and configure fetchrequest for Club
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Club" inManagedObjectContext:self.context];
    [fetchRequest setEntity:entity];
    
    // define Sort descriptors
    NSSortDescriptor *dateDescriptor = [[NSSortDescriptor alloc]initWithKey:@"lastUsed" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:dateDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // create fetch results controller
    //TODO: Do I need a cache name?
    _fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest
                                                                   managedObjectContext:self.context
                                                                     sectionNameKeyPath:nil
                                                                              cacheName:nil];
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
    
}

#pragma mark - Fetched Results Controller Delegate Methods

-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:[tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                                                               withRowAnimation:UITableViewRowAnimationFade];
    break;
    
        case NSFetchedResultsChangeDelete:[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                                                           withRowAnimation:UITableViewRowAnimationFade];
            
            
    break;
        
        case NSFetchedResultsChangeUpdate:[self configureCell:[tableView cellForRowAtIndexPath:indexPath]
                                                  atIndexPath:indexPath];
    break;
        
        case NSFetchedResultsChangeMove:[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                                                         withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            
    break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    
    [self.tableView endUpdates];
}


@end
