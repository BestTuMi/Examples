//
//  SeqInstrument.m
//  AudioKit
//
//  Created by Aurelius Prochazka on 9/18/12.
//  Copyright (c) 2012 Aurelius Prochazka. All rights reserved.
//

#import "SeqInstrument.h"

@implementation SeqInstrument

- (instancetype)init {
    self = [super init];
    if (self) {
        // NOTE BASED CONTROL ==================================================
        SeqInstrumentNote *note = [[SeqInstrumentNote alloc] init];
        
        // INSTRUMENT CONTROL ==================================================
        _modulation = [self createPropertyWithValue:1.0 minimum:0.5 maximum:2.0];
        
        // INSTRUMENT DEFINITION ===============================================
        AKFMOscillator *fmOscillator = [AKFMOscillator oscillator];
        fmOscillator.baseFrequency = note.frequency;
        fmOscillator.carrierMultiplier.value = 2;
        fmOscillator.modulatingMultiplier = _modulation;
        fmOscillator.modulationIndex.value = 15;
        fmOscillator.amplitude.value = 0.2;
        
        // AUDIO OUTPUT ========================================================
        [self setAudioOutput:fmOscillator];
    }
    return self;
}

@end

// -----------------------------------------------------------------------------
#  pragma mark - Sequence Instrument Note
// -----------------------------------------------------------------------------


@implementation SeqInstrumentNote

- (instancetype)init {
    self = [super init];
    if (self) {
        _frequency = [self createPropertyWithValue:220 minimum:110 maximum:880];
    }
    return self;
}

- (instancetype)initWithFrequency:(float)frequency {
    self = [self init];
    if (self) {
        _frequency.value = frequency;
    }
    return self;
}

@end