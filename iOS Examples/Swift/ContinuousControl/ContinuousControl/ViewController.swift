//
//  ViewController.swift
//  ContinuousControl
//
//  Created by Aurelius Prochazka on 6/30/14.
//  Copyright (c) 2014 Aurelius Prochazka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var amplitudeSlider: AKPropertySlider!
    @IBOutlet weak var modulationSlider: AKPropertySlider!
    @IBOutlet weak var modIndexSlider: AKPropertySlider!
    @IBOutlet weak var amplitudeLabel: AKPropertyLabel!
    @IBOutlet weak var modulationLabel: AKPropertyLabel!
    @IBOutlet weak var modIndexLabel: AKPropertyLabel!
    @IBOutlet weak var plot: AKAudioOutputPlot!
    
     // Instance Variables
    var conductor = ContinuousControlConductor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        amplitudeSlider.property = conductor.tweakableInstrument.amplitude
        amplitudeLabel.property  = conductor.tweakableInstrument.amplitude
        
        modulationSlider.property = conductor.tweakableInstrument.modulation
        modulationLabel.property  = conductor.tweakableInstrument.modulation
        
        modIndexSlider.property = conductor.tweakableInstrument.modIndex
        modIndexLabel.property  = conductor.tweakableInstrument.modIndex
        
        AKManager.addBinding(plot)
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        conductor.stop()
    }
    
    
    @IBAction func runInstrument(sender: UIButton) {
        conductor.start()
    }
    
    @IBAction func stopInstrument(sender: UIButton) {
        conductor.stop()
    }

}

