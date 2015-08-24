//
//  ViewController.m
//  Convolution
//
//  Created by Aurelius Prochazka on 6/30/14.
//  Copyright (c) 2014 Aurelius Prochazka. All rights reserved.
//

#import "ViewController.h"
#import "AKFoundation.h"
#import "ConvolutionInstrument.h"
#import "AKAudioAnalyzer.h"

#import "AKAudioOutputPlot.h"

@implementation ViewController
{
    ConvolutionInstrument *conv;

    IBOutlet AKPropertySlider *dryWetSlider;
    IBOutlet AKPropertySlider *dishStairwellSlider;
    IBOutlet AKAudioOutputPlot *plot;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    conv = [[ConvolutionInstrument alloc] init];
    [AKOrchestra addInstrument:conv];
    
    AKAudioAnalyzer *analyzer = [[AKAudioAnalyzer alloc] initWithInput:conv.auxilliaryOutput];
    [AKOrchestra addInstrument:analyzer];
    
    [analyzer play];
    
    dryWetSlider.property = conv.dryWetBalance;
    dishStairwellSlider.property = conv.dishWellBalance;
    
    [AKManager addBinding:plot];
}

- (IBAction)start:(id)sender {
    [conv play];
}

- (IBAction)stop:(id)sender {
    [conv stop];
}


@end
