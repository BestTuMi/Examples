//
//  MoogLadder.swift
//  EffectsProcessorDemo
//
//  Created by Matthew Fecher on 5/23/15.
//  Copyright (c) 2015 audiokit.io. All rights reserved.
//

class MoogLadder: AKInstrument {

    // Instrument Properties
    var cutoffFrequency = AKInstrumentProperty(value: 1000, minimum: 0, maximum: 20000)
    var resonance = AKInstrumentProperty(value: 0.5, minimum: 0.0, maximum: 0.99)
    var mix = AKInstrumentProperty(value: 0.0, minimum: 0.0, maximum: 1.0)
    
    // Auxilliary Outputs
    var auxilliaryOutput = AKStereoAudio()
    
    init(audioSource: AKStereoAudio) {
        super.init()
        
        // Instrument Definition
        let leftMoogLadder = AKMoogLadder.filterWithInput(audioSource.leftOutput)
        leftMoogLadder.cutoffFrequency = cutoffFrequency
        leftMoogLadder.resonance = resonance
        connect(leftMoogLadder)
        
        let rightMoogLadder = AKMoogLadder.filterWithInput(audioSource.rightOutput)
        rightMoogLadder.cutoffFrequency = cutoffFrequency
        rightMoogLadder.resonance = resonance
        connect(rightMoogLadder)
        
        // Mix
        let leftMix = AKMix(input1: audioSource.leftOutput, input2: leftMoogLadder, balance: mix)
        let rightMix = AKMix(input1: audioSource.rightOutput, input2: rightMoogLadder, balance: mix)
        let stereoAudioMix = AKStereoAudio(leftAudio: leftMix, rightAudio: rightMix)
        
        // Output to global effects processing
        auxilliaryOutput = AKStereoAudio.globalParameter()
        assignOutput(auxilliaryOutput, to: stereoAudioMix )
        
        // Reset Inputs
        resetParameter(audioSource)
    }
}