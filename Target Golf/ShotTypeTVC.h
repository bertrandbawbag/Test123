//
//  ShotTypeTVC.h
//  Target Golf
//
//  Created by Claire Wright on 18/06/2013.
//  Copyright (c) 2013 Claire Wright. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShotType.h"

@protocol ShotTypeTVCDelegate;


@interface ShotTypeTVC : UITableViewController <NSFetchedResultsControllerDelegate>
{
}
@property (nonatomic, weak) id <ShotTypeTVCDelegate> delegate;
@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) ShotType *currentShotType;

@end

@protocol ShotTypeTVCDelegate <NSObject>

- (void) selectedShotType: (ShotType *) shotType;

@end