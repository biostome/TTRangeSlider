#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "TTRangeSlider+Calibration.h"
#import "TTRangeSlider+Swizzle.h"
#import "TTRangeSlider.h"
#import "TTRangeSliderDelegate.h"

FOUNDATION_EXPORT double TTRangeSliderVersionNumber;
FOUNDATION_EXPORT const unsigned char TTRangeSliderVersionString[];
