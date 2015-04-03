//
//  ViewController.m
//  Sequences
//
//  Created by Aurelius Prochazka on 2/13/15.
//  Copyright (c) 2015 AudioKit. All rights reserved.
//

#import "ViewController.h"
#import "SequencesConductor.h"
#import "AKTools.h"

@implementation ViewController
{
    IBOutlet NSTextField *durationValue;
    IBOutlet NSSlider *durationSlider;
    
    SequencesConductor *conductor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
     conductor = [[SequencesConductor alloc] init];
}



- (float)getDuration {
    return [AKTools scaleValueFromSlider:durationSlider minimum:0.05 maximum:0.2];
}

- (IBAction)playPhrase:(id)sender
{
    [conductor playPhraseOfNotesOfDuration:[self getDuration]];
}

- (IBAction)playSequenceOfNoteProperties:(id)sender
{
    [conductor playSequenceOfNotePropertiesOfDuration:[self getDuration]];
}

- (IBAction)playSequenceOfInstrumentProperties:(id)sender
{
    [conductor playSequenceOfInstrumentPropertiesOfDuration:[self getDuration]];
}

- (IBAction)moveDurationSlider:(id)sender
{
    float duration  = [AKTools scaleValueFromSlider:durationSlider minimum:0.05 maximum:0.2];
    [durationValue setStringValue:[NSString stringWithFormat:@"%g", duration]];
}


@end
