//
//  ConvolutionInstrument.swift
//  Convolution
//
//  Created by Aurelius Prochazka on 2/16/15.
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
        
        let file = String(NSBundle.mainBundle().pathForResource("808loop", ofType: "wav")!)
        let loop = AKFileInput(filename: file)
        
        let dish = String(NSBundle.mainBundle().pathForResource("dish",      ofType: "wav")!)
        let well = String(NSBundle.mainBundle().pathForResource("Stairwell", ofType: "wav")!)
        
        let dishConv = AKConvolution(input: loop.leftOutput,  impulseResponseFilename: dish)
        let wellConv = AKConvolution(input: loop.rightOutput, impulseResponseFilename: well)

        let balance = AKMix(input1: dishConv,        input2: wellConv, balance: dishWellBalance)
        let dryWet  = AKMix(input1: loop.leftOutput, input2: balance,  balance: dryWetBalance)
    
        setAudioOutput(dryWet)
    }
}