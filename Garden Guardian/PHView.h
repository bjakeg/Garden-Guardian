//
//  PHView.h
//  Garden Guardian
//
//  Created by Jake Graham on 3/30/17.
//  Copyright © 2017 Jake Graham. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PHView : UIView

@property (nonatomic, assign) CGFloat pH;

- (id) initWithFrame:(CGRect)frame pH:(CGFloat)pH;

@end
