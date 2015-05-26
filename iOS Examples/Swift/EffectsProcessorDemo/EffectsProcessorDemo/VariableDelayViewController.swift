//
//  VariableDelayViewController.swift
//  EffectsProcessorDemo
//
//  Created by Matthew Fecher on 5/23/15.
//  Copyright (c) 2015 audiokit.io. All rights reserved.
//

import UIKit

class VariableDelayViewController: UIViewController {

    @IBOutlet weak var delayTimeSlider: AKPropertySlider!
    @IBOutlet weak var mixSlider: AKPropertySlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let global = SharedStore.globals
        delayTimeSlider.property = global.variableDelay!.delayTime
        mixSlider.property = global.variableDelay!.mix
    }



}
