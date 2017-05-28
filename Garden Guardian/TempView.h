//
//  TempView.h
//  Garden Guardian
//
//  Created by Jake Graham on 3/30/17.
//  Copyright © 2017 Jake Graham. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TempView : UIView

@property (nonatomic, assign) int temp;

- (id) initWithFrame:(CGRect)frame temp:(int)temp;

@end
