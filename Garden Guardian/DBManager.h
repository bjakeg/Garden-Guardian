//
//  DBManager.h
//  Heart Rate Monitor
//
//  Created by Jake Graham on 3/27/16.
//  Copyright © 2016 Jake Graham. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "GGDataPoint.h"

@interface DBManager : NSObject
{
    NSString *databasePath;
}

+ (DBManager*)getSharedInstance;
- (BOOL)createDB;
- (BOOL)saveDataPoint:(GGDataPoint *)data;
- (NSArray*)find24HourData;
- (NSArray*)findWeekData;
- (NSArray*)findMonthData;
- (NSArray*)findLast50Data;
- (NSArray *)findDataBetweenTime:(NSTimeInterval)fromTime toTime:(NSTimeInterval)toTime;
- (NSArray*)findLastData;
@end
