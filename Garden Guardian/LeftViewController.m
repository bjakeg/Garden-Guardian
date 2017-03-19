//
//  LeftViewController.m
//  TreesData
//
//  Created by Jake Graham on 1/17/17.
//  Copyright © 2017 BACKENDLESS.COM. All rights reserved.
//

#import "LeftViewController.h"
#import "CenterViewController.h"
#import "HistoryViewController.h"
#import "MMNavigationController.h"
#import "UIViewController+MMDrawerController.h"
#import "GuidesViewController.h"
#import "AboutPageViewController.h"
#import "DeviceViewController.h"
#import "PurchasesViewController.h"
#import "SettingsViewController.h"

@interface LeftViewController ()

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self setTitle:@"Menu"];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    CGRect frame = self.tableView.frame;
    frame.origin.y = self.navigationController.navigationBar.frame.size.height + 20.f;
    self.tableView.frame = frame;
    
    [self.view addSubview:self.tableView];
    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    
    UIColor * tableViewBackgroundColor;
    tableViewBackgroundColor = [UIColor whiteColor];

    self.tableView.backgroundColor = tableViewBackgroundColor;
    
    self.tableView.separatorStyle = UITableViewCellEditingStyleNone;
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    
    switch (indexPath.row) {
        case MenuItemHome:
            cell.textLabel.text = @"Home";
            [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            break;
        case MenuItemHistory:
            cell.textLabel.text = @"History";
            break;
        case MenuItemGuides:
            cell.textLabel.text = @"Guides";
            break;
        case MenuItemPurchases:
            cell.textLabel.text = @"Purchases";
            break;
        case MenuItemDevice:
            cell.textLabel.text = @"Device";
            break;
        case MenuItemSettings:
            cell.textLabel.text = @"Settings";
            break;
        case MenuItemAbout:
            cell.textLabel.text = @"About";
            break;
        default:
            break;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case MenuItemHome: {
            CenterViewController *center = [[CenterViewController alloc] init];
            UINavigationController *nav = [[MMNavigationController alloc] initWithRootViewController:center];
            [self.mm_drawerController setCenterViewController:nav
                                           withCloseAnimation:YES
                                                   completion:nil];
            break;
        }
        case MenuItemHistory: {
            HistoryViewController *historyPage = [[HistoryViewController alloc] init];
            UINavigationController *nav = [[MMNavigationController alloc] initWithRootViewController:historyPage];
            [self.mm_drawerController setCenterViewController:nav
                                           withCloseAnimation:YES
                                                   completion:nil];
            
            break;
        }
        case MenuItemGuides: {
            GuidesViewController *guidesPage = [[GuidesViewController alloc] init];
            UINavigationController *nav = [[MMNavigationController alloc] initWithRootViewController:guidesPage];
            [self.mm_drawerController setCenterViewController:nav
                                           withCloseAnimation:YES
                                                   completion:nil];
            break;
        }
        case MenuItemPurchases: {
            PurchasesViewController *purchasesPage = [[PurchasesViewController alloc] init];
            UINavigationController *nav = [[MMNavigationController alloc] initWithRootViewController:purchasesPage];
            [self.mm_drawerController setCenterViewController:nav
                                           withCloseAnimation:YES
                                                   completion:nil];
            break;
        }
        case MenuItemDevice: {
            DeviceViewController *devicePage = [[DeviceViewController alloc] init];
            UINavigationController *nav = [[MMNavigationController alloc] initWithRootViewController:devicePage];
            [self.mm_drawerController setCenterViewController:nav
                                           withCloseAnimation:YES
                                                   completion:nil];
            break;
        }
        case MenuItemSettings: {
            SettingsViewController *settingsPage = [[SettingsViewController alloc] init];
            UINavigationController *nav = [[MMNavigationController alloc] initWithRootViewController:settingsPage];
            [self.mm_drawerController setCenterViewController:nav
                                           withCloseAnimation:YES
                                                   completion:nil];
            break;
        }
        case MenuItemAbout: {
            AboutPageViewController *about = [[AboutPageViewController alloc] init];
            UINavigationController *nav = [[MMNavigationController alloc] initWithRootViewController:about];
            [self.mm_drawerController setCenterViewController:nav
                                           withCloseAnimation:YES
                                                   completion:nil];
            break;
        }
        default:
            break;
    }
}

@end
