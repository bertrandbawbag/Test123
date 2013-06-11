//
//  LWClubAndSwingMasterViewController.h
//  Target Golf
//
//  Created by Brian Wright on 09/06/2013.
//  Copyright (c) 2013 Claire Wright. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Club.h"
#import "Swing.h"


@interface LWClubAndSwingMasterViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property Club *currentClub;
@property Swing *currentSwing;
@property NSManagedObjectContext *context;

@property (weak, nonatomic) IBOutlet UIPickerView *clubPickerOutlet;

@end
