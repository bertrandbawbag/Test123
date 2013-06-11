//
//  LWClubAndSwingMasterViewController.m
//  Target Golf
//
//  Created by Brian Wright on 09/06/2013.
//  Copyright (c) 2013 Claire Wright. All rights reserved.
//

#import "LWClubAndSwingMasterViewController.h"

@interface LWClubAndSwingMasterViewController ()
{
    NSArray *clubs;
}


@end

@implementation LWClubAndSwingMasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.clubPickerOutlet.delegate = self;
    self.clubPickerOutlet.dataSource = self;
    
    [self.navigationController setNavigationBarHidden:NO];
    
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Club" inManagedObjectContext:[self context]];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    // Set example predicate and sort orderings...
    // NSNumber *minimumSalary = ...;
    // NSPredicate *predicate = [NSPredicate predicateWithFormat:
    //                          @"(lastName LIKE[c] 'Worsley') AND (salary > %@)", minimumSalary];
    // [request setPredicate:predicate];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"number" ascending:YES];
    [request setSortDescriptors:@[sortDescriptor]];
    
    
    
    NSError *error;
    clubs = [[self context] executeFetchRequest:request error:&error];
    if (clubs == nil)
    {
        // Deal with error...
    }
    
    for (Club *club in clubs) {
        NSLog(@"%@ %@", club.number, club.type);
    }
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.clubPickerOutlet reloadAllComponents];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPicker

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    //set number of rows
    NSLog(@"%.0lu",(unsigned long)clubs.count);
    return clubs.count;
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    Club *chosenClub = [clubs objectAtIndex:row];
    if(component == 0)
    {
        NSLog(@"%@",chosenClub.number);
        return chosenClub.number;
        
    }
    else
    {
        NSLog(@"%@",chosenClub.type);
        return chosenClub.type;
        
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"row %i selected", row);
    
}
@end
