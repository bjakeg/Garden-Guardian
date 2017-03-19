#import "AppDelegate.h"
#import "CenterViewController.h"
#import "LeftViewController.h"
#import "MMNavigationController.h"
#import "MMDrawerController.h"

static NSString *APP_ID = @"6F23467B-028E-BB4C-FF19-A6665CF9CE00";
static NSString *SECRET_KEY = @"073AACD5-5975-4114-FF95-F983938F1600";
static NSString *VERSION_NUM = @"v1";


@interface AppDelegate ()
@property (nonatomic,strong) MMDrawerController * drawerController;
@end





@implementation AppDelegate

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions {
    
    UIViewController *leftSideDrawerViewController = [[LeftViewController alloc] init];
    UIViewController *centerDrawerViewController = [[CenterViewController alloc] init];
    UINavigationController *navigationController = [[MMNavigationController alloc]
                                                    initWithRootViewController:centerDrawerViewController];
    UINavigationController *leftSideNavController = [[MMNavigationController alloc]
                                                     initWithRootViewController:leftSideDrawerViewController];
    
    self.drawerController =
        [[MMDrawerController alloc] initWithCenterViewController:navigationController
                                        leftDrawerViewController:leftSideNavController];
    [self.drawerController setShowsShadow:YES];
    [self.drawerController setMaximumRightDrawerWidth:200.0];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    self.drawerController.allowPanGesture = YES;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UIColor * tintColor = [UIColor colorWithRed:29.0/255.0
                                          green:173.0/255.0
                                           blue:234.0/255.0
                                          alpha:1.0];
    [self.window setTintColor:tintColor];

    [self.window setRootViewController:self.drawerController];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //[DebLog setIsActive:YES];

    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
