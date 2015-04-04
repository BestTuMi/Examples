//
//  ViewController.m
//  ContinuousControl
//
//  Created by Aurelius Prochazka on 2/13/15.
//  Copyright (c) 2015 AudioKit. All rights reserved.
//

#import "ViewController.h"
#import "AKTools.h"
#import "AKPropertySlider.h"
#import "AKPropertyLabel.h"
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
    // Do view setup here.
    
    conductor = [[ContinuousControlConductor alloc] init];
    
    amplitudeLabel.property  = conductor.tweakableInstrument.amplitude;
    modulationLabel.property = conductor.tweakableInstrument.modulation;
    modIndexLabel.property   = conductor.tweakableInstrument.modIndex;
    
    amplitudeSlider.property  = conductor.tweakableInstrument.amplitude;
    modulationSlider.property = conductor.tweakableInstrument.modulation;
    modIndexSlider.property   = conductor.tweakableInstrument.modIndex;
    
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
