#import "CenterViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import "BTConnectionHandler.h"
#import "SunlightView.h"
#import "MoistureView.h"
#import "TempView.h"
#import "PHView.h"
#import "DBManager.h"

@interface CenterViewController () <BTConnectionHandlerDelegate>

@end

@implementation CenterViewController {
    BTConnectionHandler *_handler;
    SunlightView *_sunlightView;
    MoistureView *_moistureView;
    TempView *_tempView;
    PHView *_pHView;
}

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
    
    
    BTConnectionHandler *BTHandler = [BTConnectionHandler getSharedInstance];
    //BTHandler.delegate = self;
    _handler = BTHandler;
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(triggerAction:) name:@"NotificationMessageEvent" object:nil];

    _sunlightView = [[SunlightView alloc] initWithFrame:CGRectMake(10, 70, self.view.frame.size.width - 20, 130) sunlight:100];
    [self.view addSubview:_sunlightView];
    
    _moistureView = [[MoistureView alloc] initWithFrame:CGRectMake(10, 220, self.view.frame.size.width - 20, 130) moisture:100];
    [self.view addSubview:_moistureView];
    
    _tempView = [[TempView alloc] initWithFrame:CGRectMake(10, 370, self.view.frame.size.width - 20, 130) temp:100];
    [self.view addSubview:_tempView];
    
    _pHView = [[PHView alloc] initWithFrame:CGRectMake(10, 520, self.view.frame.size.width - 20, 130) pH:14.0];
    [self.view addSubview:_pHView];
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
//    GGDataPoint *point = [[GGDataPoint alloc] initWithTime:currentTime
//                                                    sunVal:150
//                                               moistureVal:3
//                                                   tempVal:4
//                                                     pHVal:5];
//    [[DBManager getSharedInstance] saveDataPoint:point];
    NSArray *points = [[DBManager getSharedInstance] findLast50Data];
    NSLog(@"%@", points);
}

-(void)setupLeftMenuButton{
    MMDrawerBarButtonItem * leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}

-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)newDataPoint:(GGDataPoint *)dataPoint {
    [[DBManager getSharedInstance] saveDataPoint:dataPoint];
}

- (void)newNotfiyPoint:(GGDataPoint *)dataPoint {
    _sunlightView.sunlight = dataPoint.sunVal;
    _moistureView.moisture = dataPoint.moistureVal;
    _tempView.temp = dataPoint.tempVal;
    _pHView.pH = dataPoint.pHVal;
    [self.view setNeedsDisplay];
}

#pragma mark - Notification
-(void) triggerAction:(NSNotification *) notification
{
    NSDictionary *dict = notification.userInfo;
    GGDataPoint *message = [dict valueForKey:@"message"];
    if (message != nil) {
        // do stuff here with your message data
        _sunlightView.sunlight = message.sunVal;
        _moistureView.moisture = message.moistureVal;
        _tempView.temp = message.tempVal;
        _pHView.pH = message.pHVal;
        [self.view setNeedsDisplay];
    }
}

@end
