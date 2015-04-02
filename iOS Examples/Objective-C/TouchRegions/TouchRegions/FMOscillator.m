//
//  FMOscillator.m
//  TouchRegions
//
//  Created by Aurelius Prochazka on 8/7/14.
//  Copyright (c) 2014 Aurelius Prochazka. All rights reserved.
//

#import "FMOscillator.h"

@implementation FMOscillator

- (instancetype)init {
    self = [super init];
    if (self) {
        
        // INSTRUMENT CONTROL ==================================================
        _frequency            = [self createPropertyWithValue:440 minimum:1.0 maximum:880];
        _carrierMultiplier    = [self createPropertyWithValue:1.0 minimum:0.0 maximum:2.0];
        _modulatingMultiplier = [self createPropertyWithValue:1.0 minimum:0.0 maximum:2.0];
        _modulationIndex      = [self createPropertyWithValue:15  minimum:0   maximum:30];
        _amplitude            = [self createPropertyWithValue:0.0 minimum:0   maximum:0.2];
        
        // INSTRUMENT DEFINITION ===============================================
        AKFMOscillator *fmOscillator;
        fmOscillator = [[AKFMOscillator alloc] initWithWaveform:[AKTable standardSineWave]
                                                  baseFrequency:_frequency
                                              carrierMultiplier:_carrierMultiplier
                                           modulatingMultiplier:_modulatingMultiplier
                                                modulationIndex:_modulationIndex
                                                      amplitude:_amplitude];
        
        [self setAudioOutput:fmOscillator];
    }
    return self;
}

@end
