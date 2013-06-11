//
//  Shot.h
//  Target Golf
//
//  Created by Claire Wright on 02/06/2013.
//  Copyright (c) 2013 Claire Wright. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Club, Location, Swing;

@interface Shot : NSManagedObject

@property (nonatomic, retain) NSNumber * ballDistanceFromTarget;
@property (nonatomic, retain) NSNumber * ballDistanceFromTee;
@property (nonatomic, retain) NSNumber * ballHeadingFromTarget;
@property (nonatomic, retain) Location *ballLocation;
@property (nonatomic, retain) Club *club;
@property (nonatomic, retain) Swing *swing;
@property (nonatomic, retain) Location *targetLocation;
@property (nonatomic, retain) Location *teeLocation;

@end
