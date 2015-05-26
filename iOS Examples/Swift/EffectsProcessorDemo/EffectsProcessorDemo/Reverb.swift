//
//  Reverb.swift
//  EffectsProcessorDemo
//
//  Created by Matthew Fecher on 5/23/15.
//  Copyright (c) 2015 audiokit.io. All rights reserved.
//

class Reverb: AKInstrument {

    // Instrument Properties
    var reverbFeedback  = AKInstrumentProperty(value: 0.5, minimum: 0.0, maximum: 1.0)
    var mix  = AKInstrumentProperty(value: 0.0, minimum: 0.0, maximum: 1.0)

    init(audioSource: AKStereoAudio) {
        super.init()

        // Instrument Definition
        let reverb = AKReverb(stereoInput: audioSource)
        reverb.feedback = reverbFeedback
        
        // Mix
        let leftMix = AKMix(input1: audioSource.leftOutput, input2: reverb.leftOutput, balance: mix)
        let rightMix = AKMix(input1: audioSource.rightOutput, input2: reverb.rightOutput, balance: mix)
        
        // AUDIO OUTPUT ========================================================
        let audio = AKAudioOutput(leftAudio: leftMix, rightAudio: rightMix)
        connect(audio)
        
        resetParameter(audioSource)
    }
}
