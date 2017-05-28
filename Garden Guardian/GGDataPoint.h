//
//  GGDataPoint.h
//  Garden Guardian
//
//  Created by Jake Graham on 4/26/17.
//  Copyright © 2017 Jake Graham. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GGDataPoint : NSObject

@property (nonatomic, assign) long int time;
@property (nonatomic, assign) int sunVal;
@property (nonatomic, assign) int moistureVal;
@property (nonatomic, assign) int tempVal;
@property (nonatomic, assign) CGFloat pHVal;

- (id) initWithTime:(int)time
             sunVal:(uint8_t)sunVal
        moistureVal:(uint8_t)moistureVal
            tempVal:(uint8_t)tempVal
              pHVal:(uint8_t)pHVal;

@end
