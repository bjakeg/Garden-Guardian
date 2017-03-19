//
//  WaterHistoryViewController.m
//  GardenGuardian
//
//  Created by Jake Graham on 3/15/17.
//  Copyright © 2017 BACKENDLESS.COM. All rights reserved.
//

#import "WaterHistoryViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import "PNChart.h"

@interface WaterHistoryViewController () <PNChartDelegate>

@end

@implementation WaterHistoryViewController {
    PNScatterChart *_scatterChart;
    UILabel *_titleLabel;
    UILabel *_xAxisLabel;
    UILabel *_yAxisLabel;
    UISegmentedControl *_timeControl;
    CGFloat _minX;
    CGFloat _maxX;
    UIView *_selectionView;
    UITextView *_zoomLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitle:@"Moisture"];
    
    [self setupLeftMenuButton];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont boldSystemFontOfSize:20];
    _titleLabel.text = @"Moisture";
    [_titleLabel sizeToFit];
    CGRect frame = _titleLabel.frame;
    frame = CGRectMake(self.view.frame.size.width/2 - frame.size.width/2, 100, frame.size.width, frame.size.height);
    _titleLabel.frame = frame;
    [self.view addSubview:_titleLabel];
    
    [self addGraph];
    
    _yAxisLabel = [[UILabel alloc] init];
    _yAxisLabel.text = @"Percentage (%)";
    _yAxisLabel.font = [UIFont boldSystemFontOfSize:10];
    [_yAxisLabel sizeToFit];
    frame = _yAxisLabel.frame;
    frame = CGRectMake(-20,
                       _scatterChart.frame.origin.y + _scatterChart.frame.size.height/2,
                       frame.size.width,
                       frame.size.height);
    _yAxisLabel.frame = frame;
    _yAxisLabel.transform = CGAffineTransformMakeRotation(-M_PI_2);
    [self.view addSubview:_yAxisLabel];
    
    NSArray *itemArray = [NSArray arrayWithObjects: @"24 Hours", @"1 Week", @"30 Days", nil];
    _timeControl = [[UISegmentedControl alloc] initWithItems:itemArray];
    [_timeControl sizeToFit];
    frame = _timeControl.frame;
    frame = CGRectMake(self.view.frame.size.width/2 - frame.size.width/2, 350, frame.size.width, frame.size.height);
    _timeControl.frame = frame;
    [_timeControl addTarget:self action:@selector(timeControlUpdated) forControlEvents: UIControlEventValueChanged];
    _timeControl.selectedSegmentIndex = 0;
    [self.view addSubview:_timeControl];
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

/* this function is used only for creating random points */
- (NSArray *)randomSetOfObjects {
    NSMutableArray *array = [NSMutableArray array];
    NSString *LabelFormat = @"%1.f";
    NSMutableArray *XAr = [NSMutableArray array];
    NSMutableArray *YAr = [NSMutableArray array];
    for (int i = 0; i < 50; i++) {
        [XAr addObject:[NSString stringWithFormat:LabelFormat, _minX + i*(_maxX - _minX)/52 + 1]];
        [YAr addObject:[NSString stringWithFormat:LabelFormat, 80 + (float)(arc4random()%10)]];
    }
    [array addObject:XAr];
    [array addObject:YAr];
    return array;
}

- (void)setupXAxisLabels {
    if (_timeControl) {
        switch (_timeControl.selectedSegmentIndex) {
            case 0:
                NSLog(@"0");
                [self setup24HourLabels];
                break;
            case 1:
                NSLog(@"1");
                [self setupWeekLabels];
                break;
            case 2:
                NSLog(@"2");
                [self setupMonthLabel];
                break;
            default:
                break;
        }
        
    } else {
        [self setup24HourLabels];
    }
}

