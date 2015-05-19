//
//  SeqInstrument.swift
//  AudioKit Example
//
//  Created by Matthew Fecher on 5/17/15.
//  Copyright (c) 2015 audiokit.io. All rights reserved.
//

class SeqInstrument: AKInstrument {
    
    // INSTRUMENT PROPERTIES ==================================================
    var modulation = AKInstrumentProperty(value: 1.0, minimum: 0.5, maximum: 2.0)
    
    override init() {
        super.init()
        
        // NOTE BASED CONTROL ==================================================
        let note = SeqInstrumentNote()
        
        // INSTRUMENT CONTROL ==================================================
        addProperty(modulation)
        
        // INSTRUMENT DEFINITION ===============================================
        let fmOscillator = AKFMOscillator()
        fmOscillator.baseFrequency = note.frequency
        fmOscillator.carrierMultiplier.value = 2
        fmOscillator.modulatingMultiplier = modulation
        fmOscillator.modulationIndex.value = 15
        fmOscillator.amplitude.value = 0.2
        
        // AUDIO OUTPUT ========================================================
        setAudioOutput(fmOscillator)
    }
}

// -----------------------------------------------------------------------------
// MARK: - Sequence Instrument Note
// -----------------------------------------------------------------------------

class SeqInstrumentNote: AKNote {
    
    // Note Properties
    var frequency = AKNoteProperty(value: 220, minimum: 110, maximum: 880)
    
    override init() {
        super.init()
        addProperty(frequency)
    }
    
    convenience init(frequency: Float) {
        self.init()
        self.frequency.value = frequency
    }
}