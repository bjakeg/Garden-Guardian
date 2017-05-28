//
//  BTConnectionHandler.m
//  Garden Guardian
//
//  Created by Jake Graham on 3/22/17.
//  Copyright © 2017 Jake Graham. All rights reserved.
//

#import "BTConnectionHandler.h"
#import "GGDataPoint.h"
#import "DBManager.h"

static BTConnectionHandler *sharedInstance = nil;

@implementation BTConnectionHandler {
    NSMutableArray *_peripheralArray;
    CBCharacteristic *_2A1C;
    CBCharacteristic *_2A21;
}

+(BTConnectionHandler*)getSharedInstance{
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL]init];
    }
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        // Scan for all available CoreBluetooth LE devices
        CBCentralManager *centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
        [centralManager scanForPeripheralsWithServices:nil options:nil];
        self.centralManager = centralManager;
        
        _peripheralArray = [NSMutableArray array];
    }
    return self;
}


#pragma mark - CBCentralManagerDelegate

// method called whenever you have successfully connected to the BLE peripheral
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    [peripheral setDelegate:self];
    [peripheral discoverServices:nil];
}

// CBCentralManagerDelegate - This is called with the CBPeripheral class as its main input parameter. This contains most of the information there is to know about a BLE peripheral.
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    NSString *localName = [advertisementData objectForKey:CBAdvertisementDataLocalNameKey];
    if (localName != nil || peripheral.name != nil) {
        if (![_peripheralArray containsObject:peripheral]) {
            [_peripheralArray addObject:peripheral];
        }
    }
    NSLog(@"Name %@", peripheral.name);
    NSLog(@"LocalName %@", localName);
    NSLog(@"UUID %@", peripheral.identifier.UUIDString);
    if ([peripheral.name isEqualToString:@"Garden Guardian"]) {
        [self.centralManager stopScan];
        self.peripheral = peripheral;
        peripheral.delegate = self;
        [self.centralManager connectPeripheral:peripheral options:nil];
    }
}

// method called whenever the device state changes.
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    // Determine the state of the peripheral
    if ([central state] == CBCentralManagerStatePoweredOff) {
        NSLog(@"CoreBluetooth BLE hardware is powered off");
    }
    else if ([central state] == CBCentralManagerStatePoweredOn) {
        NSLog(@"CoreBluetooth BLE hardware is powered on and ready");
        [self.centralManager scanForPeripheralsWithServices:nil options:nil];
    }
    else if ([central state] == CBCentralManagerStateUnauthorized) {
        NSLog(@"CoreBluetooth BLE state is unauthorized");
    }
    else if ([central state] == CBCentralManagerStateUnknown) {
        NSLog(@"CoreBluetooth BLE state is unknown");
    }
    else if ([central state] == CBCentralManagerStateUnsupported) {
        NSLog(@"CoreBluetooth BLE hardware is unsupported on this platform");
    }
}


#pragma mark - CBPeripheralDelegate

// CBPeripheralDelegate - Invoked when you discover the peripheral's available services.
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    // Update to show connected status
    for (CBService *service in peripheral.services) {
        NSLog(@"Discovered service: %@", service.UUID);
        [peripheral discoverCharacteristics:nil forService:service];
    }
}

// Invoked when you discover the characteristics of a specified service.
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)            service error:(NSError *)error {
    for (CBCharacteristic *aChar in service.characteristics)
    {
        NSLog(@"New Characterisitc: %@", aChar.UUID);
        
        //[self.peripheral setNotifyValue:YES forCharacteristic:aChar];
        if ([aChar.UUID isEqual:[CBUUID UUIDWithString:@"2A1C"]]) {
//            _2A1C = aChar;
//            [peripheral readValueForCharacteristic:aChar];
//            [self.peripheral setNotifyValue:YES forCharacteristic:aChar];
        }
        if ([aChar.UUID isEqual:[CBUUID UUIDWithString:@"2A1E"]]) {
            [peripheral setNotifyValue:YES forCharacteristic:aChar];
        }
        if ([aChar.UUID isEqual:[CBUUID UUIDWithString:@"2A21"]]) {
//            _2A21 = aChar;
//            [peripheral setNotifyValue:YES forCharacteristic:aChar];
//            NSLog(@"String Value: %@", aChar);
//            [peripheral readValueForCharacteristic:aChar];
//            char arr[] = {0x22, 0x21};
//            NSData *val = [NSData dataWithBytes:arr length:2];
//            //[peripheral writeValue:val forCharacteristic:aChar type:CBCharacteristicWriteWithResponse];
            
        }
    }
}