- (void)setup24HourLabels {
    NSDate *currentDate = [NSDate date];
    NSTimeInterval currentTimeInterval = [currentDate timeIntervalSince1970];
    NSLog(@"Current TI:%f", currentTimeInterval);
    
    NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSGregorianCalendar];
    NSCalendarUnit units = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit;
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:-1];
    
    NSDate *yesterday = [calendar dateByAddingComponents:components toDate:currentDate options:0];
    NSTimeInterval yeserdayTimeInterval = [yesterday timeIntervalSince1970];
    NSLog(@"Yesterday TI:%f", yeserdayTimeInterval);
    
    _minX = yeserdayTimeInterval;
    _maxX = currentTimeInterval;
    
    [_scatterChart setAxisXWithMinimumValue:_minX andMaxValue:_maxX toTicks:9];
    
    NSMutableArray *xAxisLabels = [NSMutableArray array];
    for (int i = 0; i <= 8; i++) {
        components = nil;
        components = [[NSDateComponents alloc] init];
        [components setHour:i*3 - 24];
        NSDate *lastHour = [calendar dateByAddingComponents:components toDate:currentDate options:0];
        
        components = [calendar components:units fromDate:lastHour];
        [xAxisLabels addObject:[NSString stringWithFormat:@"%ld:%ld", [components hour], [components minute]]];
    }
    [_scatterChart setAxisXLabel:xAxisLabels];
    
}

- (void)setupWeekLabels {
    NSDate *currentDate = [NSDate date];
    NSTimeInterval currentTimeInterval = [currentDate timeIntervalSince1970];
    NSLog(@"Current TI:%f", currentTimeInterval);
    
    NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSGregorianCalendar];
    NSCalendarUnit units = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSWeekdayCalendarUnit;
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setHour:-7*24];
    
    NSDate *lastWeek = [calendar dateByAddingComponents:components toDate:currentDate options:0];
    NSTimeInterval lastWeekTimeInterval = [lastWeek timeIntervalSince1970];
    NSLog(@"Last Week TI:%f", lastWeekTimeInterval);
    
    _minX = lastWeekTimeInterval;
    _maxX = currentTimeInterval;
    
    [_scatterChart setAxisXWithMinimumValue:_minX andMaxValue:_maxX toTicks:8];
    
    NSMutableArray *xAxisLabels = [NSMutableArray array];
    for (int i = 0; i < 8; i++) {
        components = nil;
        components = [[NSDateComponents alloc] init];
        [components setHour:i*24 - 7*24];
        NSDate *day = [calendar dateByAddingComponents:components toDate:currentDate options:0];
        
        components = [calendar components:units fromDate:day];
        [xAxisLabels addObject:[NSString stringWithFormat:@"%@", [self stringFromWeekday:[components weekday]]]];
    }
    [_scatterChart setAxisXLabel:xAxisLabels];
}

- (void)setupMonthLabel {
    NSDate *currentDate = [NSDate date];
    NSTimeInterval currentTimeInterval = [currentDate timeIntervalSince1970];
    NSLog(@"Current TI:%f", currentTimeInterval);
    
    NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSGregorianCalendar];
    NSCalendarUnit units = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSWeekdayCalendarUnit;
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setHour:-30*24];
    
    NSDate *lastWeek = [calendar dateByAddingComponents:components toDate:currentDate options:0];
    NSTimeInterval lastWeekTimeInterval = [lastWeek timeIntervalSince1970];
    NSLog(@"Last Week TI:%f", lastWeekTimeInterval);
    
    _minX = lastWeekTimeInterval;
    _maxX = currentTimeInterval;
    
    [_scatterChart setAxisXWithMinimumValue:_minX andMaxValue:_maxX toTicks:11];
    
    NSMutableArray *xAxisLabels = [NSMutableArray array];
    for (int i = 0; i < 11; i++) {
        components = nil;
        components = [[NSDateComponents alloc] init];
        [components setHour:i*3*24 - 20*24];
        NSDate *day = [calendar dateByAddingComponents:components toDate:currentDate options:0];
        
        components = [calendar components:units fromDate:day];
        [xAxisLabels addObject:[NSString stringWithFormat:@"%ld/%ld", [components month], [components day]]];
    }
    [_scatterChart setAxisXLabel:xAxisLabels];
    
}

- (NSString *)stringFromWeekday:(NSInteger)weekday {
    switch (weekday) {
        case 1:
            return @"Sun";
            break;
        case 2:
            return @"Mon";
            break;
        case 3:
            return @"Tue";
            break;
        case 4:
            return @"Wed";
            break;
        case 5:
            return @"Thu";
            break;
        case 6:
            return @"Fri";
            break;
        case 7:
            return @"Sat";
            break;
        default:
            break;
    }
    return @"";
}

