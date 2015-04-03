//
//  TweakableInstrument.m
//  AudioKit Example
//
//  Created by Aurelius Prochazka on 6/30/14.
//  Copyright (c) 2014 Aurelius Prochazka. All rights reserved.
//

#import "TweakableInstrument.h"

@implementation TweakableInstrument

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        // INPUTS AND CONTROLS =================================================
        _amplitude  = [self createPropertyWithValue:0.1 minimum:0.0  maximum:0.8];
        _frequency  = [self createPropertyWithValue:220 minimum:110  maximum:880];
        _modulation = [self createPropertyWithValue:0.5 minimum:0.25 maximum:2.2];
        _modIndex   = [self createPropertyWithValue:1.0 minimum:0.0  maximum:25];
        
        
        // INSTRUMENT DEFINITION ===============================================        
        AKFMOscillator *fmOscillator = [AKFMOscillator oscillator];
        fmOscillator.baseFrequency = _frequency;
        fmOscillator.modulatingMultiplier = _modulation;
        fmOscillator.modulationIndex = _modIndex;
        fmOscillator.amplitude = _amplitude;
        
        
        // AUDIO OUTPUT ========================================================
        [self setAudioOutput:fmOscillator];
        
    }
    
    return self;
}

@end
