//
//  ViewController.m
//  PlayAudioFile
//
//  Created by Aurelius Prochazka on 2/13/15.
//  Copyright (c) 2015 AudioKit. All rights reserved.
//

#import "ViewController.h"
#import "AKFoundation.h"
#import "AudioFilePlayer.h"

@implementation ViewController
{
    AudioFilePlayer *audioFilePlayer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    // Create the orchestra and instruments
    audioFilePlayer = [[AudioFilePlayer alloc] init];
    [AKOrchestra addInstrument:audioFilePlayer];
}

- (IBAction)touchPlayButton:(id)sender
{
    AudioFilePlayerNote *note = [[AudioFilePlayerNote alloc] init];
    [note.speed randomize];
    note.duration.value = 4.0; //seconds maximum
    [audioFilePlayer playNote:note];
}

@end
