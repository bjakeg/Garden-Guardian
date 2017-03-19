#import "GuidesViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"

@interface GuidesViewController ()

@end

@implementation GuidesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitle:@"Guides"];
    
    [self setupLeftMenuButton];
}

-(void)setupLeftMenuButton{
    MMDrawerBarButtonItem * leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}

-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

@end
