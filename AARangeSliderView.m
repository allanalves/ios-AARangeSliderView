//
//  AARangeSliderView.m
//  SliderTest
//
//  Created by Allan Alves on 8/5/15.
//  Copyright (c) 2015 Allan Alves. All rights reserved.
//

IB_DESIGNABLE

#define DEFAULT_GRAY_RANGE_SLIDER [UIColor colorWithRed:183.0/255.0 green:183.0/255.0 blue:183.0/255.0 alpha:1]
#define CIRCLE_SIZE_RANGE_SLIDER 28.0
#define HALF_CIRCLE_SIZE_RANGE_SLIDER CIRCLE_SIZE_RANGE_SLIDER/2

#import "AARangeSliderView.h"

@implementation AARangeSliderView{
    /*! Left Slider */
    UISlider *firstSlider;
    
    /*! Right Slider */
    UISlider *secondSlider;
    
    /*! Slider to be Changed When User is Moving */
    UISlider *sliderToChange;
}

@synthesize delegate;

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.maxValue = 100;
        self.minValue = 0;
        self.startRangeValue = 0;
        self.endRangeValue = 100;
    }
    return self;
}

/*! DRAWS JUST IN INTERFACE BUILDER - NOTHING IS RENDERED WHEN APP IS RUNNING */
- (void) drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    //RENDER ONLY WHEN ITS RUNNING
    if (firstSlider && secondSlider) {
        return;
    }
    
    //IF NOTHING IS SET, SET DEFAULT JUST TO DRAW
    if (!self.maxValue && !self.endRangeValue) {
        self.maxValue = 100;
        self.minValue = 0;
        self.startRangeValue = 0;
        self.endRangeValue = 100;
    }
    
    //POINT OF FIRST SLIDER CIRCLE TO DRAW
    float firstRectOriginX = [self
                              valueToPointsWithValue:self.startRangeValue]-HALF_CIRCLE_SIZE_RANGE_SLIDER;
    
    //POINT OF SECOND SLIDER CIRCLE TO DRAW
    float secondRectOriginX = [self
                               valueToPointsWithValue:self.endRangeValue]-HALF_CIRCLE_SIZE_RANGE_SLIDER;
    
    /*! LINE GRAY FROM START */
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, DEFAULT_GRAY_RANGE_SLIDER.CGColor);
    CGContextSetLineWidth(context, 1.8f);
    CGContextMoveToPoint(context, 2.0f, CGRectGetMidY(self.bounds));
    CGContextAddLineToPoint(context, firstRectOriginX,
                            CGRectGetMidY(self.bounds));
    CGContextStrokePath(context);
    
    /*! LINE BETWEEN TINT */
    CGContextSetStrokeColorWithColor(context, self.tintColor.CGColor);
    CGContextSetLineWidth(context, 1.8f);
    CGContextMoveToPoint(context, firstRectOriginX, CGRectGetMidY(self.bounds));
    CGContextAddLineToPoint(context, secondRectOriginX,
                            CGRectGetMidY(self.bounds));
    CGContextStrokePath(context);
    
    /*! LINE GRAY TO END */
    CGContextSetStrokeColorWithColor(context, DEFAULT_GRAY_RANGE_SLIDER.CGColor);
    CGContextSetLineWidth(context, 1.8f);
    CGContextMoveToPoint(context, secondRectOriginX, CGRectGetMidY(self.bounds));
    CGContextAddLineToPoint(context, self.bounds.size.width - 2.0f,
                            CGRectGetMidY(self.bounds));
    CGContextStrokePath(context);
    
    /*! FIRST CIRCLE */
    
    //FIRCE DRAW LIMIT
    if (firstRectOriginX <= 0) firstRectOriginX = 0;
    
    CGRect firstRect = CGRectMake(firstRectOriginX,
                                  CGRectGetMidY(self.bounds)-HALF_CIRCLE_SIZE_RANGE_SLIDER,
                                  CIRCLE_SIZE_RANGE_SLIDER,
                                  CIRCLE_SIZE_RANGE_SLIDER);
    
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 0.1);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, 2.0);
    CGContextFillEllipseInRect (context, firstRect);
    CGContextStrokeEllipseInRect(context, firstRect);
    CGContextFillPath(context);
    
    /*! SECOND CIRCLE */
    
    //FORCE DRAW LIMIT
    if (secondRectOriginX >= self.bounds.size.width-CIRCLE_SIZE_RANGE_SLIDER)
        secondRectOriginX = self.bounds.size.width-CIRCLE_SIZE_RANGE_SLIDER;
    
    CGRect secondRect = CGRectMake(secondRectOriginX,
                                   CGRectGetMidY(self.bounds)-HALF_CIRCLE_SIZE_RANGE_SLIDER,
                                   CIRCLE_SIZE_RANGE_SLIDER, CIRCLE_SIZE_RANGE_SLIDER);
    
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 0.1);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, 2.0);
    CGContextFillEllipseInRect (context, secondRect);
    CGContextStrokeEllipseInRect(context, secondRect);
    CGContextFillPath(context);
}

