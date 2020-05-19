//
//  YLRangeSliderViewDelegate.h
//  FantasyRealFootball
//
//  Created by Tom Thorpe on 16/04/2014.
//  Copyright (c) 2014 Yahoo inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TTRangeSlider;

@protocol TTRangeSliderDelegate <NSObject>

@optional

/**
* Called when will set min value label
*/
- (nullable NSString *)rangeSlider:(TTRangeSlider *_Nonnull)sender willDisplayMinimumValue:(NSString *_Nullable)minimum;

/**
* Called when will set max value label
*/
- (nullable NSString *)rangeSlider:(TTRangeSlider *_Nonnull)sender willDisplayMaximumValue:(NSString *_Nullable)maximum;

/**
 * Called when the RangeSlider values are changed
 */
-(void)rangeSlider:(TTRangeSlider *_Nonnull)sender didChangeSelectedMinimumValue:(float)selectedMinimum andMaximumValue:(float)selectedMaximum;

/**
 * Called when the user has finished interacting with the RangeSlider
 */
- (void)didEndTouchesInRangeSlider:(TTRangeSlider *_Nonnull)sender;

/**
 * Called when the user has started interacting with the RangeSlider
 */
- (void)didStartTouchesInRangeSlider:(TTRangeSlider *_Nonnull)sender;

@end
