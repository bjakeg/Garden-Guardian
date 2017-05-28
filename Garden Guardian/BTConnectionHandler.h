//
//  BTConnectionHandler.h
//  Garden Guardian
//
//  Created by Jake Graham on 3/22/17.
//  Copyright © 2017 Jake Graham. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>
#import <Foundation/Foundation.h>
#import "GGDataPoint.h"
#define POLARH7_HRM_DEVICE_INFO_SERVICE_UUID @"180A"

@protocol BTConnectionHandlerDelegate;

@interface BTConnectionHandler : NSObject <CBCentralManagerDelegate, CBPeripheralDelegate>

+ (BTConnectionHandler *)getSharedInstance;

@property (nonatomic, strong) CBCentralManager *centralManager;
@property (nonatomic, strong) CBPeripheral     *peripheral;
@property (nonatomic, assign) id<BTConnectionHandlerDelegate> delegate;

@end

@protocol BTConnectionHandlerDelegate <NSObject>

@required
- (void)newDataPoint:(GGDataPoint *)dataPoint;
- (void)newNotfiyPoint:(GGDataPoint *)dataPoint;
@end
