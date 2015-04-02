//
//  ViewController.swift
//  SwiftFMOscillator
//
//  Created by Aurelius Prochazka on 7/5/14.
//  Copyright (c) 2014 Aurelius Prochazka. All rights reserved.
//

class ViewController: UIViewController {
    
    @IBOutlet weak var toggleSwitchClicked: UISwitch!
    
    @IBOutlet var frequencyLabel             : AKPropertyLabel!
    @IBOutlet var amplitudeLabel             : AKPropertyLabel!
    @IBOutlet var carrierMultiplierLabel     : AKPropertyLabel!
    @IBOutlet var modulatingMultiplierLabel  : AKPropertyLabel!
    @IBOutlet var modulationIndexLabel       : AKPropertyLabel!
    
    @IBOutlet var frequencySlider            : AKPropertySlider!
    @IBOutlet var amplitudeSlider            : AKPropertySlider!
    @IBOutlet var carrierMultiplierSlider    : AKPropertySlider!
    @IBOutlet var modulatingMultiplierSlider : AKPropertySlider!
    @IBOutlet var modulationIndexSlider      : AKPropertySlider!
    
    let fmSynth = FMSynth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AKOrchestra.addInstrument(fmSynth)
        
        frequencySlider.property            = fmSynth.frequency
        amplitudeSlider.property            = fmSynth.amplitude
        carrierMultiplierSlider.property    = fmSynth.carrierMultiplier
        modulatingMultiplierSlider.property = fmSynth.modulatingMultiplier
        modulationIndexSlider.property      = fmSynth.modulationIndex

        frequencyLabel.property             = fmSynth.frequency
        amplitudeLabel.property             = fmSynth.amplitude
        carrierMultiplierLabel.property     = fmSynth.carrierMultiplier
        modulatingMultiplierLabel.property  = fmSynth.modulatingMultiplier
        modulationIndexLabel.property       = fmSynth.modulationIndex
    }
   
    @IBAction func toggleFMsynth(sender: AnyObject) {
        toggleSwitchClicked.on ?  fmSynth.play() : fmSynth.stop()
    }
}