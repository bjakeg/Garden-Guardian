//
//  GardeGuardianKit.m
//  GardenGuardian
//
//  Created by Jake Graham on 3/30/17.
//  Copyright (c) 2017 CompanyName. All rights reserved.
//
//  Generated by PaintCode (www.paintcodeapp.com)
//

#import "GardenGuardianKit.h"


@implementation GardenGuardianKit

#pragma mark Cache

static UIImage* _imageOfSunTabIcon = nil;
static UIImage* _imageOfPHVial = nil;

#pragma mark Initialization

+ (void)initialize
{
}

#pragma mark Drawing Methods

+ (void)drawSunWithSunFill: (CGFloat)sunFill
{
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();

    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 1 green: 0.858 blue: 0.156 alpha: 1];

    //// Variable Declarations
    CGFloat sunFillRadius = sunFill;
    CGFloat sunFillY = 51 + (82 - sunFill) / 2.0;
    CGFloat sunFillX = 41 + (82 - sunFill) / 2.0;
    CGFloat ray3H = 29.17 + (sunFill - 82) / 82.0 * 29.17;
    CGFloat ray3Y = 44.17 - (sunFill - 82) / 82.0 * 44.17 - 1.0 / 2.0 * (29.17 - sunFill / 82.0 * 29.17);
    CGFloat ray1H = 28.71 + (sunFill - 82) / 82.0 * 28.71;
    CGFloat ray1X = 2.67 + (sunFill - 82) / 82.0 * 2.67 + 1.08 * (29.17 - sunFill / 82.0 * 29.17);
    CGFloat ray5H = 28.71 + (sunFill - 82) / 82.0 * 28.71;
    CGFloat ray2H = 28.71 + (sunFill - 82) / 82.0 * 28.71;
    CGFloat ray2X = 18.67 + (sunFill - 82) / 82.0 * 18.67 + 1.3 * (29.17 - sunFill / 82.0 * 29.17);
    CGFloat ray2Y = 41.46 - (sunFill - 82) / 82.0 * 41.46 - 0.67 * (29.17 - sunFill / 82.0 * 29.17);
    CGFloat ray4H = 28.71 + (sunFill - 82) / 82.0 * 28.71;
    CGFloat ray4X = 140.67 - (82 - sunFill) / 82.0 * 140.67 + 4.18 * (29.17 - sunFill / 82.0 * 29.17);
    CGFloat ray4Y = 37.46 - (sunFill - 82) / 82.0 * 37.46 - 0.54 * (29.17 - sunFill / 82.0 * 29.17);

    //// Oval Drawing
    CGRect ovalRect = CGRectMake(41, 51, 82, 82);
    UIBezierPath* ovalPath = [UIBezierPath bezierPath];
    [ovalPath addArcWithCenter: CGPointMake(CGRectGetMidX(ovalRect), CGRectGetMidY(ovalRect)) radius: CGRectGetWidth(ovalRect) / 2 startAngle: 180 * M_PI/180 endAngle: 0 * M_PI/180 clockwise: YES];
    [ovalPath addLineToPoint: CGPointMake(CGRectGetMidX(ovalRect), CGRectGetMidY(ovalRect))];
    [ovalPath closePath];

    [UIColor.grayColor setFill];
    [ovalPath fill];


    //// Rectangle Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 18.67, 41.46);
    CGContextRotateCTM(context, -40.85 * M_PI / 180);

    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, 5.86, 28.71) cornerRadius: 2.93];
    [UIColor.grayColor setFill];
    [rectanglePath fill];

    CGContextRestoreGState(context);


    //// Rectangle 2 Drawing
    UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(78.67, 15.46, 5.86, 28.71) cornerRadius: 2.93];
    [UIColor.grayColor setFill];
    [rectangle2Path fill];


    //// Rectangle 3 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 140.67, 37.46);
    CGContextRotateCTM(context, 40.85 * M_PI / 180);

    UIBezierPath* rectangle3Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, 5.86, 28.71) cornerRadius: 2.93];
    [UIColor.grayColor setFill];
    [rectangle3Path fill];

    CGContextRestoreGState(context);


    //// Rectangle 4 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 2.67, 89.46);
    CGContextRotateCTM(context, -90 * M_PI / 180);

    UIBezierPath* rectangle4Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, 5.86, 28.71) cornerRadius: 2.93];
    [UIColor.grayColor setFill];
    [rectangle4Path fill];

    CGContextRestoreGState(context);


    //// Rectangle 5 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 132.67, 89.46);
    CGContextRotateCTM(context, -90 * M_PI / 180);

    UIBezierPath* rectangle5Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, 5.86, 28.71) cornerRadius: 2.93];
    [UIColor.grayColor setFill];
    [rectangle5Path fill];

    CGContextRestoreGState(context);


    //// Oval 2 Drawing
    CGRect oval2Rect = CGRectMake(sunFillX, sunFillY, sunFillRadius, sunFillRadius);
    UIBezierPath* oval2Path = [UIBezierPath bezierPath];
    [oval2Path addArcWithCenter: CGPointMake(CGRectGetMidX(oval2Rect), CGRectGetMidY(oval2Rect)) radius: CGRectGetWidth(oval2Rect) / 2 startAngle: 180 * M_PI/180 endAngle: 0 * M_PI/180 clockwise: YES];
    [oval2Path addLineToPoint: CGPointMake(CGRectGetMidX(oval2Rect), CGRectGetMidY(oval2Rect))];
    [oval2Path closePath];

    [color setFill];
    [oval2Path fill];


    //// Rectangle 6 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 78.67, ray3Y);

    UIBezierPath* rectangle6Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, -29.17, 5.86, ray3H) cornerRadius: 2.93];
    [color setFill];
    [rectangle6Path fill];

    CGContextRestoreGState(context);


    //// Rectangle 7 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, ray1X, 89.46);
    CGContextRotateCTM(context, -90 * M_PI / 180);

    UIBezierPath* rectangle7Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, 5.86, (ray1H + 0.0939336492891)) cornerRadius: 2.93];
    [color setFill];
    [rectangle7Path fill];

    CGContextRestoreGState(context);


    //// Rectangle 8 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 132.67, 89.46);
    CGContextRotateCTM(context, -90 * M_PI / 180);

    UIBezierPath* rectangle8Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, 5.86, ray5H) cornerRadius: 2.93];
    [color setFill];
    [rectangle8Path fill];

    CGContextRestoreGState(context);


    //// Rectangle 9 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, ray2X, ray2Y);
    CGContextRotateCTM(context, -40.85 * M_PI / 180);

    UIBezierPath* rectangle9Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, 5.86, ray2H) cornerRadius: 2.93];
    [color setFill];
    [rectangle9Path fill];

    CGContextRestoreGState(context);


    //// Rectangle 10 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, ray4X, ray4Y);
    CGContextRotateCTM(context, 40.85 * M_PI / 180);

    UIBezierPath* rectangle10Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, 5.86, ray4H) cornerRadius: 2.93];
    [color setFill];
    [rectangle10Path fill];

    CGContextRestoreGState(context);
}

