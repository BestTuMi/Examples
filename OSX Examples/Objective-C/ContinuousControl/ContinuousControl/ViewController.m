//
//  ViewController.m
//  ContinuousControl
//
//  Created by Aurelius Prochazka on 2/13/15.
//  Copyright (c) 2015 Aurelius Prochazka. All rights reserved.
//

#import "ViewController.h"
#import "AKTools.h"
#import "ContinuousControlConductor.h"

@interface ViewController ()

@end

@implementation ViewController
{
    IBOutlet AKPropertySlider *amplitudeSlider;
    IBOutlet AKPropertySlider *modulationSlider;
    IBOutlet AKPropertySlider *modIndexSlider;
    IBOutlet AKPropertyLabel *amplitudeLabel;
    IBOutlet AKPropertyLabel *modulationLabel;
    IBOutlet AKPropertyLabel *modIndexLabel;

    ContinuousControlConductor *conductor;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    conductor = [[ContinuousControlConductor alloc] init];

    amplitudeSlider.property  = amplitudeLabel.property  = conductor.tweakableInstrument.amplitude;
    modulationSlider.property = modulationLabel.property = conductor.tweakableInstrument.modulation;
    modIndexSlider.property   = modIndexLabel.property   = conductor.tweakableInstrument.modIndex;

}

- (IBAction)runInstrument:(id)sender
{
    [conductor start];
}

- (IBAction)stopInstrument:(id)sender
{
    [conductor stop];
}

@end
