//
//  HistoryViewController.m
//  GardenGuardian
//
//  Created by Jake Graham on 3/7/17.
//  Copyright © 2017 BACKENDLESS.COM. All rights reserved.
//

#import "HistoryViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import "SunHistoryViewController.h"
#import "WaterHistoryViewController.h"
#import "TempHistoryViewController.h"
#import "PHHistoryViewController.h"

@interface HistoryViewController ()

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitle:@"History"];
    
    [self setupLeftMenuButton];
    
    SunHistoryViewController *shvc = [[SunHistoryViewController alloc] init];
    [shvc.tabBarItem setTitle:@"Sunlight"];
    [shvc.tabBarItem setImage:[UIImage imageNamed:@"sunTabIcon"]];
    [self addChildViewController: shvc];
    
    WaterHistoryViewController *whvc = [[WaterHistoryViewController alloc] init];
    [whvc.tabBarItem setTitle:@"Moisture"];
    [whvc.tabBarItem setImage:[UIImage imageNamed:@"moistureTabIcon"]];
    [self addChildViewController:whvc];
    
    TempHistoryViewController *thvc = [[TempHistoryViewController alloc] init];
    [thvc.tabBarItem setTitle:@"Temperature"];
    [thvc.tabBarItem setImage:[UIImage imageNamed:@"tempTabIcon"]];
    [self addChildViewController:thvc];
    
    PHHistoryViewController *phhvc = [[PHHistoryViewController alloc] init];
    [phhvc.tabBarItem setTitle:@"pH"];
    [phhvc.tabBarItem setImage:[UIImage imageNamed:@"pHTabIcon"]];
    [self addChildViewController:phhvc];
    
}

-(void)setupLeftMenuButton{
    MMDrawerBarButtonItem * leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}

-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}


@end
