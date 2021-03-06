# ios-AARangeSliderView
iOS Range Slider with Native Appearance and Easy Implementation

Range Slider is a custom slider control to deal with ranges. With default native interface, it lets the implementation clean and natural.

## Features
* Visible in your Storyboard

![storyboard](https://github.com/allanalves/ios-AARangeSliderView/blob/master/Images/rangeslider.png?raw=true)

* Set the values on Attributes Inspector Window
 
![inspector](https://github.com/allanalves/ios-AARangeSliderView/blob/master/Images/inspector.png?raw=true)

* Auto-Layout Friendly


## Installation

### Objective-C
All you need to do is include to your project the files:

```files
AARangeSliderView.h
AARangeSliderView.m
```

And just import to your View Controller:

```objective-c
#import "AARangeSliderView.h"
```

## Usage

### No Code

Create a view with class AARangeSliderView in Identity Inspector

![identity](https://github.com/allanalves/ios-AARangeSliderView/blob/master/Images/identity.png?raw=true)

Connect the view dragging it to your view controller in the storyboard and select the delegate option

![outlet](https://github.com/allanalves/ios-AARangeSliderView/blob/master/Images/outlet.png?raw=true)
![delegate](https://github.com/allanalves/ios-AARangeSliderView/blob/master/Images/delegate.png?raw=true)

### With Code

```objective-c
    AARangeSliderView *rangeSlider = [[AARangeSliderView alloc]
                                      initWithFrame:CGRectMake(0, 0, 300, 50)];
    rangeSlider.delegate = self;
    rangeSlider.maxValue = 255;
    [self.view addSubview:rangeSlider];
```

### Delegation Methods

To get values when user changes it, set your View Controller the protocol and implement the methods as shown below:

```objective-c
@interface ViewController : UIViewController <AARangeSliderViewDelegate>
```

```objective-c

- (void) didChangeStartValueOfSlider:(AARangeSliderView *)rangeSlider withValue:(float)value {
    NSLog(@"Start: %.2f", value);
}

- (void) didChangeEndValueOfSlider:(AARangeSliderView *)rangeSlider withValue:(float)value {
    NSLog(@"End: %.2f", value);
}

```


