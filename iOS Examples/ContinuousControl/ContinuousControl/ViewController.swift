//
//  ViewController.swift
//  ContinuousControl
//
//  Created by Aurelius Prochazka on 6/30/14.
//  Copyright (c) 2014 Aurelius Prochazka. All rights reserved.
//

import UIKit
import AudioKit

class ViewController: UIViewController {
    let audiokit = AKManager.sharedInstance
    let fmSynth = AKFMOscillator()
    
    @IBOutlet weak var amplitudeSlider: UISlider!
    @IBOutlet weak var modulationSlider: UISlider!
    @IBOutlet weak var modIndexSlider: UISlider!
    @IBOutlet weak var amplitudeLabel: UILabel!
    @IBOutlet weak var modulationLabel: UILabel!
    @IBOutlet weak var modIndexLabel: UILabel!
    @IBOutlet weak var plot: AKOutputWaveformPlot!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        amplitudeSlider.addTarget(self, action: Selector("updateAmplitude"), forControlEvents: .ValueChanged)
        modulationSlider.addTarget(self, action: Selector("updateModulationMultiplier"), forControlEvents: .ValueChanged)
        modIndexSlider.addTarget(self, action: Selector("updateModulationIndex"), forControlEvents: .ValueChanged)
        
        audiokit.audioOutput = fmSynth
        audiokit.start()
        fmSynth.start()
        
        AKPlaygroundLoop(every: 3) { () -> () in
            self.fmSynth.baseFrequency = random(200,400)
        }
        
        AKPlaygroundLoop(frequency: 5) { () -> () in
            self.fmSynth.modulationIndex = random(0, 1)
            self.modIndexSlider.value = Float(self.fmSynth.modulationIndex)
            self.modIndexLabel.text = "\(String(format: "%0.1f", self.fmSynth.modulationIndex))"
        }
        
    }
    
    @IBAction func updateAmplitude() {
        fmSynth.amplitude = Double(amplitudeSlider.value)
        amplitudeLabel.text = "\(String(format: "%0.2f", fmSynth.amplitude))"
    }
    @IBAction func updateModulationMultiplier() {
        fmSynth.modulatingMultiplier = Double(modulationSlider.value) * 100.0
        modulationLabel.text = "\(String(format: "%0.2f", fmSynth.modulatingMultiplier))"
    }
    
    @IBAction func updateModulationIndex() {
        fmSynth.modulationIndex = Double(modIndexSlider.value)
        modIndexLabel.text = "\(String(format: "%0.1f", fmSynth.modulationIndex))"
    }
    
    override func viewDidDisappear(animated: Bool) {
        fmSynth.stop()
    }
    
    
    @IBAction func runInstrument(sender: UIButton) {
        fmSynth.start()
    }
    
    @IBAction func stopInstrument(sender: UIButton) {
        fmSynth.stop()
    }

}

//        randomizeFrequency = AKEvent(block: {
//            self.tweakableInstrument.frequency.randomize()
//            self.frequencySequence.addEvent(self.randomizeFrequency, afterDuration: 3.0)
//        })
//
//        randomizeModulationIndex = AKEvent(block: {
//            self.tweakableInstrument.modIndex.randomize()
//            self.modulationIndexSequence.addEvent(self.randomizeModulationIndex, afterDuration: 0.2)
//        })
//
//        frequencySequence.addEvent(randomizeFrequency, atTime: 3.0)
//        modulationIndexSequence.addEvent(randomizeModulationIndex, atTime: 0.2)
//
//        AKOrchestra.addInstrument(tweakableInstrument)