+ (void)drawSunTabIcon
{
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();

    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(7, 7, 11, 11)];
    [UIColor.grayColor setFill];
    [ovalPath fill];


    //// Rectangle 2 Drawing
    UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(12, 0, 1.33, 6) cornerRadius: 0.66];
    [UIColor.grayColor setFill];
    [rectangle2Path fill];


    //// Rectangle 4 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, -40.33, 71.46);
    CGContextRotateCTM(context, -90 * M_PI / 180);

    UIBezierPath* rectangle4Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, 5.86, 28.71) cornerRadius: 2.93];
    [UIColor.grayColor setFill];
    [rectangle4Path fill];

    CGContextRestoreGState(context);


    //// Rectangle Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 19, 12.75);
    CGContextRotateCTM(context, -90 * M_PI / 180);

    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, 1.33, 6) cornerRadius: 0.66];
    [UIColor.grayColor setFill];
    [rectanglePath fill];

    CGContextRestoreGState(context);


    //// Rectangle 3 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 0, 12.75);
    CGContextRotateCTM(context, -90 * M_PI / 180);

    UIBezierPath* rectangle3Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, 1.33, 6) cornerRadius: 0.66];
    [UIColor.grayColor setFill];
    [rectangle3Path fill];

    CGContextRestoreGState(context);


    //// Rectangle 5 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 2.67, 4);
    CGContextRotateCTM(context, -45 * M_PI / 180);

    UIBezierPath* rectangle5Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, 1.33, 6) cornerRadius: 0.66];
    [UIColor.grayColor setFill];
    [rectangle5Path fill];

    CGContextRestoreGState(context);


    //// Rectangle 6 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 21.67, 3);
    CGContextRotateCTM(context, 45 * M_PI / 180);

    UIBezierPath* rectangle6Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, 1.33, 6) cornerRadius: 0.66];
    [UIColor.grayColor setFill];
    [rectangle6Path fill];

    CGContextRestoreGState(context);


    //// Rectangle 7 Drawing
    UIBezierPath* rectangle7Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(12, 19, 1.33, 6) cornerRadius: 0.66];
    [UIColor.grayColor setFill];
    [rectangle7Path fill];


    //// Rectangle 8 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 6.67, 17);
    CGContextRotateCTM(context, 45 * M_PI / 180);

    UIBezierPath* rectangle8Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, 1.33, 6) cornerRadius: 0.66];
    [UIColor.grayColor setFill];
    [rectangle8Path fill];

    CGContextRestoreGState(context);


    //// Rectangle 9 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 17.67, 18);
    CGContextRotateCTM(context, -45 * M_PI / 180);

    UIBezierPath* rectangle9Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, 1.33, 6) cornerRadius: 0.66];
    [UIColor.grayColor setFill];
    [rectangle9Path fill];

    CGContextRestoreGState(context);
}

