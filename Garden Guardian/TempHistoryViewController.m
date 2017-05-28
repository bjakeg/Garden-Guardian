//
//  TempHistoryViewController.m
//  GardenGuardian
//
//  Created by Jake Graham on 3/15/17.
//  Copyright © 2017 BACKENDLESS.COM. All rights reserved.
//


//_yAxisLabel = [[UILabel alloc] init];
//_yAxisLabel.text = @"Temperature (F)";
//if ([[NSUserDefaults standardUserDefaults] boolForKey:@"temp_setting"]) {
//    _yAxisLabel.text = @"Temperature (C)";
//}
//_yAxisLabel.font = [UIFont boldSystemFontOfSize:10];
//[_yAxisLabel sizeToFit];
//frame = _yAxisLabel.frame;
//frame = CGRectMake(-20,
//                   _scatterChart.frame.origin.y + _scatterChart.frame.size.height/2,
//                   frame.size.width,
//                   frame.size.height);
//_yAxisLabel.frame = frame;
//_yAxisLabel.transform = CGAffineTransformMakeRotation(-M_PI_2);
//[self.view addSubview:_yAxisLabel];

#import "TempHistoryViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import "PNChart.h"
#import "DBManager.h"
#import "GGDataPoint.h"

@interface TempHistoryViewController () <PNChartDelegate>

@end

@implementation TempHistoryViewController {
    PNScatterChart *_scatterChart;
    UILabel *_titleLabel;
    UILabel *_xAxisLabel;
    UILabel *_yAxisLabel;
    UISegmentedControl *_timeControl;
    CGFloat _minX;
    CGFloat _maxX;
    UIView *_selectionView;
    UITextView *_zoomLabel;
    UIImageView *_magGlass;
    UIView *_magGlassRing;
    CGFloat _selectedValue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitle:@"Temperature"];
    
    [self setupLeftMenuButton];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont boldSystemFontOfSize:20];
    _titleLabel.text = @"Temperature";
    [_titleLabel sizeToFit];
    CGRect frame = _titleLabel.frame;
    frame = CGRectMake(self.view.frame.size.width/2 - frame.size.width/2, 100, frame.size.width, frame.size.height);
    _titleLabel.frame = frame;
    [self.view addSubview:_titleLabel];
    
    [self addGraph];
    
    _yAxisLabel = [[UILabel alloc] init];
    _yAxisLabel.text = @"Temperature (F)";
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"temp_setting"]) {
        _yAxisLabel.text = @"Temperature (C)";
    }
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
        [YAr addObject:[NSString stringWithFormat:LabelFormat, 60 + (float)(arc4random()%30)]];
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
    NSTimeInterval currentTimeInterval = [currentDate timeIntervalSinceReferenceDate];
    NSLog(@"Current TI:%f", currentTimeInterval);
    
    NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit units = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitWeekday;    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:-1];
    
    NSDate *yesterday = [calendar dateByAddingComponents:components toDate:currentDate options:0];
    NSTimeInterval yeserdayTimeInterval = [yesterday timeIntervalSinceReferenceDate];
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
    NSTimeInterval currentTimeInterval = [currentDate timeIntervalSinceReferenceDate];
    NSLog(@"Current TI:%f", currentTimeInterval);
    
    NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit units = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitWeekday;
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setHour:-7*24];
    
    NSDate *lastWeek = [calendar dateByAddingComponents:components toDate:currentDate options:0];
    NSTimeInterval lastWeekTimeInterval = [lastWeek timeIntervalSinceReferenceDate];
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
    NSTimeInterval currentTimeInterval = [currentDate timeIntervalSinceReferenceDate];
    NSLog(@"Current TI:%f", currentTimeInterval);
    
    NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit units = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitWeekday;
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setHour:-30*24];
    
    NSDate *lastWeek = [calendar dateByAddingComponents:components toDate:currentDate options:0];
    NSTimeInterval lastWeekTimeInterval = [lastWeek timeIntervalSinceReferenceDate];
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
    [_scatterChart setAxisYWithMinimumValue:0 andMaxValue:120 toTicks:5];
    
    [self setupXAxisLabels];
    
    NSArray *data01Array = [[DBManager getSharedInstance] findDataBetweenTime:_minX toTime:_maxX];//[self randomSetOfObjects];
    PNScatterChartData *data01 = [PNScatterChartData new];
    data01.strokeColor = PNRed;
    data01.fillColor = PNRed;
    data01.size = 3;
    data01.itemCount = [data01Array count];
    data01.inflexionPointStyle = PNScatterChartPointStyleCircle;
    //    __block NSMutableArray *XAr1 = [NSMutableArray arrayWithArray:data01Array[0]];
    //    __block NSMutableArray *YAr1 = [NSMutableArray arrayWithArray:data01Array[1]];
    
    data01.getData = ^(NSUInteger index) {
        //        NSString *xString = [XAr1 objectAtIndex:index];
        //        NSString *yString = [YAr1 objectAtIndex:index];
        //        CGFloat xValue = [xString integerValue];
        //        CGFloat yValue = [yString integerValue];
        //        return [PNScatterChartDataItem dataItemWithX:xValue AndWithY:yValue];
        GGDataPoint *currentPoint = [data01Array objectAtIndex:index];
        CGFloat xValue = (float)currentPoint.time;
        CGFloat yValue = (float)currentPoint.tempVal;
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"temp_setting"]) {
            yValue = (yValue - 32.f)*(5.f/9.f);
        }
        return [PNScatterChartDataItem dataItemWithX:xValue AndWithY:yValue];
        
    };
    
    [_scatterChart setup];
    _scatterChart.chartData = @[data01];
    if (data01Array.count > 0) {
        GGDataPoint *currentPoint = [data01Array objectAtIndex:0];
        CGPoint previousPoint = CGPointMake((float)currentPoint.time, (float)currentPoint.tempVal);
        
        for (int i = 1; i < data01Array.count; i++) {
            currentPoint = [data01Array objectAtIndex:i];
            CGFloat xValue = (float)currentPoint.time;
            CGFloat yValue = (float)currentPoint.tempVal;
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"temp_setting"]) {
                yValue = (yValue - 32.f)*(5.f/9.f);
            }
            [_scatterChart drawLineFromPoint:previousPoint ToPoint:CGPointMake(xValue, yValue) WithLineWith:2.0f AndWithColor:PNBlack];
    //        [_scatterChart drawCurvedLineFromPoint:previousPoint
    //                                       ToPoint:CGPointMake(xValue, yValue)
    //                                 WithLineWidth:2.0f
    //                                  AndWithColor:PNBlack];
            previousPoint = CGPointMake(xValue, yValue);
        }
    }
    _scatterChart.delegate = self;
    
    [self.view addSubview:_scatterChart];
}