- (void)timeControlUpdated {
    [_selectionView removeFromSuperview];
    _selectionView = nil;
    [_zoomLabel removeFromSuperview];
    _zoomLabel = nil;
    
    [_scatterChart removeFromSuperview];
    _scatterChart = nil;
    [self addGraph];
}

- (void)addGraph {
    _scatterChart = [[PNScatterChart alloc] initWithFrame:CGRectMake(30, 135.0, SCREEN_WIDTH - 30, 200.0)];
    
    _scatterChart.delegate = self;

    
    _scatterChart.showYGridLines = YES;
    _scatterChart.yLabelFormat = @"%1.1f";
    [_scatterChart setAxisYWithMinimumValue:0 andMaxValue:100 toTicks:5];
    
    [self setupXAxisLabels];
    
    NSArray *data01Array = [self randomSetOfObjects];
    PNScatterChartData *data01 = [PNScatterChartData new];
    data01.strokeColor = PNBlue;
    data01.fillColor = PNBlue;
    data01.size = 3;
    data01.itemCount = [data01Array[0] count];
    data01.inflexionPointStyle = PNScatterChartPointStyleCircle;
    __block NSMutableArray *XAr1 = [NSMutableArray arrayWithArray:data01Array[0]];
    __block NSMutableArray *YAr1 = [NSMutableArray arrayWithArray:data01Array[1]];
    
    data01.getData = ^(NSUInteger index) {
        NSString *xString = [XAr1 objectAtIndex:index];
        NSString *yString = [YAr1 objectAtIndex:index];
        CGFloat xValue = [xString integerValue];
        CGFloat yValue = [yString integerValue];
        return [PNScatterChartDataItem dataItemWithX:xValue AndWithY:yValue];
    };
    
    [_scatterChart setup];
    _scatterChart.chartData = @[data01];
    
    CGPoint previousPoint = CGPointMake([XAr1[0] floatValue], [YAr1[0] floatValue]);
    
    for (int i = 1; i < XAr1.count; i++) {
        CGFloat xValue = [XAr1[i] floatValue];
        CGFloat yValue = [YAr1[i] floatValue];
        [_scatterChart drawCurvedLineFromPoint:previousPoint
                                       ToPoint:CGPointMake(xValue, yValue)
                                 WithLineWidth:2.0f
                                  AndWithColor:PNBlack];
        previousPoint = CGPointMake(xValue, yValue);
    }
    
    _scatterChart.delegate = self;
    
    [self.view addSubview:_scatterChart];
}

- (void)userClickOnValue:(CGPoint)value atPoint:(CGPoint)point {
    //disable pan to open while looking at points
    self.mm_drawerController.allowPanGesture = NO;
    
    
    [_selectionView removeFromSuperview];
    _selectionView = nil;
    CGFloat radius = 6.0f;
    CGRect frame = CGRectMake(_scatterChart.frame.origin.x + point.x - radius,
                              _scatterChart.frame.origin.y + point.y - radius,
                              2 * radius,
                              2 * radius);
    _selectionView = [[UIView alloc] initWithFrame:frame];
    _selectionView.userInteractionEnabled = NO;
    _selectionView.layer.cornerRadius = radius;
    _selectionView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:_selectionView];
    
    [_zoomLabel removeFromSuperview];
    _zoomLabel = nil;
    _zoomLabel = [[UITextView alloc] init];
    _zoomLabel.text = [NSString stringWithFormat:@"%1.1f", value.y];
    _zoomLabel.font = [UIFont boldSystemFontOfSize:20];
    _zoomLabel.textColor = [UIColor whiteColor];
    _zoomLabel.textContainerInset = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
    [_zoomLabel sizeToFit];
    _zoomLabel.backgroundColor = [UIColor purpleColor];
    _zoomLabel.layer.cornerRadius = 3.0f;
    _zoomLabel.clipsToBounds = YES;
    frame = _zoomLabel.frame;
    frame = CGRectMake(_scatterChart.frame.origin.x + point.x - frame.size.width/2,
                       _scatterChart.frame.origin.y + point.y - 75,
                       frame.size.width,
                       frame.size.height);
    _zoomLabel.frame = frame;
    [self.view addSubview:_zoomLabel];
}

- (void)userClickEnded {
    self.mm_drawerController.allowPanGesture = YES;
}


@end
