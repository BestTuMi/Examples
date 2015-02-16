//
//  ReverbViewController.m
//  EffectsProcessorDemo
//
//  Created by Aurelius Prochazka on 12/26/13.
//  Copyright (c) 2013 Aurelius Prochazka. All rights reserved.
//

#import "ReverbViewController.h"
#import "SharedStore.h"
#import "AKTools.h"

@implementation ReverbViewController

- (void)viewDidLoad
{
    SharedStore *global = [SharedStore globals];
    [AKTools setSlider:_feedbackSlider withProperty:global.reverb.reverbFeedback];
    [AKTools setSlider:_mixSlider withProperty:global.reverb.mix];
}

- (IBAction)changeReverbAmount:(UISlider *)sender {
    SharedStore *global = [SharedStore globals];
    [AKTools setProperty:global.reverb.reverbFeedback withSlider:sender];
}

- (IBAction)changeMix:(UISlider *)sender {
    SharedStore *global = [SharedStore globals];
    [AKTools setProperty:global.reverb.mix withSlider:sender];
}

@end
