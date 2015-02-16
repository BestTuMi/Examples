//
//  VariableDelayViewController.m
//  EffectsProcessorDemo
//
//  Created by Aurelius Prochazka on 1/29/15.
//  Copyright (c) 2015 Aurelius Prochazka. All rights reserved.
//

#import "VariableDelayViewController.h"
#import "SharedStore.h"
#import "AKTools.h"

@implementation VariableDelayViewController

- (void)viewDidLoad
{
    SharedStore *global = [SharedStore globals];
    [AKTools setSlider:_delayTimeSlider withProperty:global.variableDelay.delayTime];
    [AKTools setSlider:_mixSlider withProperty:global.variableDelay.mix];
}


- (IBAction)changeDelayTime:(UISlider *)sender
{
    SharedStore *global = [SharedStore globals];
    [AKTools setProperty:global.variableDelay.delayTime withSlider:sender];
}                 

- (IBAction)changeMix:(UISlider *)sender
{
    SharedStore *global = [SharedStore globals];
    [AKTools setProperty:global.variableDelay.mix withSlider:sender];
}
@end
