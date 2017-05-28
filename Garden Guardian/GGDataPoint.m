//
//  GGDataPoint.m
//  Garden Guardian
//
//  Created by Jake Graham on 4/26/17.
//  Copyright © 2017 Jake Graham. All rights reserved.
//

#import "GGDataPoint.h"

@implementation GGDataPoint

- (id) initWithTime:(int)time
             sunVal:(uint8_t)sunVal
        moistureVal:(uint8_t)moistureVal
            tempVal:(uint8_t)tempVal
              pHVal:(uint8_t)pHVal {
    self = [super init];
    if (self) {
        _time = time;
        _sunVal = sunVal;
        _moistureVal = moistureVal;
        _tempVal = tempVal;
        _pHVal = pHVal;
    }
    return self;
}

//- (void)setSunVal:(int)sunVal {
//    double temp = pow(10, .005 * sunVal);
//    double max = pow(10, .005 * 250);
//    sunVal = (temp/max) * 100;
//    _sunVal = sunVal;
//}
//
//- (void)setMoistureVal:(int)moistureVal {
//    moistureVal = ((float)moistureVal/100.f)*100;
//    _moistureVal = moistureVal;
//}
//
//- (void)setTempVal:(int)tempVal {
//    tempVal = (1.8f * tempVal) + 32;
//    if (tempVal > 150) {
//        tempVal = 150;
//    }
//    _tempVal = tempVal;
//}
//
//- (void)setPHVal:(CGFloat)pHVal {
//    pHVal = 10.49078 - .07135255*pHVal + .0001773836*pHVal*pHVal;
//    _pHVal = pHVal;
//}

@end
