//
//  FlowerGuidesViewController.m
//  Garden Guardian
//
//  Created by Jake Graham on 3/30/17.
//  Copyright © 2017 Jake Graham. All rights reserved.
//

#import "FlowerGuidesViewController.h"
#import "GuidesViewController.h"
#import "TulipViewController.h"
#import "RoseViewController.h"
#import "DaisyViewController.h"
#import "CarnationViewController.h"

@interface FlowerGuidesViewController () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation FlowerGuidesViewController {
    UITableView *_tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitle:@"Flowers"];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    switch (indexPath.row + 7) {
        case FlowerItemRose:
            cell.textLabel.text = @"Rose";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case FlowerItemDaisy:
            cell.textLabel.text = @"Daisy";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case FlowerItemTulip:
            cell.textLabel.text = @"Tulip";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case FlowerItemCarnation:
            cell.textLabel.text = @"Carnation";
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
    switch (indexPath.row + 7) {
        case FlowerItemRose: {
            RoseViewController *vc = [[RoseViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case FlowerItemDaisy: {
            DaisyViewController *vc = [[DaisyViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case FlowerItemTulip: {
            TulipViewController *vc = [[TulipViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case FlowerItemCarnation: {
            CarnationViewController *vc = [[CarnationViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}


@end
