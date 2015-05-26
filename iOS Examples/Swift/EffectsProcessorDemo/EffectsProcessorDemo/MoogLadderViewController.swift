//
//  MoogLadderViewController.swift
//  EffectsProcessorDemo
//
//  Created by Matthew Fecher on 5/23/15.
//  Copyright (c) 2015 audiokit.io. All rights reserved.
//

import UIKit

class MoogLadderViewController: UIViewController {
    
    @IBOutlet weak var cutoffFrequncySlider: AKPropertySlider!
    @IBOutlet weak var resonanceSlider: AKPropertySlider!
    @IBOutlet weak var mixSlider: AKPropertySlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let global = SharedStore.globals
        
        cutoffFrequncySlider.property = global.moogLadder!.cutoffFrequency
        resonanceSlider.property = global.moogLadder!.resonance;
        mixSlider.property = global.moogLadder!.mix;
        
    }
    
    
}