- (void) awakeFromNib {
    firstSlider = [[UISlider alloc] initWithFrame:self.bounds];
    secondSlider = [[UISlider alloc] initWithFrame:self.bounds];
    
    //SET MIN AND MAX VALUES OF BOTH SLIDERS
    firstSlider.maximumValue = self.maxValue;
    firstSlider.minimumValue = self.minValue;
    secondSlider.maximumValue = self.maxValue;
    firstSlider.minimumValue = self.minValue;
    [self addSubview:firstSlider];
    [self addSubview:secondSlider];
    [self addConstraintsForSlider:firstSlider];
    [self addConstraintsForSlider:secondSlider];
    
    //SLIDERS COLORS
    firstSlider.minimumTrackTintColor = DEFAULT_GRAY_RANGE_SLIDER;
    firstSlider.maximumTrackTintColor = self.tintColor;
    secondSlider.tintColor = [UIColor clearColor];
    secondSlider.maximumTrackTintColor = DEFAULT_GRAY_RANGE_SLIDER;
    secondSlider.minimumTrackTintColor = [UIColor clearColor];
    
    firstSlider.userInteractionEnabled = NO;
    secondSlider.userInteractionEnabled = NO;
    
    //SET DEFAULT MINIMUM RANGE
    if (!self.minRange) {
        self.minRange = self.maxValue*0.15;
    }
    
    //SET VALUES OF BOTH SLIDERS
    firstSlider.value = self.startRangeValue;
    secondSlider.value = self.endRangeValue;
    
    //FIX ANY VALUE MISTAKE
    if (self.startRangeValue <= self.minValue) {
        self.startRangeValue = self.minValue;
    }
    if (self.endRangeValue >= self.maxValue) {
        self.endRangeValue = self.maxValue;
    }
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self];
    
    float perValue = (point.x)/self.bounds.size.width;
    float sliderValue = perValue*self.maxValue;
    
    float dFirstSliderValue = fabsf(firstSlider.value - sliderValue);
    float dSecondSliderValue = fabsf(secondSlider.value - sliderValue);
    
    float minDistance = MIN(dFirstSliderValue, dSecondSliderValue);
    if (minDistance <= self.maxValue*0.15) { //AREA OF TOUCH DETECTION
        if (minDistance == dFirstSliderValue) {
            sliderToChange = firstSlider;
        } else {
            sliderToChange = secondSlider;
        }
    } else {
        sliderToChange = nil;
    }
    
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self];
    static BOOL limit;
    
    float sliderValue = [self pointsToValueWithPoints:point.x];

    if (sliderToChange == firstSlider) {
        if (sliderValue >= secondSlider.value - self.minRange) {
            limit = YES;
            firstSlider.value = secondSlider.value - self.minRange;
            self.startRangeValue = sliderValue;
        } else limit = NO;
    }
    
    if (sliderToChange == secondSlider){
        if (sliderValue <= firstSlider.value + self.minRange) {
            limit = YES;
            secondSlider.value = firstSlider.value + self.minRange;
            self.endRangeValue = sliderValue;
        } else limit = NO;
    }
    
    if (!limit) {
        
        if (sliderValue <= self.minValue) sliderValue = self.minValue;
        if (sliderValue >= self.maxValue) sliderValue = self.maxValue;
        
        sliderToChange.value = sliderValue;
        if (sliderToChange == firstSlider) {
            if ([delegate respondsToSelector:@selector(didChangeStartValueOfSlider:withValue:)]) {
                [delegate didChangeStartValueOfSlider:self withValue:sliderValue];
            }
        }
        if (sliderToChange == secondSlider) {
            if ([delegate respondsToSelector:@selector(didChangeEndValueOfSlider:withValue:)]) {
                [delegate didChangeEndValueOfSlider:self withValue:sliderValue];
            }
        }
    }
}

#pragma mark - Other

- (float) valueToPointsWithValue:(float)value {
    float perValue = value/self.maxValue;
    return self.bounds.size.width*perValue;
}

- (float) pointsToValueWithPoints:(float)points {
    float perPoints = points/self.bounds.size.width;
    return self.maxValue*perPoints;
}

#pragma mark - Constraints

- (void) addConstraintsForSlider:(UISlider*)slider {  // Width constraint
    slider.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *width =[NSLayoutConstraint
                                constraintWithItem:slider
                                attribute:NSLayoutAttributeWidth
                                relatedBy:0
                                toItem:self
                                attribute:NSLayoutAttributeWidth
                                multiplier:1.0
                                constant:0];
    
    NSLayoutConstraint *height =[NSLayoutConstraint
                                 constraintWithItem:slider
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:0
                                 toItem:self
                                 attribute:NSLayoutAttributeHeight
                                 multiplier:1.0
                                 constant:0];
    
    NSLayoutConstraint *top = [NSLayoutConstraint
                               constraintWithItem:slider
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                               toItem:self
                               attribute:NSLayoutAttributeTop
                               multiplier:1.0f
                               constant:0.f];
    
    NSLayoutConstraint *leading = [NSLayoutConstraint
                                   constraintWithItem:slider
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self
                                   attribute:NSLayoutAttributeLeading
                                   multiplier:1.0f
                                   constant:0.f];
    
    [self addConstraints:@[width,height,top,leading]];
}

@end





