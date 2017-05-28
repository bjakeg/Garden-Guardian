#import "DBManager.h"
static DBManager *sharedInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;

@implementation DBManager

+(DBManager*)getSharedInstance{
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance createDB];
    }
    return sharedInstance;
}


-(BOOL)createDB{
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString:
                    [docsDir stringByAppendingPathComponent: @"data.db"]];
    BOOL isSuccess = YES;
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: databasePath ] == NO)
    {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt =
            "create table if not exists dataPoints (id integer primary key, time text, sunVal text, moistureVal text, tempVal text, pHVal text)";
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                isSuccess = NO;
                NSLog(@"Failed to create table");
            }
            sqlite3_close(database);
            return  isSuccess;
        }
        else {
            isSuccess = NO;
            NSLog(@"Failed to open/create database");
        }
    }
    return isSuccess;
}

- (BOOL) saveData:(NSString*)rate time:(NSString*)time
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insertSQL =
            [NSString stringWithFormat:@"insert into heartRates (rate, time) values (\"%@\", \"%@\")", rate, time];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            return YES;
        } else {
            return NO;
        }
        sqlite3_reset(statement);
    }
    return NO;
}

- (BOOL)saveDataPoint:(GGDataPoint *)data {
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        
        NSString *insertSQL =
        [NSString stringWithFormat:@"insert into dataPoints (time, sunVal, moistureVal, tempVal, pHVal) values (\"%i\", \"%i\", \"%i\", \"%i\", \"%2.1f\")",
            data.time,
            data.sunVal,
            data.moistureVal,
            data.tempVal,
            data.pHVal];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            return YES;
        } else {
            return NO;
        }
        sqlite3_reset(statement);
    }

    return NO;
}

/*
- (BOOL) saveHeartRate:(HeartRate *) rate {
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insertSQL =
        [NSString stringWithFormat:@"insert into heartRates (rate, time) values (\"%i\", \"%@\")", rate.heartRate, rate.time];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            return YES;
        } else {
            return NO;
        }
        sqlite3_reset(statement);
    }
    return NO;
}
*/
-(NSArray*)findLast50Data {
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"select * from dataPoints order by time desc limit 50"];
        const char *query_stmt = [querySQL UTF8String];
        NSMutableArray *resultArray = [[NSMutableArray alloc]init];
        if (sqlite3_prepare_v2(database,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *time = [[NSString alloc] initWithUTF8String:
                                        (const char *) sqlite3_column_text(statement, 1)];
                NSString *sunVal = [[NSString alloc]initWithUTF8String:
                                        (const char *) sqlite3_column_text(statement, 2)];
                NSString *moistureVal = [[NSString alloc]initWithUTF8String:
                                        (const char *) sqlite3_column_text(statement, 3)];
                NSString *tempVal = [[NSString alloc]initWithUTF8String:
                                        (const char *) sqlite3_column_text(statement, 4)];
                NSString *pHVal = [[NSString alloc]initWithUTF8String:
                                        (const char *) sqlite3_column_text(statement, 5)];
                GGDataPoint *newPoint = [[GGDataPoint alloc] init];
                newPoint.time = (int)[time integerValue];
                newPoint.sunVal = (uint8_t)[sunVal integerValue];
                newPoint.moistureVal = (uint8_t)[moistureVal integerValue];
                newPoint.tempVal = (uint8_t)[tempVal integerValue];
                newPoint.pHVal = (float)[pHVal floatValue];
                [resultArray addObject:newPoint];
                
            }
            sqlite3_reset(statement);
            return resultArray;
        }
    }
    return nil;
}

-(NSArray*)findLastData {
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"select * from dataPoints order by time desc limit 1"];
        const char *query_stmt = [querySQL UTF8String];
        NSMutableArray *resultArray = [[NSMutableArray alloc]init];
        if (sqlite3_prepare_v2(database,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *time = [[NSString alloc] initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 1)];
                NSString *sunVal = [[NSString alloc]initWithUTF8String:
                                    (const char *) sqlite3_column_text(statement, 2)];
                NSString *moistureVal = [[NSString alloc]initWithUTF8String:
                                         (const char *) sqlite3_column_text(statement, 3)];
                NSString *tempVal = [[NSString alloc]initWithUTF8String:
                                     (const char *) sqlite3_column_text(statement, 4)];
                NSString *pHVal = [[NSString alloc]initWithUTF8String:
                                   (const char *) sqlite3_column_text(statement, 5)];
                GGDataPoint *newPoint = [[GGDataPoint alloc] init];
                newPoint.time = (int)[time integerValue];
                newPoint.sunVal = (uint8_t)[sunVal integerValue];
                newPoint.moistureVal = (uint8_t)[moistureVal integerValue];
                newPoint.tempVal = (uint8_t)[tempVal integerValue];
                newPoint.pHVal = (float)[pHVal floatValue];
                [resultArray addObject:newPoint];
                
            }
            sqlite3_reset(statement);
            return resultArray;
        }
    }
    return nil;
}


- (NSArray *)findDataBetweenTime:(NSTimeInterval)fromTime toTime:(NSTimeInterval)toTime {
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {

        
        NSString *querySQL = [NSString stringWithFormat:
                              @"select * from dataPoints where time >= %i and time <= %i",(int)fromTime,(int)toTime];
        const char *query_stmt = [querySQL UTF8String];
        NSMutableArray *resultArray = [[NSMutableArray alloc]init];
        if (sqlite3_prepare_v2(database,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *time = [[NSString alloc] initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 1)];
                NSString *sunVal = [[NSString alloc]initWithUTF8String:
                                    (const char *) sqlite3_column_text(statement, 2)];
                NSString *moistureVal = [[NSString alloc]initWithUTF8String:
                                         (const char *) sqlite3_column_text(statement, 3)];
                NSString *tempVal = [[NSString alloc]initWithUTF8String:
                                     (const char *) sqlite3_column_text(statement, 4)];
                NSString *pHVal = [[NSString alloc]initWithUTF8String:
                                   (const char *) sqlite3_column_text(statement, 5)];
                GGDataPoint *newPoint = [[GGDataPoint alloc] init];
                newPoint.time = (int)[time integerValue];
                int sunValTemp = (uint8_t)[sunVal integerValue];
                newPoint.sunVal = sunValTemp;
                newPoint.moistureVal = (uint8_t)[moistureVal integerValue];
                int tempTempVal = (int)[tempVal integerValue];
                newPoint.tempVal = tempTempVal;
                newPoint.pHVal = (float)[pHVal floatValue];
                [resultArray addObject:newPoint];
                
            }
            sqlite3_reset(statement);
            return resultArray;
        }
    }
    return nil;
}

@end

