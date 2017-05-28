//
//  PHView.m
//  Garden Guardian
//
//  Created by Jake Graham on 3/30/17.
//  Copyright © 2017 Jake Graham. All rights reserved.
//

#import "PHView.h"
#import "GardenGuardianKit.h"

@implementation PHView {
    UIImageView *_pHImageView;
    UILabel *_titleLabel;
    UILabel *_valueLabel;
}

- (id) initWithFrame:(CGRect)frame pH:(CGFloat)pH {
    self = [super initWithFrame:frame];
    if (self) {
        _pH = pH;
        
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
        
        _pHImageView = [[UIImageView alloc] initWithFrame:CGRectMake(47.5f, 5, 100, 120)];
        UIImage *image = [GardenGuardianKit imageOfPHVial];
        [_pHImageView setImage:image];
        [self addSubview:_pHImageView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"pH:";
        [_titleLabel sizeToFit];
        CGRect titleFrame = _titleLabel.frame;
        titleFrame = CGRectMake((frame.size.width-180) + (frame.size.width-180)/2 - titleFrame.size.width/2,
                                45,
                                titleFrame.size.width,
                                titleFrame.size.height);
        _titleLabel.frame = titleFrame;
        [self addSubview:_titleLabel];
        
        _valueLabel = [[UILabel alloc] init];
        _valueLabel.text = [NSString stringWithFormat:@"%.1f", _pH];
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

- (void)setPH:(CGFloat)pH {
    //pH = pH/255.f * 14.0f;    _pH = pH;
    _valueLabel.text = [NSString stringWithFormat:@"%2.1f", pH];
}

@end
