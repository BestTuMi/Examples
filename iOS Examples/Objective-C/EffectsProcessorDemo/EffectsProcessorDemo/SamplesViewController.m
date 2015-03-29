//
//  SamplesViewController.m
//  EffectsProcessorDemo
//
//  Created by Nicholas Arner on 1/30/15.
//  Copyright (c) 2015 AudioKit. All rights reserved.
//

#import "SamplesViewController.h"
#import "SharedStore.h"
#import "AKFoundation.h"


@interface SamplesViewController () {
    float startTime;
}

@end

@implementation SamplesViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    startTime = 0;
}

- (void)playFile:(NSString *)file{
    SharedStore *global = [SharedStore globals];

    [[AKManager sharedManager] stop];
    [AKOrchestra reset];
    
    // Create the orchestra and instruments
    global.audioFilePlayer = [[AudioFilePlayer alloc] initWithFilename:file];
    global.variableDelay = [[VariableDelay alloc] initWithAudioSource:global.audioFilePlayer.auxilliaryOutput];
    global.moogLadder = [[MoogLadder alloc] initWithAudioSource:global.variableDelay.auxilliaryOutput];
    global.reverb = [[Reverb alloc] initWithAudioSource:global.moogLadder.auxilliaryOutput];

    [AKOrchestra addInstrument:global.audioFilePlayer];
    [AKOrchestra addInstrument:global.variableDelay];
    [AKOrchestra addInstrument:global.moogLadder];
    [AKOrchestra addInstrument:global.reverb];
    
    [[AKManager sharedManager] setIsLogging:YES];
    
    Playback *playback = [[Playback alloc] initWithStartTime:startTime];
    [global.variableDelay play];
    [global.moogLadder play];
    [global.reverb play];
    [global.audioFilePlayer playNote:playback];
    
}


- (IBAction)playFirstSample:(id)sender {
    NSString *file = [[NSBundle mainBundle] pathForResource:@"PianoBassDrumLoop" ofType:@"wav"];
    [self playFile:file];
}



- (IBAction)playSecondSample:(id)sender {
    NSString *file = [[NSBundle mainBundle] pathForResource:@"808loop" ofType:@"wav"];
    [self playFile:file];
}

- (IBAction)stop:(id)sender {
    SharedStore *global = [SharedStore globals];
    startTime += global.audioFilePlayer.filePosition.value;
    [global.audioFilePlayer stop];
}



@end
