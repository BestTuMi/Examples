//
//  AudioFilePlayer.m
//  AudioKit Example
//
//  Created by Aurelius Prochazka on 6/16/12.
//  Copyright (c) 2012 Aurelius Prochazka. All rights reserved.
//

#import "AudioFilePlayer.h"

@implementation AudioFilePlayer

- (instancetype)init {
    self = [super init];
    if (self) {
        
        // NOTE BASED CONTROL ==================================================
        AudioFilePlayerNote *note = [[AudioFilePlayerNote alloc] init];
        
        // INSTRUMENT DEFINITION ===============================================
        NSString *file = [[NSBundle mainBundle] pathForResource:@"blaster" ofType:@"aiff"];
        AKSoundFileTable *fileTable = [[AKSoundFileTable alloc] initWithFilename:file];
        
        AKMonoSoundFileLooper *looper;
        looper = [AKMonoSoundFileLooper looperWithSoundFile:fileTable];
        looper.frequencyRatio = note.speed;
        looper.loopMode = [AKMonoSoundFileLooper loopPlaysOnce];
        
        AKReverb *reverb;
        reverb = [AKReverb reverbWithInput:looper];
        reverb.feedback.value = 0.85;
        
        [self setStereoAudioOutput:reverb];
    }
    return self;
}

@end

// -----------------------------------------------------------------------------
#  pragma mark - Instrument Note
// -----------------------------------------------------------------------------

@implementation AudioFilePlayerNote

- (instancetype)init;
{
    self = [super init];
    if(self) {
        _speed = [self createPropertyWithValue:1.0 minimum:0.2 maximum:2.0];
    }
    return self;
}
- (instancetype)initWithSpeed:(float)speed;
{
    self = [self init];
    if(self) {
        self.speed.value = speed;
    }
    return self;
}

@end
