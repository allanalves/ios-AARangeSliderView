//
//  ViewController.h
//  AARangeSliderView-Demo
//
//  Created by Allan Alves on 8/5/15.
//  Copyright (c) 2015 Allan Alves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AARangeSliderView.h"

@interface ViewController : UIViewController <AARangeSliderViewDelegate>

@property (weak, nonatomic) IBOutlet AARangeSliderView *rangeSlider;
@property (weak, nonatomic) IBOutlet UILabel *labelRange;

@end

