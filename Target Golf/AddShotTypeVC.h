//
//  ClubAndSwingDetailViewController.h
//  Target Golf
//
//  Created by Claire Wright on 17/06/2013.
//  Copyright (c) 2013 Claire Wright. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShotType.h"
#import "ShotTypeTVC.h"

@protocol AddShotTypeVCDelegate;

@interface AddShotTypeVC : UIViewController




@property (nonatomic, strong) id <AddShotTypeVCDelegate> delegate;
@property (nonatomic, strong) NSManagedObjectContext *context;

- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender;

@end

@protocol AddShotTypeVCDelegate

-(void)addShotTypeVC: (AddShotTypeVC *) controller didFinishWithSave: (BOOL) save;

@end