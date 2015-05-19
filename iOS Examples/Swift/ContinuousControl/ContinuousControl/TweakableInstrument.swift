//
//  TweakableInstrument.swift
//  AudioKit Example
//
//  Created by Matthew Fecher on 5/17/15.
//  Copyright (c) 2015 audiokit.io. All rights reserved.
//

class TweakableInstrument: AKInstrument {

    // INSTRUMENT CONTROLS =====================================================

    var amplitude     = AKInstrumentProperty(value: 0.1, minimum: 0,    maximum: 0.8)
    var frequency     = AKInstrumentProperty(value: 220, minimum: 110,  maximum: 880)
    var modulation    = AKInstrumentProperty(value: 0.5, minimum: 0.25, maximum: 2.2)
    var modIndex      = AKInstrumentProperty(value: 1,   minimum: 0,    maximum: 25)

    // INSTRUMENT DEFINITION ===================================================

    override init() {
        super.init()

        addProperty(amplitude)
        addProperty(frequency)
        addProperty(modulation)
        addProperty(modIndex)

        let fmOscillator = AKFMOscillator()
        fmOscillator.amplitude = amplitude
        fmOscillator.baseFrequency = frequency
        fmOscillator.modulatingMultiplier = modulation
        fmOscillator.modulationIndex = modIndex

        // AUDIO OUTPUT
        setAudioOutput(fmOscillator)
    }
}
