//
//  MoogLadderViewController.h
//  EffectsProcessorDemo
//
//  Created by Aurelius Prochazka on 1/29/15.
//  Copyright (c) 2015 Aurelius Prochazka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoogLadderViewController : UIViewController
@property (strong, nonatomic) IBOutlet UISlider *cutoffFrequencySlider;
@property (strong, nonatomic) IBOutlet UISlider *resonanceSlider;
@property (strong, nonatomic) IBOutlet UISlider *mixSlider;

@end
