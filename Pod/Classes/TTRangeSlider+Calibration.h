//
//  TTRangeSlider+Calibration.h
//  RangeSliderDemo
//
//  Created by Face on 2020/5/18.
//  Copyright © 2020 tomthorpe. All rights reserved.
//

#import <TTRangeSlider/TTRangeSlider.h>
NS_ASSUME_NONNULL_BEGIN



@interface TTCalibrationLayer : CALayer
@property (assign,nonatomic) CGFloat stepCount;
@property (strong,nonatomic) UIColor *alibrateColor;
@property (assign,nonatomic) CGFloat alibreateWidth;
@property (assign,nonatomic) CGFloat alibreateHeight;
@end


@interface TTRangeSlider (Calibration)
@property (strong,nonatomic) TTCalibrationLayer *calibrationLayer;
@property (weak,nonatomic) CALayer *q_sliderLiner;
@end

NS_ASSUME_NONNULL_END
