//
//  VeggieGuidesViewController.m
//  Garden Guardian
//
//  Created by Jake Graham on 3/30/17.
//  Copyright © 2017 Jake Graham. All rights reserved.
//

#import "VeggieGuidesViewController.h"
#import "GuidesViewController.h"
#import "SquashViewController.h"
#import "TomatoViewController.h"
#import "ZucchiniViewController.h"
#import "CucumberViewController.h"

@interface VeggieGuidesViewController () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation VeggieGuidesViewController {
    UITableView *_tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitle:@"Vegetables"];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    CGRect frame = _tableView.frame;
    frame.origin.y =  5.f;
    _tableView.frame = frame;
    
    [self.view addSubview:_tableView];
    [_tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    
    UIColor * tableViewBackgroundColor;
    tableViewBackgroundColor = [UIColor whiteColor];
    
    _tableView.backgroundColor = tableViewBackgroundColor;
    
    _tableView.separatorStyle = UITableViewCellEditingStyleNone;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    
    switch (indexPath.row + 3) {
        case VeggieItemSquash:
            cell.textLabel.text = @"Squash";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case VeggieItemTomato:
            cell.textLabel.text = @"Tomato";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case VeggieItemZuchini:
            cell.textLabel.text = @"Zucchini";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case VeggieItemCucumber:
            cell.textLabel.text = @"Cucumber";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
    switch (indexPath.row + 3) {
        case VeggieItemSquash: {
            SquashViewController *vc = [[SquashViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case VeggieItemTomato: {
            TomatoViewController *vc = [[TomatoViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case VeggieItemZuchini: {
            ZucchiniViewController *vc = [[ZucchiniViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case VeggieItemCucumber: {
            CucumberViewController *vc = [[CucumberViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}





@end
