//
//  ViewController.m
//  Convolution
//
//  Created by Aurelius Prochazka on 2/16/15.
//  Copyright (c) 2015 Aurelius Prochazka. All rights reserved.
//

#import "ViewController.h"
#import "AKFoundation.h"
#import "AKTools.h"
#import "ConvolutionInstrument.h"

@implementation ViewController
{
    ConvolutionInstrument *conv;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    conv = [[ConvolutionInstrument alloc] init];
    [AKOrchestra addInstrument:conv];
    [AKOrchestra start];
}

- (IBAction)start:(id)sender {
    [conv play];
}

- (IBAction)stop:(id)sender {
    [conv stop];
}

- (IBAction)changeDryWet:(id)sender {
    [AKTools setProperty:conv.dryWetBalance withSlider:(NSSlider *)sender];
}
- (IBAction)changeDishWell:(id)sender {
    [AKTools setProperty:conv.dishWellBalance withSlider:(NSSlider *)sender];
}
@end

