//
//  ConvolutionInstrument.m
//  AudioKit Example
//
//  Created by Aurelius Prochazka on 6/27/12.
//  Copyright (c) 2012 Aurelius Prochazka. All rights reserved.
//

#import "ConvolutionInstrument.h"

@implementation ConvolutionInstrument

- (instancetype)init
{
    self = [super init];
    if (self) {

        // INPUTS AND CONTROLS =================================================
        _dishWellBalance = [self createPropertyWithValue:0 minimum:0 maximum:1.0];
        _dryWetBalance   = [self createPropertyWithValue:0 minimum:0 maximum:0.1];

        // INSTRUMENT DEFINITION ===============================================

        NSString *file = [AKManager pathToSoundFile:@"808loop" ofType:@"wav"];
        AKFileInput *loop = [[AKFileInput alloc] initWithFilename:file];
        [loop setLoop:YES];

        NSString *dish = [[NSBundle mainBundle] pathForResource:@"dish" ofType:@"wav"];
        NSString *well = [[NSBundle mainBundle] pathForResource:@"Stairwell" ofType:@"wav"];

        AKConvolution *dishConv;
        dishConv  = [[AKConvolution alloc] initWithInput:loop.leftOutput
                                 impulseResponseFilename:dish];


        AKConvolution *wellConv;
        wellConv  = [[AKConvolution alloc] initWithInput:loop.rightOutput
                                 impulseResponseFilename:well];


        AKMix *balance;
        balance = [[AKMix alloc] initWithInput1:dishConv
                                         input2:wellConv
                                        balance:_dishWellBalance];


        AKMix *dryWet;
        dryWet = [[AKMix alloc] initWithInput1:loop.leftOutput
                                        input2:balance
                                       balance:_dryWetBalance];

        // AUDIO OUTPUT ========================================================
        [self setAudioOutput:dryWet];

        // EXTERNAL OUTPUTS ====================================================
        // After your instrument is set up, define outputs available to others
        _auxilliaryOutput = [AKAudio globalParameter];
        [self assignOutput:_auxilliaryOutput to:dryWet];

    }
    return self;
}

@end
