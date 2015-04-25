//
//  Player.m
//  DetourFX
//
//  Created by Aurelius Prochazka on 4/13/15.
//  Copyright (c) 2015 Aurelius Prochazka. All rights reserved.
//

#import "Player.h"

@implementation Player

- (instancetype)init
{
    self = [super init];
    if (self) {
        // Instrument Properties
        _azimuth = [self createPropertyWithValue:0.0 minimum:-180.0 maximum:180.0];
        _elevation = [self createPropertyWithValue:0.0 minimum:-40.0 maximum:90.0];
        _reverbFeedback = [self createPropertyWithValue:0.5 minimum:0.0 maximum:0.99];
        _reverbLevel = [self createPropertyWithValue:0.5 minimum:0.0 maximum:0.99];
        // Instrument Definition
        NSString *file = [AKManager pathToSoundFile:@"PianoBassDrumLoop" ofType:@"wav"];
        AKFileInput *fileIn = [[AKFileInput alloc] initWithFilename:file];
        fileIn.loop = YES;
        
        AKMix *mono = [[AKMix alloc] initMonoAudioFromStereoInput:fileIn];

        AK3DBinauralAudio *binaural = [[AK3DBinauralAudio alloc] initWithInput:mono];
        binaural.azimuth = _azimuth;
        binaural.elevation = _elevation;
        
        AKReverb *reverb = [AKReverb reverbWithStereoInput:binaural];
        reverb.feedback = [_reverbFeedback plus:akp(0.2)];
        
        AKMix *mixL = [[AKMix alloc] initWithInput1:binaural.leftOutput  input2:reverb.leftOutput  balance:_reverbLevel];
        AKMix *mixR = [[AKMix alloc] initWithInput1:binaural.rightOutput input2:reverb.rightOutput balance:_reverbLevel];
        AKStereoAudio *mix = [[AKStereoAudio alloc] initWithLeftAudio:mixL rightAudio:mixR];
        [self setStereoAudioOutput:mix];

    }
    return self;
}
@end
