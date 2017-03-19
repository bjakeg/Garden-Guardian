#import "CenterViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"

@interface CenterViewController ()

@end

@implementation CenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitle:@"Home"];
    [self setupLeftMenuButton];
    
    UIColor * barColor = [UIColor
                          colorWithRed:247.0/255.0
                          green:249.0/255.0
                          blue:250.0/255.0
                          alpha:1.0];
    [self.navigationController.navigationBar setBarTintColor:barColor];

}

-(void)setupLeftMenuButton{
    MMDrawerBarButtonItem * leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}

-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

@end
