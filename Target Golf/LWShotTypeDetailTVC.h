//
//  LWShotTypeDetailTVC.h
//  Target Golf
//
//  Created by Claire Wright on 11/06/2013.
//  Copyright (c) 2013 Claire Wright. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Club.h"
#import "Swing.h"

@interface LWShotTypeDetailTVC : UITableViewController

@property Club *currentClub;
@property Swing *currentSwing;
@property NSManagedObjectContext *context;


@end
