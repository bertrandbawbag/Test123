//
//  GraphViewController.h
//  Target Golf
//
//  Created by Claire Wright on 02/07/2013.
//  Copyright (c) 2013 Claire Wright. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"
#import "ShotType.h"

@interface GraphViewController : UIViewController <CPTPlotDataSource>

@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) ShotType *currentShotType;

@end
