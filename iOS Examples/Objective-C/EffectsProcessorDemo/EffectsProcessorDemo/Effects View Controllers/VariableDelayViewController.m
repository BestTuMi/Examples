//
//  VariableDelayViewController.m
//  EffectsProcessorDemo
//
//  Created by Aurelius Prochazka on 1/29/15.
//  Copyright (c) 2015 Aurelius Prochazka. All rights reserved.
//

#import "VariableDelayViewController.h"
#import "SharedStore.h"

@implementation VariableDelayViewController {
    IBOutlet AKPropertySlider *delayTimeSlider;
    IBOutlet AKPropertySlider *mixSlider;
}

- (void)viewDidLoad
{
    SharedStore *global = [SharedStore globals];

    delayTimeSlider.property = global.variableDelay.delayTime;
    mixSlider.property       = global.variableDelay.mix;
}

@end