// Invoked when you retrieve a specified characteristic's value, or when the peripheral device notifies your app that the characteristic's value has changed.
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    //NSLog(@"%@", characteristic.UUID);
    // Notify
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A1E"]]) {
        NSLog(@"2A1E Value: %@", characteristic.value);
        
        CGFloat difference;
        NSArray *points = [[DBManager getSharedInstance] findLast50Data];
        if (points.count > 0) {
            GGDataPoint *lastPoint = [points objectAtIndex:0];
            NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
            difference = currentTime - lastPoint.time;
        } else {
            difference = 2000000;
        }
        GGDataPoint *point = [self parseNotifyResponse:characteristic.value];
        [self.delegate newNotfiyPoint:point];

        NSDictionary *dict = [NSDictionary dictionaryWithObject:point forKey:@"message"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationMessageEvent" object:nil userInfo:dict];
        
        if (difference > 30*60) {
            [[DBManager getSharedInstance] saveDataPoint:point];
        }
    }
    // Intermediate
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A1C"]]) {
        //NSLog(@"2A1C Value: %@", characteristic.value);
//        GGDataPoint *point = [self parseIntermediateResponse:characteristic.value];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A21"]]) {
        //NSLog(@"2A21 Value: %@", characteristic.value);
    }
}

- (void) peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    NSLog(@"\n\nCharacteristic: %@ Error: %@\n\n", characteristic.UUID, error);
    
}

- (void) peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error {
    NSLog(@"Descriptor: %@  Error: %@", descriptor, error);
}


- (GGDataPoint *)parseNotifyResponse:(NSData *)value {
    GGDataPoint *newPoint = [[GGDataPoint alloc] init];
    newPoint.time = [NSDate timeIntervalSinceReferenceDate]; // No time for notify value
    
    uint8_t tempVal;
    [value getBytes:&tempVal range:NSMakeRange(1, 1)];
    tempVal = (1.8f * tempVal) + 32;
    if (tempVal > 150) {
        tempVal = 150;
    }
    newPoint.tempVal = tempVal;
    
    uint8_t moistureVal;
    [value getBytes:&moistureVal range:NSMakeRange(2, 1)];
    moistureVal = ((float)moistureVal/140.f)*100;
    if (moistureVal > 100) {
        moistureVal = 100;
    }
    newPoint.moistureVal = moistureVal;
    
    uint8_t pHVal;
    [value getBytes:&pHVal range:NSMakeRange(3, 1)];
    CGFloat pHValF;
    pHValF = 10.49078 - .07135255*pHVal + .0001773836*pHVal*pHVal;
    newPoint.pHVal = pHValF;
    
    uint8_t sunVal;
    [value getBytes:&sunVal range:NSMakeRange(4, 1)];
    double temp = pow(10, .005 * sunVal);
    double max = pow(10, .005 * 250);
    sunVal = (temp/max) * 100;
    newPoint.sunVal = sunVal;

    return newPoint;
}

- (GGDataPoint *)parseIntermediateResponse:(NSData *)value {
    if (value == nil) {
        return nil;
    }
    GGDataPoint *newPoint = [[GGDataPoint alloc] init];
    newPoint.time = [NSDate timeIntervalSinceReferenceDate]; // No time for notify value
    
    uint8_t tempVal;
    [value getBytes:&tempVal range:NSMakeRange(1, 1)];
    tempVal = (1.8f * tempVal) + 32;
    if (tempVal > 150) {
        tempVal = 150;
    }
    newPoint.tempVal = tempVal;
    
    uint8_t moistureVal;
    [value getBytes:&moistureVal range:NSMakeRange(2, 1)];
    moistureVal = ((float)moistureVal/100.f)*100;
    newPoint.moistureVal = moistureVal;
    
    uint8_t pHVal;
    [value getBytes:&pHVal range:NSMakeRange(3, 1)];
    pHVal = 10.49078 - .07135255*pHVal + .0001773836*pHVal*pHVal;
    newPoint.pHVal = pHVal;
    
    uint8_t sunVal;
    [value getBytes:&sunVal range:NSMakeRange(4, 1)];
    double temp = pow(10, .005 * sunVal);
    double max = pow(10, .005 * 250);
    sunVal = (temp/max) * 100;
    newPoint.sunVal = sunVal;
    
    //int time;
    //[value getBytes:&time range:NSMakeRange(5, 4)];
    NSData *timeBytes = [value subdataWithRange:NSMakeRange(5, 4)];
    int time = CFSwapInt32BigToHost(*(int*)([timeBytes bytes]));
    newPoint.time = time;
    
    return newPoint;
}

@end
