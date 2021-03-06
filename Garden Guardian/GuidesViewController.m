#import "GuidesViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import "VeggieGuidesViewController.h"
#import "FlowerGuidesViewController.h"
#import "FavoriteGuidesViewController.h"

@interface GuidesViewController () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation GuidesViewController {
    UITableView *_tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitle:@"Guides"];
    
    [self setupLeftMenuButton];
    
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

#pragma mark - Navigation

-(void)setupLeftMenuButton{
    MMDrawerBarButtonItem * leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}

-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    
    switch (indexPath.row) {
        case GuideItemFavorites:
            cell.textLabel.text = @"Favorites";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case GuideItemVeggies:
            cell.textLabel.text = @"Vegetables";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case GuideItemFlowers:
            cell.textLabel.text = @"Flowers";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
        case GuideItemFavorites: {
            FavoriteGuidesViewController *vc = [[FavoriteGuidesViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case GuideItemVeggies: {
            VeggieGuidesViewController *vc = [[VeggieGuidesViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case GuideItemFlowers: {
            FlowerGuidesViewController *vc = [[FlowerGuidesViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
