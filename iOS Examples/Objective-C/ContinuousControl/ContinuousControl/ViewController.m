//
//  ViewController.m
//  ContinuousControl
//
//  Created by Aurelius Prochazka on 6/30/14.
//  Copyright (c) 2014 Aurelius Prochazka. All rights reserved.
//

#import "ViewController.h"
#import "AKPropertySlider.h"
#import "AKPropertyLabel.h"
#import "AKAudioOutputPlot.h"

#import "AKTools.h"
#import "ContinuousControlConductor.h"

@implementation ViewController
{
    IBOutlet AKPropertySlider *amplitudeSlider;
    IBOutlet AKPropertySlider *modulationSlider;
    IBOutlet UISlider *modIndexSlider;
    IBOutlet AKPropertyLabel *amplitudeLabel;
    IBOutlet AKPropertyLabel *modulationLabel;
    IBOutlet UILabel *modIndexLabel;
    IBOutlet AKAudioOutputPlot *plot;
    
    ContinuousControlConductor *conductor;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    conductor = [[ContinuousControlConductor alloc] init];
    amplitudeSlider.property = conductor.tweakableInstrument.amplitude;
    amplitudeLabel.property  = conductor.tweakableInstrument.amplitude;
    
    modulationSlider.property = conductor.tweakableInstrument.modulation;
    modulationLabel.property  = conductor.tweakableInstrument.modulation;
    
    [conductor.tweakableInstrument.modIndex addObserver:self
                                    forKeyPath:@"value"
                                       options:NSKeyValueObservingOptionNew
                                       context:Nil];
    
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

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"value"]) {
        [AKTools setSlider:modIndexSlider withProperty:conductor.tweakableInstrument.modIndex];
        [AKTools setLabel:modIndexLabel   withProperty:conductor.tweakableInstrument.modIndex];
    } else {
        [NSException raise:@"Unexpected Keypath" format:@"%@", keyPath];
    }
    
}

@end
