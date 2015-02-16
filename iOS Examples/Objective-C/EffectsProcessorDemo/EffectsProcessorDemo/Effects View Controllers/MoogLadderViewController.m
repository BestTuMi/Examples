//
//  MoogLadderViewController.m
//  EffectsProcessorDemo
//
//  Created by Aurelius Prochazka on 1/29/15.
//  Copyright (c) 2015 Aurelius Prochazka. All rights reserved.
//

#import "MoogLadderViewController.h"
#import "SharedStore.h"
#import "AKTools.h"
@implementation MoogLadderViewController

- (void)viewDidLoad
{
    SharedStore *global = [SharedStore globals];
    [AKTools setSlider:_cutoffFrequencySlider withProperty:global.moogLadder.cutoffFrequency];
    [AKTools setSlider:_resonanceSlider withProperty:global.moogLadder.resonance];
    [AKTools setSlider:_mixSlider withProperty:global.moogLadder.mix];
}

- (IBAction)changeCutoffFrequency:(UISlider *)sender {
    SharedStore *global = [SharedStore globals];
    [AKTools setProperty:global.moogLadder.cutoffFrequency withSlider:sender];
}
- (IBAction)changeResonance:(UISlider *)sender {
    SharedStore *global = [SharedStore globals];
    [AKTools setProperty:global.moogLadder.resonance withSlider:sender];
}

- (IBAction)changeMix:(UISlider *)sender {
    SharedStore *global = [SharedStore globals];
    [AKTools setProperty:global.moogLadder.mix withSlider:sender];
}


@end