+ (void)drawRaindropWithWaterFill: (CGFloat)waterFill
{
    //// Color Declarations
    UIColor* color4 = [UIColor colorWithRed: 0.573 green: 0.762 blue: 1 alpha: 1];
    UIColor *backgroundColor =  [UIColor colorWithRed:226.0f/255.0f
                                                green:226.0f/255.0f
                                                 blue:226.0f/255.0f
                                                alpha:255.0f/255.0f];

    //// Bezier 2 Drawing
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path moveToPoint: CGPointMake(50.25, 102.25)];
    [bezier2Path addCurveToPoint: CGPointMake(14.25, 41.75) controlPoint1: CGPointMake(50.25, 102.25) controlPoint2: CGPointMake(14.25, 70.39)];
    [bezier2Path addCurveToPoint: CGPointMake(50.25, 1.75) controlPoint1: CGPointMake(14.25, 13.11) controlPoint2: CGPointMake(30.75, 1.75)];
    [bezier2Path addCurveToPoint: CGPointMake(85.25, 41.75) controlPoint1: CGPointMake(69.75, 1.75) controlPoint2: CGPointMake(85.25, 13.11)];
    [bezier2Path addCurveToPoint: CGPointMake(50.25, 102.25) controlPoint1: CGPointMake(85.25, 70.39) controlPoint2: CGPointMake(50.25, 102.25)];
    [bezier2Path closePath];
    bezier2Path.lineCapStyle = kCGLineCapRound;

    [UIColor.grayColor setFill];
    [bezier2Path fill];
    [UIColor.blackColor setStroke];
    bezier2Path.lineWidth = 0.5;
    [bezier2Path stroke];


    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(8, 0, 85, waterFill)];
    [color4 setFill];
    [rectanglePath fill];


    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(50.25, 102.25)];
    [bezierPath addCurveToPoint: CGPointMake(14.25, 41.75) controlPoint1: CGPointMake(50.25, 102.25) controlPoint2: CGPointMake(14.25, 70.39)];
    [bezierPath addCurveToPoint: CGPointMake(50.25, 1.75) controlPoint1: CGPointMake(14.25, 13.11) controlPoint2: CGPointMake(30.75, 1.75)];
    [bezierPath addCurveToPoint: CGPointMake(85.25, 41.75) controlPoint1: CGPointMake(69.75, 1.75) controlPoint2: CGPointMake(85.25, 13.11)];
    [bezierPath addCurveToPoint: CGPointMake(50.25, 102.25) controlPoint1: CGPointMake(85.25, 70.39) controlPoint2: CGPointMake(50.25, 102.25)];
    [bezierPath closePath];
    bezierPath.lineCapStyle = kCGLineCapRound;

    [UIColor.blackColor setStroke];
    bezierPath.lineWidth = 0.5;
    [bezierPath stroke];


    //// Bezier 4 Drawing
    UIBezierPath* bezier4Path = [UIBezierPath bezierPath];
    [bezier4Path moveToPoint: CGPointMake(50.25, 102.25)];
    [bezier4Path addCurveToPoint: CGPointMake(14.25, 41.75) controlPoint1: CGPointMake(50.25, 102.25) controlPoint2: CGPointMake(14.25, 70.39)];
    [bezier4Path addCurveToPoint: CGPointMake(50.25, 1.75) controlPoint1: CGPointMake(14.25, 13.11) controlPoint2: CGPointMake(30.75, 1.75)];
    [bezier4Path addCurveToPoint: CGPointMake(85.25, 41.75) controlPoint1: CGPointMake(69.75, 1.75) controlPoint2: CGPointMake(85.25, 13.11)];
    [bezier4Path addCurveToPoint: CGPointMake(50.25, 102.25) controlPoint1: CGPointMake(85.25, 70.39) controlPoint2: CGPointMake(50.25, 102.25)];
    [bezier4Path closePath];
    [bezier4Path moveToPoint: CGPointMake(93, 105)];
    [bezier4Path addCurveToPoint: CGPointMake(93, 0) controlPoint1: CGPointMake(93, 105) controlPoint2: CGPointMake(93, 0)];
    [bezier4Path addLineToPoint: CGPointMake(8, 0)];
    [bezier4Path addLineToPoint: CGPointMake(8, 105)];
    [bezier4Path addLineToPoint: CGPointMake(93, 105)];
    [bezier4Path addLineToPoint: CGPointMake(93, 105)];
    [bezier4Path closePath];
    [backgroundColor setFill];
    [bezier4Path fill];
}

