//
//  ViewController.m
//  GranularSynthTest
//
//  Created by Nicholas Arner on 9/2/14.
//  Copyright (c) 2014 Aurelius Prochazka. All rights reserved.
//

#import "ViewController.h"

#import "AKFoundation.h"
#import "GranularInstrument.h"


@interface ViewController ()
{
    GranularInstrument *granularInstrument;
    BOOL isGranularInstrumentPlaying;
}

@property (strong, nonatomic) IBOutlet AKPropertySlider *mixSlider;
@property (strong, nonatomic) IBOutlet AKPropertySlider *frequencySlider;
@property (strong, nonatomic) IBOutlet AKPropertySlider *durationSlider;
@property (strong, nonatomic) IBOutlet AKPropertySlider *densitySlider;
@property (strong, nonatomic) IBOutlet AKPropertySlider *frequencyVariationSlider;
@property (strong, nonatomic) IBOutlet AKPropertySlider *frequencyVariationDistributionSlider;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    granularInstrument = [[GranularInstrument alloc] init];
    [AKOrchestra addInstrument:granularInstrument];

    _mixSlider.property       = granularInstrument.mix;
    _frequencySlider.property = granularInstrument.frequency;
    _durationSlider.property  = granularInstrument.duration;
    _densitySlider.property   = granularInstrument.density;
    _frequencyVariationSlider.property = granularInstrument.frequencyVariation;
    _frequencyVariationDistributionSlider.property = granularInstrument.frequencyDistribution;
}

- (IBAction)toggleGranularInstrument:(id)sender
{
    if (isGranularInstrumentPlaying) {
        [granularInstrument stop];
        isGranularInstrumentPlaying = NO;
    } else {
        [granularInstrument play];
        isGranularInstrumentPlaying = YES;
    }
}


@end
