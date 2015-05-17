//
//  ContinuousControlConductor.swift
//  ContinuousControl
//
//  Created by Aurelius Prochazka on 8/4/14.
//  Copyright (c) 2015 audiokit.io. All rights reserved.
//

class ContinuousControlConductor {

    // Instance Variables
    let tweakableInstrument = TweakableInstrument()
    
    let frequencySequence = AKSequence()
    let modulationIndexSequence = AKSequence()
    
    var randomizeFrequency: AKEvent!
    var randomizeModulationIndex: AKEvent!
    
    var frequencyTimer: NSTimer!
    var modIndexTimer: NSTimer!

    init() {
        
        randomizeFrequency = AKEvent(block: {
            self.tweakableInstrument.frequency.randomize()
            self.frequencySequence.addEvent(self.randomizeFrequency, afterDuration: 3.0)
        })
        
        randomizeModulationIndex = AKEvent(block: {
            self.tweakableInstrument.modIndex.randomize()
            self.modulationIndexSequence.addEvent(self.randomizeModulationIndex, afterDuration: 0.2)
        })
        
        frequencySequence.addEvent(randomizeFrequency, atTime: 3.0)
        modulationIndexSequence.addEvent(randomizeModulationIndex, atTime: 0.2)
        
        AKOrchestra.addInstrument(tweakableInstrument)
    }
    
    func start() {
        tweakableInstrument.play()
        tweakableInstrument.frequency.randomize()
        frequencySequence.play()
        modulationIndexSequence.play()
    }
    
    func stop() {
        tweakableInstrument.stop()
        frequencySequence.stop()
        modulationIndexSequence.stop()
    }
    
}
