//
//  ConvolutionInstrument.swift
//  SwiftConvolution
//
//  Created by Nicholas Arner on 10/7/14.
//  Copyright (c) 2014 Aurelius Prochazka. All rights reserved.
//

class ConvolutionInstrument: AKInstrument
{
    // INPUTS AND CONTROLS =====================================================
    
    var dishWellBalance = AKInstrumentProperty(value: 0, minimum: 0, maximum: 1.0)
    var dryWetBalance   = AKInstrumentProperty(value: 0, minimum: 0, maximum: 0.1)
    
    // INSTRUMENT DEFINITION ===================================================
    override init() {
        super.init()
        
        let file = AKManager.pathToSoundFile("808loop", ofType: "wav")
        let loop = AKFileInput(filename: file!)
        loop.loop = true;
        
        let dish = String(NSBundle.mainBundle().pathForResource("dish",      ofType: "wav")!)
        let well = String(NSBundle.mainBundle().pathForResource("Stairwell", ofType: "wav")!)
        
        let dishConv = AKConvolution(input: loop.leftOutput,  impulseResponseFilename: dish)
        let wellConv = AKConvolution(input: loop.rightOutput, impulseResponseFilename: well)
        
        let balance = AKMix(input1: dishConv,        input2: wellConv, balance: dishWellBalance)
        let dryWet  = AKMix(input1: loop.leftOutput, input2: balance,  balance: dryWetBalance)
        
        setAudioOutput(dryWet)
    }
}