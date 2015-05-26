//
//  VariableDelay.swift
//  EffectsProcessorDemo
//
//  Created by Matthew Fecher on 5/23/15.
//  Copyright (c) 2015 audiokit.io. All rights reserved.
//

class VariableDelay: AKInstrument {

    // Instrument Properties
    var delayTime = AKInstrumentProperty(value: 0.5, minimum: 0.0, maximum: 1.0)
    var mix = AKInstrumentProperty(value: 0.0, minimum: 0.0, maximum: 0.5)
    
    // Auxilliary Outputs
    var auxilliaryOutput = AKStereoAudio()
    
    init(audioSource: AKStereoAudio) {
        super.init()
        
        // Instrument Definition
        let leftDelay = AKVariableDelay(input: audioSource.leftOutput)
        leftDelay.delayTime = delayTime
        connect(leftDelay)
        
        let rightDelay = AKVariableDelay(input: audioSource.rightOutput)
        rightDelay.delayTime = delayTime
        connect(rightDelay)
        
        // Mix
        let leftMix = AKMix(input1: audioSource.leftOutput, input2: leftDelay, balance: mix)
        let rightMix = AKMix(input1: audioSource.rightOutput, input2: rightDelay, balance: mix)
        let stereoAudioMix = AKStereoAudio(leftAudio: leftMix, rightAudio: rightMix)
        
        // Output to global effects processing
        auxilliaryOutput = AKStereoAudio.globalParameter()
        assignOutput(auxilliaryOutput, to: stereoAudioMix )
        
        // Reset Inputs
        resetParameter(audioSource)
    }
}
