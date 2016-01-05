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
//    var envelope: AKAmplitudeEnvelope
    var delay: AKDelay
    var reverb: AKReverb
    var currentNotes = [Double](count: 13, repeatedValue: 0)
    let frequencies = [523.25, 554.37, 587.33, 622.25, 659.26, 698.46, 739.99, 783.99, 830.61, 880, 932.33, 987.77, 1046.5]

    init() {
        poly = AKMidiInstrument(osc: toneGenerator, numVoicesInit: 13)
        
//        envelope = AKAmplitudeEnvelope(poly)
        delay = AKDelay(poly)
        delay.time = 0
        delay.feedback = 20
        
        reverb = AKReverb(delay)
        reverb.loadFactoryPreset(.Cathedral)
        reverb.dryWetMix = 0
        
        audiokit.audioOutput = reverb
        audiokit.start()
//        toneGenerator.start()
    }

    func play(key: Int) {
        let note = key + 60
        let frequency = frequencies[key]
        poly.startNote(UInt8(note), withVelocity: 10, onChannel: 0)
        toneGenerator.frequency = frequency
//        envelope.start()
//        note.frequency.value = frequency
//        toneGenerator.playNote(note)
//        currentNotes[key]=note;
    }

    func release(key: Int) {
        let note = key + 60
        poly.stopNote(UInt8(note), onChannel: 0)
//        envelope.stop()
//        let noteToRelease = currentNotes[key]
//        noteToRelease.stop()
    }

    func setReverbFeedbackLevel(feedbackLevel: Double) {
        reverb.dryWetMix = feedbackLevel * 100
    }
    func setToneColor(toneColor: Float) {
        delay.time = Double(toneColor)
    }
}
