//
//  ClubAndSwingDetailViewController.h
//  Target Golf
//
//  Created by Claire Wright on 17/06/2013.
//  Copyright (c) 2013 Claire Wright. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Club.h"

@interface AddShotTypeVC : UIViewController



@property Club *currentClub;
@property NSManagedObjectContext *context;


@property (weak, nonatomic) IBOutlet UITextField *clubTypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *clubSwingLengthTextField;

- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender;


@end
