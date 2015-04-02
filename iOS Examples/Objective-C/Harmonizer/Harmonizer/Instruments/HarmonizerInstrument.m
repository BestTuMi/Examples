//
//  HarmonizerInstrument.m
//  Harmonizer
//
//  Created by Aurelius Prochazka on 7/6/14.
//  Copyright (c) 2014 Aurelius Prochazka. All rights reserved.
//

#import "HarmonizerInstrument.h"
#import "AKFoundation.h"

@implementation HarmonizerInstrument

- (instancetype)init {
    self = [super init];
    if (self) {
        AKAudioInput *microphone = [[AKAudioInput alloc] init];
        
        AKFFT *microphoneFFT;
        microphoneFFT = [[AKFFT alloc] initWithInput:microphone
                                             fftSize:akpi(2048)
                                             overlap:akpi(256)
                                          windowType:[AKFFT hannWindow]
                                    windowFilterSize:akpi(2048)];
        
        AKScaledFFT *scaledFFT;
        scaledFFT = [[AKScaledFFT alloc] initWithSignal:microphoneFFT
                                         frequencyRatio:akp(2.0)
                                    formantRetainMethod:[AKScaledFFT lifteredCepstrumFormantRetainMethod]
                                         amplitudeRatio:akp(2.0)
                                   cepstrumCoefficients:nil];
        
        AKMixedFFT *mixedFFT = [[AKMixedFFT alloc] initWithSignal1:microphoneFFT signal2:scaledFFT];
        
        AKResynthesizedAudio *audioOutput = [[AKResynthesizedAudio alloc] initWithSignal:mixedFFT];
        
        [self setAudioOutput:audioOutput];
    }
    return self;
}

@end
