//
//  MoistureView.m
//  Garden Guardian
//
//  Created by Jake Graham on 3/30/17.
//  Copyright © 2017 Jake Graham. All rights reserved.
//

#import "MoistureView.h"
#import "GardenGuardianKit.h"

@implementation MoistureView {
    UIImageView *_moistureImageView;
    UILabel *_titleLabel;
    UILabel *_valueLabel;
}

- (id) initWithFrame:(CGRect)frame moisture:(int)moisture {
    self = [super initWithFrame:frame];
    if (self) {
        _moisture = moisture;
        
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
        
        _moistureImageView = [[UIImageView alloc] initWithFrame:CGRectMake(47.5f, 15, 100, 100)];
        UIImage *image = [GardenGuardianKit imageOfRaindropWithWaterFill:moisture];
        [_moistureImageView setImage:[UIImage imageWithCGImage:image.CGImage
                                                         scale:image.scale
                                                   orientation:UIImageOrientationDownMirrored]];
        [self addSubview:_moistureImageView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"Moisture:";
        [_titleLabel sizeToFit];
        CGRect titleFrame = _titleLabel.frame;
        titleFrame = CGRectMake((frame.size.width-180) + (frame.size.width-180)/2 - titleFrame.size.width/2,
                                45,
                                titleFrame.size.width,
                                titleFrame.size.height);
        _titleLabel.frame = titleFrame;
        [self addSubview:_titleLabel];
        
        _valueLabel = [[UILabel alloc] init];
        _valueLabel.text = [NSString stringWithFormat:@"%i%%", moisture];
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

- (void)setMoisture:(int)moisture {
    _moisture = moisture;
    UIImage *image = [GardenGuardianKit imageOfRaindropWithWaterFill:moisture];
    [_moistureImageView setImage:[UIImage imageWithCGImage:image.CGImage
                                                     scale:image.scale
                                               orientation:UIImageOrientationDownMirrored]];
    CATransition *transition = [CATransition animation];
    transition.duration = .3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    
    [_moistureImageView.layer addAnimation:transition forKey:nil];

    _valueLabel.text = [NSString stringWithFormat:@"%3i%%", moisture];
}

@end
