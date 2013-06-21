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
    
}

@property (nonatomic, strong) Club *club;


//TODO: Do i need a different context to save only clubs
//TODO: Do not want repeat versions of entities


@end


// These methods are used by the addclub view controller

@interface LWShotTypeDetailTVC (Private)

-(void) setUpUndoManager;
-(void) cleanUpUndoManager;


@end