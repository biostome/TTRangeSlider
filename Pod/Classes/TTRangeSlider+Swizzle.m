//
//  TTRangeSlider+Swizzle.m
//  Pods-RangeSliderDemo
//
//  Created by Face on 2020/5/19.
//

#import "TTRangeSlider+Swizzle.h"

@implementation TTRangeSlider (Swizzle)

+ (void)q_swizzleMethods:(Class)class originalSelector:(SEL)origSel swizzledSelector:(SEL)swizSel {
    
    Method origMethod = class_getInstanceMethod(class, origSel);
    Method swizMethod = class_getInstanceMethod(class, swizSel);
    
    BOOL didAddMethod = class_addMethod(class, origSel, method_getImplementation(swizMethod), method_getTypeEncoding(swizMethod));
    if (didAddMethod) {
        class_replaceMethod(class, swizSel, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, swizMethod);
    }
}
@end
