//
//  ViewController.m
//  ContinuousControl
//
//  Created by Aurelius Prochazka on 6/30/14.
//  Copyright (c) 2014 Aurelius Prochazka. All rights reserved.
//

#import "ViewController.h"
#import "AKAudioOutputPlot.h"

#import "AKTools.h"
#import "ContinuousControlConductor.h"

@implementation ViewController
{
    IBOutlet AKPropertySlider *amplitudeSlider;
    IBOutlet AKPropertySlider *modulationSlider;
    IBOutlet AKPropertySlider *modIndexSlider;
    IBOutlet AKPropertyLabel *amplitudeLabel;
    IBOutlet AKPropertyLabel *modulationLabel;
    IBOutlet AKPropertyLabel *modIndexLabel;
    IBOutlet AKAudioOutputPlot *plot;
    
    ContinuousControlConductor *conductor;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    conductor = [[ContinuousControlConductor alloc] init];
    
    amplitudeSlider.property  = amplitudeLabel.property  = conductor.tweakableInstrument.amplitude;
    modulationSlider.property = modulationLabel.property = conductor.tweakableInstrument.modulation;
    modIndexSlider.property   = modIndexLabel.property   = conductor.tweakableInstrument.modIndex;
    
    [AKManager addBinding:plot];
}

- (void)viewDidDisappear:(BOOL)animated {
    [conductor stop];
}

- (IBAction)runInstrument:(id)sender {
    [conductor start];
}

- (IBAction)stopInstrument:(id)sender {
    [conductor stop];
}

@end
