//
//  MoistureView.h
//  Garden Guardian
//
//  Created by Jake Graham on 3/30/17.
//  Copyright © 2017 Jake Graham. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoistureView : UIView

@property (nonatomic, assign) int moisture;

- (id) initWithFrame:(CGRect)frame moisture:(int)moisture;

@end
