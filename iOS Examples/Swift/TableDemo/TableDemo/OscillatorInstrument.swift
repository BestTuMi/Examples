//
//  OscillatorInstrument.swift
//  TableDemo
//
//  Created by Aurelius Prochazka on 4/17/15.
//  Copyright (c) 2015 Aurelius Prochazka. All rights reserved.
//

class OscillatorInstrument: AKInstrument {
    
    // MARK: - Instrument Controls
    
    var amplitude = AKInstrumentProperty(value: 0.25, minimum: 0.0, maximum: 1.0)
    var frequency = AKInstrumentProperty(value: 861, minimum: 0, maximum: 4000)
    let oscillator = AKOscillator()
    
    // MARK: - Instrument Definition
    
    override init() {
        super.init()
        
        addProperty(amplitude)
        addProperty(frequency)
        
        oscillator.amplitude = amplitude
        oscillator.frequency = frequency
     
        setAudioOutput(oscillator)
    }
   
}
