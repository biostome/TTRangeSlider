//
//  TTRangeSlider+Swizzle.h
//  Pods-RangeSliderDemo
//
//  Created by Face on 2020/5/19.
//

#import <TTRangeSlider/TTRangeSlider.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTRangeSlider (Swizzle)
+ (void)q_swizzleMethods:(Class)class originalSelector:(SEL)origSel swizzledSelector:(SEL)swizSel;
@end

NS_ASSUME_NONNULL_END
