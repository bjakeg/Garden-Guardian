//
//  SunlightView.h
//  Garden Guardian
//
//  Created by Jake Graham on 3/30/17.
//  Copyright © 2017 Jake Graham. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SunlightView : UIView

@property (nonatomic, assign) int sunlight;

- (id) initWithFrame:(CGRect)frame sunlight:(int)sunlight;

@end
