//
//  RoseViewController.m
//  Garden Guardian
//
//  Created by Jake Graham on 3/30/17.
//  Copyright © 2017 Jake Graham. All rights reserved.
//

#import "RoseViewController.h"
#import "GuidesViewController.h"

@interface RoseViewController ()

@end

@implementation RoseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitle:@"Roses"];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 200/2, 70, 200, 200)];
    [imageView setImage:[UIImage imageNamed:@"Rose.jpg"]];
    [self.view addSubview:imageView];
    
    UILabel *plantingLabel = [[UILabel alloc] init];
    plantingLabel.text = @"Planting";
    plantingLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    [plantingLabel sizeToFit];
    CGRect frame = plantingLabel.frame;
    frame = CGRectMake(20.f, 305.f, frame.size.width, frame.size.height);
    plantingLabel.frame = frame;
    [self.view addSubview:plantingLabel];
    
    UILabel *plantingInfo = [[UILabel alloc] init];
    plantingInfo.text = @"8 inches deep, 36 inch apart\nSoil > 65F";
    plantingInfo.numberOfLines = 2;
    [plantingInfo sizeToFit];
    frame = plantingInfo.frame;
    frame = CGRectMake(23.f, plantingLabel.frame.origin.y + plantingLabel.frame.size.height + 1.f, frame.size.width, frame.size.height);
    plantingInfo.frame = frame;
    [self.view addSubview:plantingInfo];
    
    UILabel *growingLabel = [[UILabel alloc] init];
    growingLabel.text = @"Growing";
    growingLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    [growingLabel sizeToFit];
    frame = growingLabel.frame;
    frame = CGRectMake(20.f, plantingInfo.frame.origin.y + plantingInfo.frame.size.height + 20.f, frame.size.width, frame.size.height);
    growingLabel.frame = frame;
    [self.view addSubview:growingLabel];
    
    UILabel *growingInfo = [[UILabel alloc] init];
    growingInfo.text = @"> 65F\n70% - 90% Sunlight\n50%-60% Moisture\n6 - 7 pH";
    growingInfo.numberOfLines = 4;
    [growingInfo sizeToFit];
    frame = growingInfo.frame;
    frame = CGRectMake(23.f, growingLabel.frame.origin.y + growingLabel.frame.size.height + 1.f, frame.size.width, frame.size.height);
    growingInfo.frame = frame;
    [self.view addSubview:growingInfo];
    
    UILabel *harvestingLabel = [[UILabel alloc] init];
    harvestingLabel.text = @"Harvesting";
    harvestingLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    [harvestingLabel sizeToFit];
    frame = harvestingLabel.frame;
    frame = CGRectMake(20.f, growingInfo.frame.origin.y + growingInfo.frame.size.height + 20.f, frame.size.width, frame.size.height);
    harvestingLabel.frame = frame;
    [self.view addSubview:harvestingLabel];
    
    UILabel *harvestingInfo = [[UILabel alloc] init];
    harvestingInfo.text = @"Prune to size of bush\nHarvest flowers 2 weeks after bulb stage";
    harvestingInfo.numberOfLines = 2;
    [harvestingInfo sizeToFit];
    frame = harvestingInfo.frame;
    frame = CGRectMake(23.f, harvestingLabel.frame.origin.y + harvestingLabel.frame.size.height + 1.f, frame.size.width, frame.size.height);
    harvestingInfo.frame = frame;
    [self.view addSubview:harvestingInfo];

    bool selected = NO;
    NSArray *favorites = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"Favorites"]];
    for (NSNumber *num in favorites) {
        if ([num integerValue] == FlowerItemRose) {
            selected = YES;
        }
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [[UIImage imageNamed:@"ic_favorite"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [button setImage:image forState:UIControlStateNormal];
    if (selected) {
        [button setTintColor:[UIColor blueColor]];
    } else {
        [button setTintColor:[UIColor grayColor]];
    }
    [button sizeToFit];
    [button addTarget:self action:@selector(heartClicked)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButton;
}

- (void) heartClicked {
    bool selected = NO;
    NSNumber *saved;
    NSMutableArray *favorites = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"Favorites"]];
    for (NSNumber *num in favorites) {
        if ([num integerValue] == FlowerItemRose) {
            saved = num;
            selected = YES;
        }
    }
    if (!selected) {
        [favorites addObject:[NSNumber numberWithInt:FlowerItemRose]];
        self.navigationItem.rightBarButtonItem = nil;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [[UIImage imageNamed:@"ic_favorite"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [button setImage:image forState:UIControlStateNormal];
        [button setTintColor:[UIColor blueColor]];
        [button sizeToFit];
        [button addTarget:self action:@selector(heartClicked)forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.rightBarButtonItem = barButton;
    } else {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [favorites removeObject:saved];
        UIImage *image = [[UIImage imageNamed:@"ic_favorite"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [button setImage:image forState:UIControlStateNormal];
        [button setTintColor:[UIColor grayColor]];
        [button sizeToFit];
        [button addTarget:self action:@selector(heartClicked)forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.rightBarButtonItem = barButton;
    }
    [[NSUserDefaults standardUserDefaults] setObject:favorites forKey:@"Favorites"];
}


@end
