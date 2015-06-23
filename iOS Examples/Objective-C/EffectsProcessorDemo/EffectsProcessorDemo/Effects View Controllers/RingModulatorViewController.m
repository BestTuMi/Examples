//
//  RingModulatorViewController.m
//  EffectsProcessorDemo
//
//  Created by Aurelius Prochazka on 6/22/15.
//  Copyright (c) 2015 AudioKit. All rights reserved.
//

#import "RingModulatorViewController.h"

#import "SharedStore.h"

@implementation RingModulatorViewController {
    IBOutlet AKPropertySlider *carrierFrequencySlider;
    IBOutlet AKPropertySlider *mixSlider;
}

- (void)viewDidLoad
{
    SharedStore *global = [SharedStore globals];
    
    carrierFrequencySlider.property = global.ringModulator.carrierFrequency;
    mixSlider.property       = global.ringModulator.mix;
}

@end
