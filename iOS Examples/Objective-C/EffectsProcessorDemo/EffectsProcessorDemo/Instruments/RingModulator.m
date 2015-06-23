//
//  RingModulator.m
//  EffectsProcessorDemo
//
//  Created by Aurelius Prochazka on 6/22/15.
//  Copyright (c) 2015 AudioKit. All rights reserved.
//

#import "RingModulator.h"

@implementation RingModulator

- (instancetype)initWithAudioSource:(AKStereoAudio *)audioSource
{
    self = [super init];
    if (self) {
        
        // Instrument Based Control
        _carrierFrequency = [self createPropertyWithValue:1000 minimum:0 maximum:20000];
        _mix             = [self createPropertyWithValue:0    minimum:0 maximum:1.0];
        
        // Instrument Definition
        
        AKOscillator *oscillator = [AKOscillator oscillator];
        oscillator.frequency = _carrierFrequency;

        AKRingModulator *leftRingModulator  = [AKRingModulator modulationWithInput:audioSource.leftOutput  carrier:oscillator];
        AKRingModulator *rightRingModualtor = [AKRingModulator modulationWithInput:audioSource.rightOutput carrier:oscillator];
        
        AKMix *leftMix = [[AKMix alloc] initWithInput1:audioSource.leftOutput
                                                input2:leftRingModulator
                                               balance:_mix];
        
        AKMix *rightMix = [[AKMix alloc] initWithInput1:audioSource.rightOutput
                                                 input2:rightRingModualtor
                                                balance:_mix];
        
        // Output to global effects processing
        _auxilliaryOutput = [AKStereoAudio globalParameter];
        [self assignOutput:_auxilliaryOutput to:[[AKStereoAudio alloc] initWithLeftAudio:leftMix
                                                                              rightAudio:rightMix]];
        
        // Reset Inputs
        [self resetParameter:audioSource];
    }
    return self;
}

@end
