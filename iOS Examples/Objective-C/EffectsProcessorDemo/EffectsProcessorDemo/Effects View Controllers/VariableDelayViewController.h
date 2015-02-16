//
//  VariableDelayViewController.h
//  EffectsProcessorDemo
//
//  Created by Aurelius Prochazka on 1/29/15.
//  Copyright (c) 2015 Aurelius Prochazka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VariableDelayViewController : UIViewController

@property (strong, nonatomic) IBOutlet UISlider *delayTimeSlider;
@property (strong, nonatomic) IBOutlet UISlider *mixSlider;

@end
