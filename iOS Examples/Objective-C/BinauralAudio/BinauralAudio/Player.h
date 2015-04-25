//
//  Player.h
//  DetourFX
//
//  Created by Aurelius Prochazka on 4/13/15.
//  Copyright (c) 2015 Aurelius Prochazka. All rights reserved.
//

#import "AKFoundation.h"

@interface Player : AKInstrument

// Instrument Properties
@property AKInstrumentProperty *azimuth;
@property AKInstrumentProperty *elevation;
@property AKInstrumentProperty *reverbFeedback;
@property AKInstrumentProperty *reverbLevel;

@end
