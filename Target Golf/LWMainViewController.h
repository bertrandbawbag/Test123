//
//  LWMainViewController.h
//  Target Golf
//
//  Created by Claire Wright on 02/06/2013.
//  Copyright (c) 2013 Claire Wright. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Location.h"
#import "Shot.h"
#import "Swing.h"
#import "Club.h"

@interface LWMainViewController : UIViewController <CLLocationManagerDelegate>
{
    
    Location *currentTeeLocation;
    Location *currentTargetLocation;
    Location *currentBallLocation;
    Swing *currentSwing;
    Club *currentClub;
    
    
    CLLocation *currentTeeCoreLocation;
    CLLocation *currentTargetCoreLocation;

}

@property (weak, nonatomic) IBOutlet UIButton *setTeeLocationButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *setTargetLocationButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *setBallLocationButtonOutlet;


@property (weak, nonatomic) IBOutlet UIButton *setShotTypeButtonOutlet;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property NSManagedObjectContext *context;
@property CLLocationManager *locationManager;

- (IBAction)setTargetButton:(UIButton *)sender;
- (IBAction)setTeeButton:(UIButton *)sender;
- (IBAction)setBallLocationButton:(UIButton *)sender;
- (IBAction)setShotTypeButton:(UIButton *)sender;

@end
