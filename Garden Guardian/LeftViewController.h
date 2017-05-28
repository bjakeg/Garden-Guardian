#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MenuItem){
    MenuItemHome,
    MenuItemHistory,
    MenuItemGuides,
    MenuItemPurchases,
    MenuItemSettings,
    MenuItemAbout,
};

@interface LeftViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@end
