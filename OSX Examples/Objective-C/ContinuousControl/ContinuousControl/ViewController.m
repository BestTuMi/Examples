//
//  ViewController.m
//  ContinuousControl
//
//  Created by Aurelius Prochazka on 2/13/15.
//  Copyright (c) 2015 AudioKit. All rights reserved.
//

#import "ViewController.h"
#import "AKTools.h"
#import "ContinuousControlConductor.h"
@interface ViewController ()

@end

@implementation ViewController
{
    IBOutlet NSSlider *amplitudeSlider;
    IBOutlet NSSlider *modulationSlider;
    IBOutlet NSSlider *modIndexSlider;
    IBOutlet NSTextField *amplitudeLabel;
    IBOutlet NSTextField *modulationLabel;
    IBOutlet NSTextField *modIndexLabel;
    
    ContinuousControlConductor *conductor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    conductor = [[ContinuousControlConductor alloc] init];
    
    [AKTools setTextField:amplitudeLabel  withProperty:conductor.tweakableInstrument.amplitude];
    [AKTools setTextField:modulationLabel withProperty:conductor.tweakableInstrument.modulation];
    [AKTools setTextField:modIndexLabel   withProperty:conductor.tweakableInstrument.modIndex];
    
    [AKTools setSlider:amplitudeSlider  withProperty:conductor.tweakableInstrument.amplitude];
    [AKTools setSlider:modulationSlider withProperty:conductor.tweakableInstrument.modulation];
    [AKTools setSlider:modIndexSlider   withProperty:conductor.tweakableInstrument.modIndex];
    
    [conductor.tweakableInstrument.modIndex addObserver:self
                                             forKeyPath:@"value"
                                                options:NSKeyValueObservingOptionNew
                                                context:Nil];
}

- (IBAction)runInstrument:(id)sender
{
    [conductor start];
}

- (IBAction)stopInstrument:(id)sender
{
    [conductor stop];
}

- (IBAction)scaleAmplitude:(id)sender
{
    [AKTools setProperty:conductor.tweakableInstrument.amplitude withSlider:(NSSlider *)sender];
    [AKTools setTextField:amplitudeLabel withProperty:conductor.tweakableInstrument.amplitude];
}

- (IBAction)scaleModulation:(id)sender
{
    [AKTools setProperty:conductor.tweakableInstrument.modulation withSlider:(NSSlider *)sender];
    [AKTools setTextField:modulationLabel withProperty:conductor.tweakableInstrument.modulation];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"value"]) {
        [AKTools setSlider:modIndexSlider    withProperty:conductor.tweakableInstrument.modIndex];
        [AKTools setTextField:modIndexLabel  withProperty:conductor.tweakableInstrument.modIndex];
    } else {
        [NSException raise:@"Unexpected Keypath" format:@"%@", keyPath];
    }
    
}

@end
