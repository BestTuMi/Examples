//
//  ViewController.swift
//  SwiftFMOscillator
//
//  Created by Aurelius Prochazka on 7/5/14.
//  Copyright (c) 2014 Aurelius Prochazka. All rights reserved.
//

import AudioKit

class ViewController: UIViewController {
    
    let audiokit = AKManager.sharedInstance
    
    var fmSynth = AKFMOscillator(table: AKTable(.Sine), baseFrequency: 44, carrierMultiplier: 1, modulatingMultiplier: 1, modulationIndex: 15, amplitude: 0.2)
    
    @IBOutlet weak var toggleSwitchClicked: UISwitch!
    
    @IBOutlet var frequencyLabel             : UILabel!
    @IBOutlet var amplitudeLabel             : UILabel!
    @IBOutlet var carrierMultiplierLabel     : UILabel!
    @IBOutlet var modulatingMultiplierLabel  : UILabel!
    @IBOutlet var modulationIndexLabel       : UILabel!
    
    @IBOutlet var frequencySlider            : UISlider!
    @IBOutlet var amplitudeSlider            : UISlider!
    @IBOutlet var carrierMultiplierSlider    : UISlider!
    @IBOutlet var modulatingMultiplierSlider : UISlider!
    @IBOutlet var modulationIndexSlider      : UISlider!

//    let fmSynth = FMSynth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audiokit.audioOutput = fmSynth
        audiokit.start()
     
        frequencySlider.addTarget(self, action: Selector("updateFrequency"), forControlEvents: .ValueChanged)
        amplitudeSlider.addTarget(self, action: Selector("updateAmplitude"), forControlEvents: .ValueChanged)
        carrierMultiplierSlider.addTarget(self, action: Selector("updateCarrierMultiplier"), forControlEvents: .ValueChanged)
        modulatingMultiplierSlider.addTarget(self, action: Selector("updateModulationMultiplier"), forControlEvents: .ValueChanged)
        modulationIndexSlider.addTarget(self, action: Selector("updateModulationIndex"), forControlEvents: .ValueChanged)
    }
    
    @IBAction func updateFrequency() {
        fmSynth.baseFrequency = Double(frequencySlider.value)
        frequencyLabel.text = "\(String(format: "%0.1f", fmSynth.baseFrequency))"
    }

    @IBAction func updateAmplitude() {
        fmSynth.amplitude = Double(amplitudeSlider.value)
        amplitudeLabel.text = "\(String(format: "%0.2f", fmSynth.amplitude))"
    }

    @IBAction func updateCarrierMultiplier() {
        fmSynth.carrierMultiplier = Double(carrierMultiplierSlider.value)
        carrierMultiplierLabel.text = "\(String(format: "%0.2f", fmSynth.carrierMultiplier))"
    }

    @IBAction func updateModulationMultiplier() {
        fmSynth.modulatingMultiplier = Double(modulatingMultiplierSlider.value)
        modulatingMultiplierLabel.text = "\(String(format: "%0.2f", fmSynth.modulatingMultiplier))"
    }

    @IBAction func updateModulationIndex() {
        fmSynth.modulationIndex = Double(modulationIndexSlider.value)
        modulationIndexLabel.text = "\(String(format: "%0.1f", fmSynth.modulationIndex))"
    }

    
    @IBAction func toggleFMsynth(sender: AnyObject) {
        toggleSwitchClicked.on ?  fmSynth.play() : fmSynth.stop()
    }
}