//
//  AARangeSliderView.h
//  SliderTest
//
//  Created by Allan Alves on 8/5/15.
//  Copyright (c) 2015 Allan Alves. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AARangeSliderViewDelegate;

@interface AARangeSliderView : UIView

@property (nonatomic, strong) IBOutlet id<AARangeSliderViewDelegate> delegate;

/*! Min and Max values That sliders can reach */
@property (nonatomic) IBInspectable float minValue;
@property (nonatomic) IBInspectable float maxValue;

/*! Current Start and End Values */
@property (nonatomic) IBInspectable float startRangeValue;
@property (nonatomic) IBInspectable float endRangeValue;

/*! Min Range - Value between two values */
@property (nonatomic) IBInspectable float minRange;

@end

@protocol AARangeSliderViewDelegate <NSObject>

@optional
- (void) didChangeStartValueOfSlider:(AARangeSliderView*)rangeSlider withValue:(float)value;
- (void) didChangeEndValueOfSlider:(AARangeSliderView*)rangeSlider withValue:(float)value;

@end