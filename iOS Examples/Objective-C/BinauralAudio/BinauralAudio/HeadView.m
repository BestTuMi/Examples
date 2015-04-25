//
//  HeadView.m
//  DetourFX
//
//  Created by Aurelius Prochazka on 4/16/15.
//  Copyright (c) 2015 Aurelius Prochazka. All rights reserved.
//

#import "HeadView.h"
#import "StyleKit.h"

@implementation HeadView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [StyleKit drawHeadAndSpeakerWithAzimuth:self.azimuth];
}

@end
