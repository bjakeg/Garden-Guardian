#import "AboutPageViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"

@interface AboutPageViewController ()

@end

@implementation AboutPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitle:@"About"];
    
    [self setupLeftMenuButton];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.origin.x + 10, self.view.frame.origin.y + 70, self.view.frame.size.width - 15, self.view.frame.size.height - 100)];
    label.text = @"Garden Guardian is a project designed by Texas Tech students to promote water conservation in home gardens.";
    label.numberOfLines = 0;
    [label sizeToFit];
    [self.view addSubview:label];
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