+ (void)drawMoistureTabIcon
{

    //// Bezier 2 Drawing
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path moveToPoint: CGPointMake(12.87, 0.25)];
    [bezier2Path addCurveToPoint: CGPointMake(4.25, 15) controlPoint1: CGPointMake(12.87, 0.25) controlPoint2: CGPointMake(4.25, 8.02)];
    [bezier2Path addCurveToPoint: CGPointMake(12.87, 24.75) controlPoint1: CGPointMake(4.25, 21.98) controlPoint2: CGPointMake(8.2, 24.75)];
    [bezier2Path addCurveToPoint: CGPointMake(21.25, 15) controlPoint1: CGPointMake(17.54, 24.75) controlPoint2: CGPointMake(21.25, 21.98)];
    [bezier2Path addCurveToPoint: CGPointMake(12.87, 0.25) controlPoint1: CGPointMake(21.25, 8.02) controlPoint2: CGPointMake(12.87, 0.25)];
    [bezier2Path closePath];
    bezier2Path.lineCapStyle = kCGLineCapRound;

    [UIColor.grayColor setFill];
    [bezier2Path fill];
    [UIColor.blackColor setStroke];
    bezier2Path.lineWidth = 0.5;
    [bezier2Path stroke];
}

+ (void)drawTempWithTempFill: (CGFloat)tempFill
{
    //// Color Declarations
    UIColor* _2 = [UIColor colorWithRed: 0.686 green: 0 blue: 0 alpha: 1];

    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(6, 20, 19, 100) cornerRadius: 5];
    [UIColor.darkGrayColor setFill];
    [rectanglePath fill];


    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(1, 0, 29, 29)];
    [_2 setFill];
    [ovalPath fill];


    //// Rectangle 3 Drawing
    UIBezierPath* rectangle3Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(6, 111, 3, 1) cornerRadius: 0.5];
    [UIColor.blackColor setFill];
    [rectangle3Path fill];


    //// Rectangle 4 Drawing
    UIBezierPath* rectangle4Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(6, 106, 3, 1) cornerRadius: 0.5];
    [UIColor.blackColor setFill];
    [rectangle4Path fill];


    //// Rectangle 5 Drawing
    UIBezierPath* rectangle5Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(6, 101, 3, 1) cornerRadius: 0.5];
    [UIColor.blackColor setFill];
    [rectangle5Path fill];


    //// Rectangle 6 Drawing
    UIBezierPath* rectangle6Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(6, 96, 3, 1) cornerRadius: 0.5];
    [UIColor.blackColor setFill];
    [rectangle6Path fill];


    //// Rectangle 7 Drawing
    UIBezierPath* rectangle7Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(6, 91, 3, 1) cornerRadius: 0.5];
    [UIColor.blackColor setFill];
    [rectangle7Path fill];


    //// Rectangle 8 Drawing
    UIBezierPath* rectangle8Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(6, 86, 3, 1) cornerRadius: 0.5];
    [UIColor.blackColor setFill];
    [rectangle8Path fill];


    //// Rectangle 9 Drawing
    UIBezierPath* rectangle9Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(6, 81, 3, 1) cornerRadius: 0.5];
    [UIColor.blackColor setFill];
    [rectangle9Path fill];


    //// Rectangle 10 Drawing
    UIBezierPath* rectangle10Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(6, 76, 3, 1) cornerRadius: 0.5];
    [UIColor.blackColor setFill];
    [rectangle10Path fill];


    //// Rectangle 11 Drawing
    UIBezierPath* rectangle11Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(6, 71, 3, 1) cornerRadius: 0.5];
    [UIColor.blackColor setFill];
    [rectangle11Path fill];


    //// Rectangle 12 Drawing
    UIBezierPath* rectangle12Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(6, 66, 3, 1) cornerRadius: 0.5];
    [UIColor.blackColor setFill];
    [rectangle12Path fill];


    //// Rectangle 13 Drawing
    UIBezierPath* rectangle13Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(6, 61, 3, 1) cornerRadius: 0.5];
    [UIColor.blackColor setFill];
    [rectangle13Path fill];


    //// Rectangle 14 Drawing
    UIBezierPath* rectangle14Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(6, 56, 3, 1) cornerRadius: 0.5];
    [UIColor.blackColor setFill];
    [rectangle14Path fill];


    //// Rectangle 15 Drawing
    UIBezierPath* rectangle15Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(6, 52, 3, 1) cornerRadius: 0.5];
    [UIColor.blackColor setFill];
    [rectangle15Path fill];


    //// Rectangle 16 Drawing
    UIBezierPath* rectangle16Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(6, 47, 3, 1) cornerRadius: 0.5];
    [UIColor.blackColor setFill];
    [rectangle16Path fill];


    //// Rectangle 17 Drawing
    UIBezierPath* rectangle17Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(6, 42, 3, 1) cornerRadius: 0.5];
    [UIColor.blackColor setFill];
    [rectangle17Path fill];


    //// Rectangle 18 Drawing
    UIBezierPath* rectangle18Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(6, 37, 3, 1) cornerRadius: 0.5];
    [UIColor.blackColor setFill];
    [rectangle18Path fill];


    //// Rectangle 19 Drawing
    UIBezierPath* rectangle19Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(6, 32, 3, 1) cornerRadius: 0.5];
    [UIColor.blackColor setFill];
    [rectangle19Path fill];


    //// Rectangle 20 Drawing
    UIBezierPath* rectangle20Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(6, 27, 3, 1) cornerRadius: 0.5];
    [UIColor.blackColor setFill];
    [rectangle20Path fill];


    //// Rectangle 2 Drawing
    UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(6, 19, 19, tempFill) cornerRadius: 5];
    [_2 setFill];
    [rectangle2Path fill];
}

