//
//  ShotType.h
//  Target Golf
//
//  Created by Brian Wright on 21/06/2013.
//  Copyright (c) 2013 Claire Wright. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Shot;

@interface ShotType : NSManagedObject

@property (nonatomic, retain) NSDate * lastUsed;
@property (nonatomic, retain) NSString * length;
@property (nonatomic, retain) NSString * club;
@property (nonatomic, retain) NSSet *shots;
@end

@interface ShotType (CoreDataGeneratedAccessors)

- (void)addShotsObject:(Shot *)value;
- (void)removeShotsObject:(Shot *)value;
- (void)addShots:(NSSet *)values;
- (void)removeShots:(NSSet *)values;

@end
