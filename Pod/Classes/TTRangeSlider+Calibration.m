//
//  TTRangeSlider+Calibration.m
//  RangeSliderDemo
//
//  Created by Face on 2020/5/18.
//  Copyright © 2020 tomthorpe. All rights reserved.
//

#import "TTRangeSlider+Calibration.h"
#import <objc/runtime.h>

@implementation TTCalibrationLayer

- (void)setupControl{
    _stepCount = 0;
    _alibrateColor = UIColor.blackColor;
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
    if (self.stepCount > 0) {
        CGFloat stepW = self.frame.size.width / self.stepCount;
        [self.sublayers enumerateObjectsUsingBlock:^(__kindof CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGRect frame = CGRectMake((idx * stepW)-(self.alibreateWidth/2.0),
                                      CGRectGetHeight(self.frame)-self.alibreateHeight,
                                      self.alibreateWidth,
                                      self.alibreateHeight);
            obj.frame = frame;
        }];
    }
}

- (void)setAlibrateColor:(UIColor *)alibrateColor{
    _alibrateColor = alibrateColor;
    [self.sublayers enumerateObjectsUsingBlock:^(__kindof CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.backgroundColor = alibrateColor.CGColor;
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
    for (int i = 0; i<=count; i++) {
        CALayer * v = [[CALayer alloc]init];
        v.backgroundColor = self.alibrateColor.CGColor;
        [self addSublayer:v];
    }
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
@dynamic calibrationLayer,q_sliderLiner;

+ (void)swizzleMethods:(Class)class originalSelector:(SEL)origSel swizzledSelector:(SEL)swizSel {
    
    Method origMethod = class_getInstanceMethod(class, origSel);
    Method swizMethod = class_getInstanceMethod(class, swizSel);
    
    BOOL didAddMethod = class_addMethod(class, origSel, method_getImplementation(swizMethod), method_getTypeEncoding(swizMethod));
    if (didAddMethod) {
        class_replaceMethod(class, swizSel, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, swizMethod);
    }
}

+ (void)load{
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wundeclared-selector"
    [TTRangeSlider swizzleMethods:[self class] originalSelector:@selector(initialiseControl) swizzledSelector:@selector(q_initControl)];
    #pragma clang diagnostic pop
    [TTRangeSlider swizzleMethods:[self class] originalSelector:@selector(layoutSubviews) swizzledSelector:@selector(q_layoutSubviews)];
}


- (void)q_initControl{
    [self q_initControl];
    self.q_sliderLiner = [self valueForKeyPath:@"sliderLine"];
    self.calibrationLayer = [[TTCalibrationLayer alloc]init];
    [self.layer insertSublayer:self.calibrationLayer atIndex:0];
}

- (void)q_layoutSubviews{
    [self q_layoutSubviews];
    CGRect sldF = self.q_sliderLiner.frame;
    self.calibrationLayer.frame = CGRectMake(CGRectGetMinX(sldF),
                                             CGRectGetMinY(self.bounds),
                                             CGRectGetWidth(sldF),
                                             CGRectGetMinY(sldF)+CGRectGetHeight(sldF));
    
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
