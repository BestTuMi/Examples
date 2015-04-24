//
//  ReverbViewController.m
//  EffectsProcessorDemo
//
//  Created by Aurelius Prochazka on 12/26/13.
//  Copyright (c) 2013 Aurelius Prochazka. All rights reserved.
//

#import "ReverbViewController.h"
#import "SharedStore.h"

@implementation ReverbViewController {
    IBOutlet AKPropertySlider *feedbackSlider;
    IBOutlet AKPropertySlider *mixSlider;
}

- (void)viewDidLoad
{
    SharedStore *global = [SharedStore globals];
    feedbackSlider.property = global.reverb.reverbFeedback;
    mixSlider.property = global.reverb.mix;
}

@end
