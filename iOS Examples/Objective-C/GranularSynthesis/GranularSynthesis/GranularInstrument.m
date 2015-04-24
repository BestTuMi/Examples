//
//  GranularInstrument.m
//  GranularSynthTest
//
//  Created by Nicholas Arner on 9/2/14.
//  Copyright (c) 2014 Aurelius Prochazka. All rights reserved.
//

#import "GranularInstrument.h"
#import "AKFoundation.h"

@implementation GranularInstrument

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        // INPUTS AND CONTROLS =================================================
        _mix                   = [self createPropertyWithValue:0.5 minimum:0    maximum:1];
        _frequency             = [self createPropertyWithValue:0.2 minimum:0.01 maximum:10];
        _duration              = [self createPropertyWithValue:10  minimum:0.1  maximum:20];
        _density               = [self createPropertyWithValue:1   minimum:0.1  maximum:2];
        _frequencyVariation    = [self createPropertyWithValue:10  minimum:0.1  maximum:20];
        _frequencyDistribution = [self createPropertyWithValue:10  minimum:0.1  maximum:20];

        // INSTRUMENT DEFINITION ===============================================
        
        
        NSString *file = [AKManager pathToSoundFile:@"PianoBassDrumLoop" ofType:@"wav"];
        AKSoundFileTable *soundFile;
        soundFile = [[AKSoundFileTable alloc] initWithFilename:file size:16384];
        
        AKGranularSynthesizer *synth;
        synth = [[AKGranularSynthesizer alloc] initWithGrainWaveform:soundFile
                                                           frequency:_frequency];
        synth.duration = _duration;
        synth.density = _density;
        synth.frequencyVariation = _frequencyVariation;
        synth.frequencyVariationDistribution = _frequencyDistribution;
        
        NSString *file2 = [AKManager pathToSoundFile:@"808loop" ofType:@"wav"];
        AKSoundFileTable *soundFile2;
        soundFile2 = [[AKSoundFileTable alloc] initWithFilename:file2 size:16384];
        
        AKGranularSynthesizer *synth2;
        synth2 = [[AKGranularSynthesizer alloc] initWithGrainWaveform:soundFile2
                                                           frequency:_frequency];
        synth2.duration = _duration;
        synth2.density = _density;
        synth2.frequencyVariation = _frequencyVariation;
        synth2.frequencyVariationDistribution = _frequencyDistribution;
        
        AKMix *mixer = [[AKMix alloc] initWithInput1:synth
                                              input2:synth2
                                             balance:_mix];
        
        [self setAudioOutput:[mixer scaledBy:akp(0.5)]];
        
    }
    return self;
}

@end
