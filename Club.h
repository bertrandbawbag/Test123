//
//  Club.h
//  Target Golf
//
//  Created by Claire Wright on 02/06/2013.
//  Copyright (c) 2013 Claire Wright. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Shot;

@interface Club : NSManagedObject

@property (nonatomic, retain) NSString * number;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSSet *shots;
@end

@interface Club (CoreDataGeneratedAccessors)

- (void)addShotsObject:(Shot *)value;
- (void)removeShotsObject:(Shot *)value;
- (void)addShots:(NSSet *)values;
- (void)removeShots:(NSSet *)values;

@end
