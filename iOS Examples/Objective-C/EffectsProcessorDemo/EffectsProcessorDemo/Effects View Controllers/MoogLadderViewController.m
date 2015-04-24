//
//  MoogLadderViewController.m
//  EffectsProcessorDemo
//
//  Created by Aurelius Prochazka on 1/29/15.
//  Copyright (c) 2015 Aurelius Prochazka. All rights reserved.
//

#import "MoogLadderViewController.h"
#import "SharedStore.h"

@implementation MoogLadderViewController {
    IBOutlet AKPropertySlider *cutoffFrequencySlider;
    IBOutlet AKPropertySlider *resonanceSlider;
    IBOutlet AKPropertySlider *mixSlider;
}

- (void)viewDidLoad
{
    SharedStore *global = [SharedStore globals];

    cutoffFrequencySlider.property = global.moogLadder.cutoffFrequency;
    resonanceSlider.property       = global.moogLadder.resonance;
    mixSlider.property             = global.moogLadder.mix;
}



@end