- (void)userClickOnValue:(CGPoint)value atPoint:(CGPoint)point touchPoint:(CGPoint)touchPoint {
    //disable pan to open while looking at points
    self.mm_drawerController.allowPanGesture = NO;
    _selectedValue = value.y;
    
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
    _selectionView.alpha = 0.5f;
    [self.view addSubview:_selectionView];
    
    [_zoomLabel removeFromSuperview];
    _zoomLabel = nil;
    
    
    [_magGlass removeFromSuperview];
    _magGlass = nil;
    
    UIGraphicsBeginImageContext(self.view.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, self.view.frame.size.width/2, self.view.frame.size.height/2 );
    CGContextScaleCTM(context, 2.0f, 2.0f);
    CGContextTranslateCTM(context,
                          -(_scatterChart.frame.origin.x + touchPoint.x),
                          -(_scatterChart.frame.origin.y + touchPoint.y));
    [self.view.layer renderInContext:context];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGRect area = CGRectMake(viewImage.size.width/2 - 40, viewImage.size.height/2 - 40, 80, 80);
    CGImageRef imageRef = CGImageCreateWithImageInRect([viewImage CGImage], area);
    UIImage *img = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    _magGlass = [[UIImageView alloc] initWithFrame:CGRectMake(_scatterChart.frame.origin.x + touchPoint.x - 40, _scatterChart.frame.origin.y + touchPoint.y - 120, 80, 80)];
    _magGlass.clipsToBounds = YES;
    _magGlass.layer.cornerRadius = _magGlass.frame.size.height / 2.0f;
    _magGlass.layer.shadowOffset = CGSizeZero;
    _magGlass.layer.shadowRadius = 6.0f;
    _magGlass.layer.shadowOpacity = 0.75;
    [_magGlass setImage:img];
    
    [_magGlassRing removeFromSuperview];
    _magGlassRing = nil;
    _magGlassRing = [[UIView alloc] initWithFrame:CGRectMake(_magGlass.frame.origin.x - 2,
                                                             _magGlass.frame.origin.y - 2,
                                                             _magGlass.frame.size.height + 4,
                                                             _magGlass.frame.size.width + 4)];
    _magGlassRing.clipsToBounds = YES;
    _magGlassRing.layer.cornerRadius = _magGlassRing.frame.size.height / 2.0;
    _magGlassRing.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_magGlassRing];
    [self.view addSubview:_magGlass];
}

- (void)userClickEnded {
    self.mm_drawerController.allowPanGesture = YES;
    
    [_magGlass removeFromSuperview];
    _magGlass = nil;
    [_magGlassRing removeFromSuperview];
    _magGlassRing = nil;
    
    _zoomLabel = [[UITextView alloc] init];
    _zoomLabel.text = [NSString stringWithFormat:@"%1.1f", _selectedValue];
    _zoomLabel.font = [UIFont boldSystemFontOfSize:20];
    _zoomLabel.textColor = [UIColor whiteColor];
    _zoomLabel.textContainerInset = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
    [_zoomLabel sizeToFit];
    _zoomLabel.backgroundColor = [UIColor purpleColor];
    _zoomLabel.layer.cornerRadius = 3.0f;
    _zoomLabel.clipsToBounds = YES;
    CGRect frame = _zoomLabel.frame;
    frame = CGRectMake(_selectionView.frame.origin.x - frame.size.width/2 + _selectionView.frame.size.width / 4,
                       _selectionView.frame.origin.y - 75,
                       frame.size.width,
                       frame.size.height);
    _zoomLabel.frame = frame;
    [self.view addSubview:_zoomLabel];
}

@end
