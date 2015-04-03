//
//  ViewController.swift
//  GranularSynthesis
//
//  Created by Aurelius Prochazka on 2/16/15.
//  Copyright (c) 2015 Aurelius Prochazka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var toggleSwitch: UISwitch!
    @IBOutlet var mixSlider : AKPropertySlider!
    @IBOutlet var frequencySlider : AKPropertySlider!
    @IBOutlet var durationSlider : AKPropertySlider!
    @IBOutlet var densitySlider : AKPropertySlider!
    @IBOutlet var frequencyVariationSlider : AKPropertySlider!
    @IBOutlet var frequencyVariationDistributionSlider : AKPropertySlider!
    
    let granularSynth = GranularSynth();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        AKOrchestra.addInstrument(granularSynth)
        
        mixSlider.property                            = granularSynth.mix;
        frequencySlider.property                      = granularSynth.frequency;
        durationSlider.property                       = granularSynth.duration;
        densitySlider.property                        = granularSynth.density;
        frequencyVariationSlider.property             = granularSynth.frequencyVariation;
        frequencyVariationDistributionSlider.property = granularSynth.frequencyVariationDistribution;
    }

    @IBAction func toggleGranularInstrument(sender: AnyObject) {
        toggleSwitch.on ?  granularSynth.play() : granularSynth.stop()
    }

    
}