+ (void)drawTempTabIcon
{

    //// Group
    {
        //// Rectangle Drawing
        UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(11, 0, 4, 22) cornerRadius: 2];
        [UIColor.darkGrayColor setFill];
        [rectanglePath fill];


        //// Oval Drawing
        UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(10, 19, 6, 6)];
        [UIColor.darkGrayColor setFill];
        [ovalPath fill];
    }
}

+ (void)drawPHVial
{
    //// Color Declarations
    UIColor* color5 = [UIColor colorWithRed: 0.013 green: 0.664 blue: 0.061 alpha: 1];

    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(31.91, 1.63)];
    [bezierPath addCurveToPoint: CGPointMake(31.91, 7.68) controlPoint1: CGPointMake(30.57, 3.14) controlPoint2: CGPointMake(30.57, 6.17)];
    [bezierPath addCurveToPoint: CGPointMake(38.61, 9.19) controlPoint1: CGPointMake(33.25, 9.19) controlPoint2: CGPointMake(37.27, 9.19)];
    [bezierPath addCurveToPoint: CGPointMake(38.61, 25.81) controlPoint1: CGPointMake(39.95, 9.19) controlPoint2: CGPointMake(38.61, 25.81)];
    [bezierPath addCurveToPoint: CGPointMake(2.44, 119.5) controlPoint1: CGPointMake(38.61, 25.81) controlPoint2: CGPointMake(-9.62, 119.5)];
    [bezierPath addCurveToPoint: CGPointMake(97.56, 119.5) controlPoint1: CGPointMake(14.49, 119.5) controlPoint2: CGPointMake(85.51, 119.5)];
    [bezierPath addCurveToPoint: CGPointMake(61.39, 25.81) controlPoint1: CGPointMake(109.62, 119.5) controlPoint2: CGPointMake(61.39, 25.81)];
    [bezierPath addCurveToPoint: CGPointMake(61.39, 9.19) controlPoint1: CGPointMake(61.39, 25.81) controlPoint2: CGPointMake(60.05, 9.19)];
    [bezierPath addCurveToPoint: CGPointMake(66.75, 7.68) controlPoint1: CGPointMake(62.73, 9.19) controlPoint2: CGPointMake(65.41, 9.19)];
    [bezierPath addCurveToPoint: CGPointMake(66.75, 1.63) controlPoint1: CGPointMake(68.09, 6.17) controlPoint2: CGPointMake(68.09, 3.14)];
    [bezierPath addCurveToPoint: CGPointMake(31.91, 1.63) controlPoint1: CGPointMake(65.41, 0.12) controlPoint2: CGPointMake(33.25, 0.12)];
    [bezierPath closePath];
    [UIColor.lightGrayColor setFill];
    [bezierPath fill];
    [UIColor.blackColor setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath stroke];


    //// Bezier 3 Drawing
    UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
    [bezier3Path moveToPoint: CGPointMake(93.22, 118)];
    [bezier3Path addLineToPoint: CGPointMake(5.78, 118)];
    [bezier3Path addCurveToPoint: CGPointMake(34.53, 37) controlPoint1: CGPointMake(-3.1, 118) controlPoint2: CGPointMake(23.55, 60.09)];
    [bezier3Path addLineToPoint: CGPointMake(64.47, 37)];
    [bezier3Path addCurveToPoint: CGPointMake(93.22, 118) controlPoint1: CGPointMake(75.45, 60.09) controlPoint2: CGPointMake(102.1, 118)];
    [bezier3Path closePath];
    [color5 setFill];
    [bezier3Path fill];


    //// Rectangle 20 Drawing
    UIBezierPath* rectangle20Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(4, 105, 7, 1) cornerRadius: 0.5];
    [UIColor.blackColor setFill];
    [rectangle20Path fill];


    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(8, 93, 7, 1) cornerRadius: 0.5];
    [UIColor.blackColor setFill];
    [rectanglePath fill];


    //// Rectangle 2 Drawing
    UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(13.5, 80, 7, 1) cornerRadius: 0.5];
    [UIColor.blackColor setFill];
    [rectangle2Path fill];


    //// Rectangle 3 Drawing
    UIBezierPath* rectangle3Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(18.5, 69, 7, 1) cornerRadius: 0.5];
    [UIColor.blackColor setFill];
    [rectangle3Path fill];


    //// Rectangle 4 Drawing
    UIBezierPath* rectangle4Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(23.5, 58, 7, 1) cornerRadius: 0.5];
    [UIColor.blackColor setFill];
    [rectangle4Path fill];


    //// Rectangle 5 Drawing
    UIBezierPath* rectangle5Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(28.5, 48, 7, 1) cornerRadius: 0.5];
    [UIColor.blackColor setFill];
    [rectangle5Path fill];
}

