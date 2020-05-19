//
//  SecondViewController.m
//  RangeSliderDemo
//
//  Created by Face on 2020/5/19.
//  Copyright © 2020 tomthorpe. All rights reserved.
//

#import "SecondViewController.h"
#import <TTRangeSlider+Calibration.h>

@interface SecondViewController ()<TTRangeSliderDelegate>

@property (strong, nonatomic) TTRangeSlider *rangeSliderCurrency;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.rangeSliderCurrency];

}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.rangeSliderCurrency.frame = CGRectMake(20, 100, CGRectGetWidth(self.view.frame)-40, 130);
}

- (TTRangeSlider *)rangeSliderCurrency{
    if (!_rangeSliderCurrency) {
        _rangeSliderCurrency = [[TTRangeSlider alloc]init];
        _rangeSliderCurrency.userInteractionEnabled =YES;
        _rangeSliderCurrency.minValue = 0;
        _rangeSliderCurrency.delegate = self;
        _rangeSliderCurrency.maxValue = 10;
        _rangeSliderCurrency.selectedMinimum = 4;
        _rangeSliderCurrency.selectedMaximum = 8;
        _rangeSliderCurrency.step = 1;
        _rangeSliderCurrency.enableStep = YES;
        _rangeSliderCurrency.handleColor = [UIColor blueColor];
        _rangeSliderCurrency.handleDiameter = 18;
        _rangeSliderCurrency.selectedHandleDiameterMultiplier = 1.3;
        UIColor * slate = [UIColor colorWithRed:46/255.0 green:46/255.0 blue:46/255.0 alpha:1];
        _rangeSliderCurrency.maxLabelColour = slate;
        _rangeSliderCurrency.minLabelColour = slate;
        _rangeSliderCurrency.lineBorderColor = slate;
        _rangeSliderCurrency.tintColorBetweenHandles = slate;
        UIColor * silver = [UIColor colorWithRed:187/255.0 green:191/255.0 blue:201/255.0 alpha:1];
        _rangeSliderCurrency.tintColor = silver;
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = kCFNumberFormatterPercentStyle;
        _rangeSliderCurrency.numberFormatterOverride = formatter;
        _rangeSliderCurrency.calibreateStepCount = 10;
        _rangeSliderCurrency.calibreateTintColor = silver;
        _rangeSliderCurrency.calibreateBetweenColor = slate;
        _rangeSliderCurrency.hiddenCalibreate = NO;
        _rangeSliderCurrency.calibreateWidth = 1;
        _rangeSliderCurrency.calibreateHeight = 8.3;
    }
    return _rangeSliderCurrency;;
}

- (nullable NSString *)rangeSlider:(TTRangeSlider *_Nonnull)sender willDisplayMaximumValue:(NSString *_Nullable)maximum{

    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterPercentStyle;
    NSNumber * max = [formatter numberFromString:maximum];
    if (max.integerValue == 10) {
        return [[formatter stringFromNumber:@(9)] stringByAppendingString:@"+"];
    }
    return nil;
}

- (NSString *)rangeSlider:(TTRangeSlider *)sender willDisplayMinimumValue:(NSString *)minimum{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterPercentStyle;
    NSNumber * max = [formatter numberFromString:minimum];
    if (max.integerValue == 10) {
        return [[formatter stringFromNumber:@(9)] stringByAppendingString:@"+"];
    }
    return nil;
}

@end
