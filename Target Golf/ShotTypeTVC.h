//
//  ShotTypeTVC.h
//  Target Golf
//
//  Created by Claire Wright on 18/06/2013.
//  Copyright (c) 2013 Claire Wright. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Club.h"

@protocol ClubDelegate;


@interface ShotTypeTVC : UITableViewController <NSFetchedResultsControllerDelegate>
{
}
@property (nonatomic, weak) id <ClubDelegate> delegate;
@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) Club *currentClub;

@end

@protocol ClubDelegate <NSObject>

- (void) selectedClub: (Club *) club;

@end