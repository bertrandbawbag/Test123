//
//  LWShotTypeDetailTVC.h
//  Target Golf
//
//  Created by Claire Wright on 11/06/2013.
//  Copyright (c) 2013 Claire Wright. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Club.h"


@interface LWShotTypeDetailTVC : UITableViewController
{
    NSArray *clubs;
    
}

@property Club *currentClub;
@property NSManagedObjectContext *context;

@end
