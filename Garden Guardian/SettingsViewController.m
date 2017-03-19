//
//  SettingsViewController.m
//  GardenGuardian
//
//  Created by Jake Graham on 3/15/17.
//  Copyright © 2017 BACKENDLESS.COM. All rights reserved.
//

#import "SettingsViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitle:@"Settings"];
    
    [self setupLeftMenuButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupLeftMenuButton{
    MMDrawerBarButtonItem * leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}

-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

@end
