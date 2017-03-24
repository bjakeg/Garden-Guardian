//
//  BTConnectionHandler.m
//  Garden Guardian
//
//  Created by Jake Graham on 3/22/17.
//  Copyright © 2017 Jake Graham. All rights reserved.
//

#import "BTConnectionHandler.h"

@implementation BTConnectionHandler {
    NSMutableArray *_peripheralArray;
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
    if ([localName isEqualToString:@"SensorTag"]) {
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
        NSLog(@"Characterisitc: %@", aChar.UUID);
        
        [self.peripheral setNotifyValue:YES forCharacteristic:aChar];
        if ([aChar.UUID isEqual:[CBUUID UUIDWithString:@"F0001121-0451-4000-B000-000000000000"]]) {
            [peripheral setNotifyValue:YES forCharacteristic:aChar];
        }
        if ([aChar.UUID isEqual:[CBUUID UUIDWithString:@"F0001122-0451-4000-B000-000000000000"]]) {
            [peripheral setNotifyValue:YES forCharacteristic:aChar];
        }
        if ([aChar.UUID isEqual:[CBUUID UUIDWithString:@"F0001131-0451-4000-B000-000000000000"]]) {
            [peripheral setNotifyValue:YES forCharacteristic:aChar];
            //[peripheral readValueForCharacteristic:aChar];
            
            //NSLog(@"String Value: %@", aChar);
            
        }
        if ([aChar.UUID isEqual:[CBUUID UUIDWithString:@"F0001132-0451-4000-B000-000000000000"]]) {
            [peripheral setNotifyValue:YES forCharacteristic:aChar];
            //[peripheral readValueForCharacteristic:aChar];
            
            NSLog(@"String Value: %@", aChar);
            
        }
    }
}

// Invoked when you retrieve a specified characteristic's value, or when the peripheral device notifies your app that the characteristic's value has changed.
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"F0001131-0451-4000-B000-000000000000"]]) {
        //NSLog(@"String Value: %@", characteristic.value);
        NSString *string = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
        NSLog(@"Decoded string: %@", string);
        //[self.delegate heartRateUpdated:(int)[string integerValue]];
        //[self.peripheral readValueForCharacteristic:characteristic];
        for (int i = 0; i < 10000000; i++);
        
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"F0001132-0451-4000-B000-000000000000"]]) {
        //NSLog(@"String Value: %@", characteristic.value);
        NSString *string = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
        NSLog(@"Decoded string: %@", string);
        //[self.delegate heartRateUpdated:(int)[string integerValue]];
        // [self.peripheral readValueForCharacteristic:characteristic];
        
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"F0001121-0451-4000-B000-000000000000"]]) {
        
        NSLog(@"Left updated to :%@", characteristic.value);
        const uint8_t *bytes = [characteristic.value bytes]; // pointer to the bytes in data
        int value = bytes[0];
        // TODO: Store reading here
    }
}

- (void) peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    NSLog(@"\n\nCharacteristic: %@ Error: %@\n\n", characteristic.UUID, error);
    
}

- (void) peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error {
    
}


@end