+ (void)drawPHTabIcon
{

    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(8.85, 0.73)];
    [bezierPath addCurveToPoint: CGPointMake(8.85, 1.95) controlPoint1: CGPointMake(8.58, 1.03) controlPoint2: CGPointMake(8.58, 1.64)];
    [bezierPath addCurveToPoint: CGPointMake(10.2, 2.25) controlPoint1: CGPointMake(9.12, 2.25) controlPoint2: CGPointMake(9.93, 2.25)];
    [bezierPath addCurveToPoint: CGPointMake(10.2, 5.6) controlPoint1: CGPointMake(10.47, 2.25) controlPoint2: CGPointMake(10.2, 5.6)];
    [bezierPath addCurveToPoint: CGPointMake(2.89, 24.5) controlPoint1: CGPointMake(10.2, 5.6) controlPoint2: CGPointMake(0.45, 24.5)];
    [bezierPath addCurveToPoint: CGPointMake(22.11, 24.5) controlPoint1: CGPointMake(5.33, 24.5) controlPoint2: CGPointMake(19.67, 24.5)];
    [bezierPath addCurveToPoint: CGPointMake(14.8, 5.6) controlPoint1: CGPointMake(24.55, 24.5) controlPoint2: CGPointMake(14.8, 5.6)];
    [bezierPath addCurveToPoint: CGPointMake(14.8, 2.25) controlPoint1: CGPointMake(14.8, 5.6) controlPoint2: CGPointMake(14.53, 2.25)];
    [bezierPath addCurveToPoint: CGPointMake(15.88, 1.95) controlPoint1: CGPointMake(15.07, 2.25) controlPoint2: CGPointMake(15.61, 2.25)];
    [bezierPath addCurveToPoint: CGPointMake(15.88, 0.73) controlPoint1: CGPointMake(16.15, 1.64) controlPoint2: CGPointMake(16.15, 1.03)];
    [bezierPath addCurveToPoint: CGPointMake(8.85, 0.73) controlPoint1: CGPointMake(15.61, 0.42) controlPoint2: CGPointMake(9.12, 0.42)];
    [bezierPath closePath];
    [UIColor.lightGrayColor setFill];
    [bezierPath fill];
    [UIColor.blackColor setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath stroke];
}

