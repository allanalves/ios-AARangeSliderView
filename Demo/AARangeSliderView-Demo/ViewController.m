//
//  ViewController.m
//  AARangeSliderView-Demo
//
//  Created by Allan Alves on 8/5/15.
//  Copyright (c) 2015 Allan Alves. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void) didChangeStartValueOfSlider:(AARangeSliderView *)rangeSlider withValue:(float)value {
    self.labelRange.text = [NSString stringWithFormat:@"Start: %.2f; End: %.2f;",
                            value, self.rangeSlider.endRangeValue];
}

- (void) didChangeEndValueOfSlider:(AARangeSliderView *)rangeSlider withValue:(float)value {
    self.labelRange.text = [NSString stringWithFormat:@"Start: %.2f; End: %.2f;",
                            self.rangeSlider.startRangeValue, value];
}

@end
