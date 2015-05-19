//
//  ViewController.swift
//  Sequences
//
//  Created by Aurelius Prochazka on 6/30/14.
//  Copyright (c) 2014 Aurelius Prochazka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var durationValue: UILabel!
    @IBOutlet weak var durationSlider: UISlider!
    
    let conductor = SequencesConductor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func getDuration() -> Float {
        return AKTools.scaleValueFromSlider(durationSlider, minimum: 0.05, maximum: 0.2)
    }
    
    @IBAction func playPhrase(sender: UIButton) {
        conductor.playPhraseOfNotesOfDuration(getDuration())
    }
    
    @IBAction func playSequenceOfNoteProperties(sender: UIButton) {
        conductor.playSequenceOfNotePropertiesOfDuration(getDuration())
    }
    
    @IBAction func playSequenceOfInstrumentProperties(sender: UIButton) {
        conductor.playSequenceOfInstrumentPropertiesOfDuration(getDuration())
    }
    
    @IBAction func moveDurationSlider(sender: UISlider) {
        let duration = AKTools.scaleValueFromSlider(durationSlider, minimum: 0.05, maximum: 0.2)
        durationValue.text = String(format: "%g", duration)
    }
}