#pragma mark Generated Images

+ (UIImage*)imageOfSunWithSunFill: (CGFloat)sunFill
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(165, 92), NO, 0.0f);
    [GardenGuardianKit drawSunWithSunFill: sunFill];

    UIImage* imageOfSun = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return imageOfSun;
}

+ (UIImage*)imageOfSunTabIcon
{
    if (_imageOfSunTabIcon)
        return _imageOfSunTabIcon;

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(25, 25), NO, 0.0f);
    [GardenGuardianKit drawSunTabIcon];

    _imageOfSunTabIcon = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return _imageOfSunTabIcon;
}

+ (UIImage*)imageOfRaindropWithWaterFill: (CGFloat)waterFill
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(100, 105), NO, 0.0f);
    [GardenGuardianKit drawRaindropWithWaterFill: waterFill];

    UIImage* imageOfRaindrop = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return imageOfRaindrop;
}

+ (UIImage*)imageOfTempWithTempFill: (CGFloat)tempFill
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(30, 120), NO, 0.0f);
    [GardenGuardianKit drawTempWithTempFill: tempFill];

    UIImage* imageOfTemp = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return imageOfTemp;
}

+ (UIImage*)imageOfPHVial
{
    if (_imageOfPHVial)
        return _imageOfPHVial;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(100, 120), NO, 0.0f);
    [GardenGuardianKit drawPHVial];
    
    _imageOfPHVial = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return _imageOfPHVial;
}

#pragma mark Customization Infrastructure

- (void)setSunTabIconTargets: (NSArray*)sunTabIconTargets
{
    _sunTabIconTargets = sunTabIconTargets;

    for (id target in self.sunTabIconTargets)
        [target performSelector: @selector(setImage:) withObject: GardenGuardianKit.imageOfSunTabIcon];
}


@end
