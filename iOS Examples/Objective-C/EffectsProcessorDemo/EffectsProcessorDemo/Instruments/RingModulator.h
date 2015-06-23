//
//  RingModulator.h
//  EffectsProcessorDemo
//
//  Created by Aurelius Prochazka on 6/22/15.
//  Copyright (c) 2015 AudioKit. All rights reserved.
//

#import "AKFoundation.h"

@interface RingModulator : AKInstrument

@property (readonly) AKStereoAudio *auxilliaryOutput;

@property (nonatomic, strong) AKInstrumentProperty *carrierFrequency;
@property (nonatomic, strong) AKInstrumentProperty *mix;

- (instancetype)initWithAudioSource:(AKStereoAudio *)audioSource;

@end
