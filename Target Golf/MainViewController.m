//
//  LWMainViewController.m
//  Target Golf
//
//  Created by Claire Wright on 02/06/2013.
//  Copyright (c) 2013 Claire Wright. All rights reserved.
//

#import "MainViewController.h"


@interface MainViewController ()

@end

@implementation MainViewController

#pragma mark - View Controller

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
    
    
    currentShotType = (ShotType *)[NSEntityDescription insertNewObjectForEntityForName:@"ShotType" inManagedObjectContext:self.context];
    currentTeeLocation = (Location *) [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:self.context];
    currentTargetLocation = (Location *) [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:self.context];
    currentBallLocation = (Location *) [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:self.context];

    
    [self.locationManager startUpdatingLocation];
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"Select ShotType"])
    {
        // Get reference to the destination view controller
        ShotTypeTVC *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        // [vc setCurrentClub:currentClub];
        [vc setDelegate:self];
        [vc setContext:[self context]];
        [vc setCurrentShotType:currentShotType];
    }}

#pragma mark - Core Location

- (CLLocationManager *)locationManager {
    
    if (_locationManager != nil) {
        return _locationManager;
    }
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    _locationManager.delegate = self;
    
    return _locationManager;
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    
    self.setShotTypeButtonOutlet.enabled = YES;
    self.setTargetLocationButtonOutlet.enabled = YES;
    self.setTeeLocationButtonOutlet.enabled = YES;
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    
    self.setShotTypeButtonOutlet = NO;
    self.setTargetLocationButtonOutlet = NO;
    self.setTeeLocationButtonOutlet = NO;
}

-(void) convertCLLocation:(CLLocation *) clLocation ToLocation:(Location *) newLocation
{
    
    
    CLLocationCoordinate2D coordinate = [clLocation coordinate];
    
    [newLocation setLatitude:[NSNumber numberWithDouble:coordinate.latitude]];
    [newLocation setLongitude:[NSNumber numberWithDouble:coordinate.longitude]];
    [newLocation setAltitude:[NSNumber numberWithDouble:clLocation.altitude]];
    [newLocation setDateCreated:[NSDate date]];
   
}

#pragma mark - User Interface

- (IBAction)setTargetButton:(UIButton *)sender {
    NSLog(@"%@", sender.titleLabel.text);
    
    currentTargetCoreLocation = [self.locationManager location];
    if (!currentTargetCoreLocation) {
        return;
    }

    [self convertCLLocation:currentTargetCoreLocation ToLocation:currentTargetLocation];
    
    [self.setTargetLocationButtonOutlet    setTitle:[NSString stringWithFormat:@"%@ %@", currentTargetLocation.latitude, currentTargetLocation.longitude] forState:UIControlStateNormal];
    
}

- (IBAction)setTeeButton:(UIButton *)sender {
    NSLog(@"%@", sender.titleLabel.text);
    
    currentTeeCoreLocation = [self.locationManager location];
    if (!currentTeeCoreLocation) {
        return;
    }
    
    [self convertCLLocation:currentTeeCoreLocation ToLocation:currentTeeLocation];
    
    [self.setTeeLocationButtonOutlet setTitle:[NSString stringWithFormat:@"%@ %@", currentTeeLocation.latitude, currentTeeLocation.longitude] forState:UIControlStateNormal];
    
    self.setBallLocationButtonOutlet.enabled = YES;

}

- (IBAction)setBallLocationButton:(UIButton *)sender {
    NSLog(@"%@", sender.titleLabel.text);
    
    CLLocation *location = [self.locationManager location];
    if (!location) {
        return;
    }
    

    Shot *shot = (Shot *)[NSEntityDescription insertNewObjectForEntityForName:@"Shot" inManagedObjectContext:self.context];
    
    [self convertCLLocation:location ToLocation:currentBallLocation];
    
    shot.ballLocation = currentBallLocation;
    shot.teeLocation = currentTeeLocation;
    shot.targetLocation = currentTargetLocation;
    shot.shotType = currentShotType;
    
//TODO: Ball location from Tee and Target
//TODO: Allow for no target
//TODO: allow for no tee
//TODO: allow for no club/swing
//TODO: check location accuracy
    
    
    CLLocationDistance distanceFromTee = [location distanceFromLocation:currentTeeCoreLocation];
    NSString *distanceString = [NSString stringWithFormat:@"%.0f", distanceFromTee];
    self.distanceLabel.text = distanceString;
    
    shot.ballDistanceFromTee = [NSNumber numberWithDouble:distanceFromTee];
    shot.ballDistanceFromTarget = [NSNumber numberWithDouble:[location distanceFromLocation:currentTargetCoreLocation]];
    

    NSError *error = nil;
    if (![self.context save:&error]) {
        // Handle the error.
    }

    
    
    NSLog(@"%@",shot.description);
    
}

- (IBAction)setShotTypeButton:(UIButton *)sender {
    NSLog(@"%@", sender.titleLabel.text);
    
}

// delegate to get currently selected club
- (void) selectedShotType: (ShotType *) shotType;
{
    currentShotType = shotType;
    
    [self.setShotTypeButtonOutlet setTitle:[NSString stringWithFormat:@"%@ %@", currentShotType.club, currentShotType.length] forState:UIControlStateNormal];
}


@end
