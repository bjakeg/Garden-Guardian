//
//  TempView.m
//  Garden Guardian
//
//  Created by Jake Graham on 3/30/17.
//  Copyright © 2017 Jake Graham. All rights reserved.
//

#import "TempView.h"
#import "GardenGuardianKit.h"

@implementation TempView {
    UIImageView *_tempImageView;
    UILabel *_titleLabel;
    UILabel *_valueLabel;
}

- (id) initWithFrame:(CGRect)frame temp:(int)temp {
    self = [super initWithFrame:frame];
    if (self) {
        _temp = temp;
        
        self.layer.cornerRadius = 15;
        self.layer.masksToBounds = YES;
        
        self.clipsToBounds = NO;
        self.layer.shadowColor = [[UIColor blackColor] CGColor];
        self.layer.shadowOffset = CGSizeMake(0,5);
        self.layer.shadowOpacity = 0.5;
        
        self.backgroundColor = [UIColor colorWithRed:226.0f/255.0f
                                               green:226.0f/255.0f
                                                blue:226.0f/255.0f
                                               alpha:255.0f/255.0f];
        
        _tempImageView = [[UIImageView alloc] initWithFrame:CGRectMake(82.5, 5, 30, 120)];
        UIImage *image = [GardenGuardianKit imageOfTempWithTempFill:temp];
        [_tempImageView setImage:[UIImage imageWithCGImage:image.CGImage
                                                         scale:image.scale
                                                   orientation:UIImageOrientationDownMirrored]];
        [self addSubview:_tempImageView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"Temperature:";
        [_titleLabel sizeToFit];
        CGRect titleFrame = _titleLabel.frame;
        titleFrame = CGRectMake((frame.size.width-180) + (frame.size.width-180)/2 - titleFrame.size.width/2,
                                45,
                                titleFrame.size.width,
                                titleFrame.size.height);
        _titleLabel.frame = titleFrame;
        [self addSubview:_titleLabel];
        
        _valueLabel = [[UILabel alloc] init];
        _valueLabel.text = [NSString stringWithFormat:@"%iF", temp];
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"temp_setting"]) {
            temp = (temp - 32.0f) * (5.0f/9.0f);
            _valueLabel.text = [NSString stringWithFormat:@"%iC", temp];
        }
        _valueLabel.font = [UIFont boldSystemFontOfSize:20];
        [_valueLabel sizeToFit];
        CGRect valueFrame = _valueLabel.frame;
        valueFrame = CGRectMake((titleFrame.origin.x + titleFrame.size.width)/2 + titleFrame.origin.x/2 - valueFrame.size.width/2,
                                70,
                                valueFrame.size.width + 20,
                                valueFrame.size.height);
        _valueLabel.frame = valueFrame;
        [self addSubview:_valueLabel];
    }
    return self;
}

- (void)setTemp:(int)temp {
    if (temp > 150) {
        temp = 150;
    }
    _temp = temp;
    UIImage *image = [GardenGuardianKit imageOfTempWithTempFill:temp];
    [_tempImageView setImage:[UIImage imageWithCGImage:image.CGImage
                                                 scale:image.scale
                                           orientation:UIImageOrientationDownMirrored]];
    CATransition *transition = [CATransition animation];
    transition.duration = .3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    
    [_tempImageView.layer addAnimation:transition forKey:nil];

    _valueLabel.text = [NSString stringWithFormat:@"%iF", temp];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"temp_setting"]) {
        temp = (temp - 32.0f) * (5.0f/9.0f);
        _valueLabel.text = [NSString stringWithFormat:@"%iC", temp];
    }

}

@end
