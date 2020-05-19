//
//  TTRangeSlider+Calibration.m
//  RangeSliderDemo
//
//  Created by Face on 2020/5/18.
//  Copyright © 2020 tomthorpe. All rights reserved.
//

#import "TTRangeSlider+Calibration.h"
#import "TTRangeSlider+Swizzle.h"



@interface TTCalibrationLayer :CALayer
@property (assign,nonatomic) CGFloat stepCount;
@property (assign,nonatomic) CGFloat alibreateWidth;
@property (assign,nonatomic) CGFloat alibreateHeight;
@property (strong,nonatomic) UIColor *tintColor;
@end

@implementation TTCalibrationLayer

- (void)setupControl{
    _stepCount = 0;
    _tintColor = UIColor.blackColor;
    _alibreateWidth = 0.5;
    _alibreateHeight = 10;
    [self setupLayers:_stepCount];
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setupControl];
    }
    return self;
}

- (void)layoutSublayers{
    [super layoutSublayers];
    [self updateLayersPosition];
}

- (void)updateLayersPosition{
    if (self.stepCount <= 0) return;
    
    CGFloat stepW = self.frame.size.width / self.stepCount;
    for (int i = 0; i<self.stepCount; i++) {
        CGRect frame = CGRectMake((i * stepW)-(self.alibreateWidth/2.0),
                                  CGRectGetHeight(self.frame)-self.alibreateHeight,
                                  self.alibreateWidth,
                                  self.alibreateHeight);
        self.sublayers[i].frame = frame;
    }
    self.sublayers.lastObject.frame = CGRectMake((self.stepCount * stepW)-(self.alibreateWidth/2.0),
                                                 CGRectGetHeight(self.frame)-self.alibreateHeight,
                                                 self.alibreateWidth,
                                                 self.alibreateHeight);
}

- (void)setTintColor:(UIColor *)tintColor{
    _tintColor = tintColor;
    [self.sublayers enumerateObjectsUsingBlock:^(__kindof CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.backgroundColor = tintColor.CGColor;
    }];
    
}

- (void)setAlibreateWidth:(CGFloat)alibreateWidth{
    _alibreateWidth = alibreateWidth;
    [self layoutIfNeeded];
}

- (void)setAlibreateHeight:(CGFloat)alibreateHeight{
    _alibreateHeight = alibreateHeight;
    [self layoutIfNeeded];
}

- (void)setStepCount:(CGFloat)stepCount{
    _stepCount = stepCount;
    [self updateAlibrateLayers];
}

- (void)setupLayers:(int)count{
    if (count <= 0) return;
    
    for (int i = 0; i<count; i++) {
        CALayer * v = [[CALayer alloc]init];
        v.backgroundColor = self.tintColor.CGColor;
        [self addSublayer:v];
    }
    /// one more
    CALayer * v = [[CALayer alloc]init];
    v.backgroundColor = self.tintColor.CGColor;
    [self addSublayer:v];
}

- (void)removeAllLayers{
    [self.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
}

- (void)updateAlibrateLayers{
    [self removeAllLayers];
    [self setupLayers:self.stepCount];
}

@end



@implementation TTRangeSlider (Calibration)
@dynamic calibrationLayer,q_sliderLiner,calibreateTintColor,calibreateBetweenColor,calibreateHeight,calibreateWidth,q_sliderLineBetweenHandles,calibreateStepCount,hiddenCalibreate;

+ (void)load{
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wundeclared-selector"
    [TTRangeSlider q_swizzleMethods:[self class] originalSelector:@selector(initialiseControl) swizzledSelector:@selector(q_initControl)];
    [TTRangeSlider q_swizzleMethods:[self class] originalSelector:@selector(updateHandlePositions) swizzledSelector:@selector(q_updateHandlePositions)];
    #pragma clang diagnostic pop
}


- (void)q_updateHandlePositions{
    [self q_updateHandlePositions];
    [self updateCalibrationLayersColor];
    [self updateCalibrationPostion];
}

- (void)q_initControl{
    [self q_initControl];
    self.calibrationLayer = [[TTCalibrationLayer alloc]init];
    [self.layer insertSublayer:self.calibrationLayer atIndex:0];
    self.q_sliderLiner = [self valueForKeyPath:@"sliderLine"];
    self.q_sliderLineBetweenHandles = [self valueForKeyPath:@"sliderLineBetweenHandles"];
    self.hiddenCalibreate = YES;
}


- (void)updateCalibrationLayersColor {
    for (CALayer * layer in self.calibrationLayer.sublayers) {
        CGFloat minx = CGRectGetMinX(self.q_sliderLineBetweenHandles.frame);
        CGFloat maxx = CGRectGetMaxX(self.q_sliderLineBetweenHandles.frame);
        CGFloat layerMidx = CGRectGetMidX(layer.frame);
        if (layerMidx > minx && layerMidx < maxx) {
            layer.backgroundColor = self.calibreateBetweenColor.CGColor;
        }else{
            layer.backgroundColor = self.calibreateTintColor.CGColor;
        }
    }
}

- (void)updateCalibrationPostion{
    CGRect sldF = self.q_sliderLiner.frame;
    self.calibrationLayer.frame = CGRectMake(CGRectGetMinX(sldF),
                                             CGRectGetMinY(self.bounds),
                                             CGRectGetWidth(sldF),
                                             CGRectGetMinY(sldF)+CGRectGetHeight(sldF));
}

- (void)setHiddenCalibreate:(BOOL)hiddenCalibreate{
    self.calibrationLayer.hidden = hiddenCalibreate;
}

- (void)setCalibreateHeight:(CGFloat)alibreateHeight{
    self.calibrationLayer.alibreateHeight = alibreateHeight;
}

- (void)setCalibreateWidth:(CGFloat)alibreateWidth{
    self.calibrationLayer.alibreateWidth = alibreateWidth;
}

- (void)setCalibreateStepCount:(CGFloat)stepCount{
    self.calibrationLayer.stepCount = stepCount;
}

- (UIColor *)calibreateTintColor{
    return (UIColor *)objc_getAssociatedObject(self, @selector(calibreateTintColor));
}

- (void)setCalibreateTintColor:(UIColor *)alibreateTintColor{
    objc_setAssociatedObject(self, @selector(calibreateTintColor), alibreateTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)calibreateBetweenColor{
    return (UIColor *)objc_getAssociatedObject(self, @selector(calibreateBetweenColor));
}

- (void)setCalibreateBetweenColor:(UIColor *)alibreateBetweenColor{
    objc_setAssociatedObject(self, @selector(calibreateBetweenColor), alibreateBetweenColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (TTCalibrationLayer *)calibrationLayer{
    return (TTCalibrationLayer *)objc_getAssociatedObject(self, @selector(calibrationLayer));
}

- (void)setCalibrationLayer:(TTCalibrationLayer *)calibrationLayer{
    objc_setAssociatedObject(self, @selector(calibrationLayer), calibrationLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CALayer *)q_sliderLiner{
    return (CALayer *)objc_getAssociatedObject(self, @selector(q_sliderLiner));
}

- (void)setQ_sliderLiner:(CALayer *)q_sliderLiner{
    objc_setAssociatedObject(self, @selector(q_sliderLiner), q_sliderLiner, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

- (CALayer *)q_sliderLineBetweenHandles{
    return (CALayer *)objc_getAssociatedObject(self, @selector(q_sliderLineBetweenHandles));
}

- (void)setQ_sliderLineBetweenHandles:(CALayer *)q_sliderLineBetweenHandles{
    objc_setAssociatedObject(self, @selector(q_sliderLineBetweenHandles), q_sliderLineBetweenHandles, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
