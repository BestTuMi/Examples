//
//  Conductor.swift
//  SwiftKeyboard
//
//  Created by Aurelius Prochazka on 11/28/14.
//  Copyright (c) 2014 AudioKit. All rights reserved.
//

import AudioKit

class Conductor {

    let audiokit = AKManager.sharedInstance
    var toneGenerator = AKOscillator()
    var poly: AKMidiInstrument
    var delay: AKDelay
    var reverb: AKReverb

    init() {
        poly = AKMidiInstrument(osc: toneGenerator, numVoicesInit: 13)

        delay = AKDelay(poly)
        delay.time = 0
        delay.feedback = 20
        
        reverb = AKReverb(delay)
        reverb.loadFactoryPreset(.Cathedral)
        reverb.dryWetMix = 0
        
        audiokit.audioOutput = reverb
        audiokit.start()
    }

    func play(key: Int) {
        let note = key + 60
        poly.startNote(UInt8(note), withVelocity: 10, onChannel: 0)
    }

    func release(key: Int) {
        let note = key + 60
        poly.stopNote(UInt8(note), onChannel: 0)
    }

    func setReverbFeedbackLevel(feedbackLevel: Double) {
        reverb.dryWetMix = feedbackLevel * 100
    }
    
    func setToneColor(toneColor: Float) {
        delay.time = Double(toneColor)
    }
}
