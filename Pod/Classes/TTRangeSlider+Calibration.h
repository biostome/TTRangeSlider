//
//  TTRangeSlider+Calibration.h
//  RangeSliderDemo
//
//  Created by Face on 2020/5/18.
//  Copyright © 2020 tomthorpe. All rights reserved.
//

#import <TTRangeSlider/TTRangeSlider.h>

NS_ASSUME_NONNULL_BEGIN


@class TTCalibrationLayer;


@interface TTRangeSlider (Calibration)
@property (strong,nonatomic) TTCalibrationLayer *calibrationLayer;
@property (weak,nonatomic) CALayer *q_sliderLiner;
@property (weak,nonatomic) CALayer *q_sliderLineBetweenHandles;


/// 刻度个数
@property (assign,nonatomic) CGFloat calibreateStepCount;
/// 刻度宽度
@property (assign,nonatomic) CGFloat calibreateWidth;
/// 刻度高度
@property (assign,nonatomic) CGFloat calibreateHeight;
/// 最大值和最小值区间的刻度颜色
@property (strong,nonatomic) UIColor *calibreateBetweenColor;
/// 最大值和最小值区间之外的刻度颜色
@property (strong,nonatomic) UIColor *calibreateTintColor;
/// 隐藏刻度 默认为YES
@property (assign,nonatomic) BOOL hiddenCalibreate;
@end


NS_ASSUME_NONNULL_END
