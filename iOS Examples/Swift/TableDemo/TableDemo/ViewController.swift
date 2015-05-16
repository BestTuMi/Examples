//
//  ViewController.swift
//  TableDemo
//
//  Created by Aurelius Prochazka on 4/17/15.
//  Copyright (c) 2015 Aurelius Prochazka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // IBOutlets
    @IBOutlet weak var choices: UISegmentedControl!
    @IBOutlet weak var tablePlot: AKTablePlot!
    @IBOutlet weak var frequencyLabel: AKPropertyLabel!
    @IBOutlet weak var frequencySlider: AKPropertySlider!
    
    // Properties
    let oscillatorInstrument = OscillatorInstrument()
    var waveforms: [AKTable] = []
    var isPlaying: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add the Instrument to the Orchestra
        AKOrchestra.addInstrument(oscillatorInstrument)
        
        // The standard square wave goes from -1 to 1 producing a clicking sound
        let playableSquare = AKTable.standardSquareWave()
        // but scaling to just below 1 works fine
        playableSquare.scaleBy(0.99999)
        
        // Populate waveform array
        waveforms = [   AKTable.standardSawtoothWave(),
            AKTable.standardSineWave(),
            playableSquare,
            AKTable.standardTriangleWave()  ]
        
        // Set Segmented Control to Sine Wave by default
        choices.selectedSegmentIndex = 1
        self.changeWaveform(choices)
        
        // Frequency AKPropertyLabel & AKPropertySlider
        frequencyLabel.property = oscillatorInstrument.frequency
        frequencySlider.property = oscillatorInstrument.frequency
        
    }
    
    @IBAction func play(sender: UIButton) {
        
        if isPlaying {
            oscillatorInstrument.stop()
            sender.setTitle("Play", forState: .Normal)
            isPlaying = false
        } else {
            oscillatorInstrument.play()
            sender.setTitle("Stop", forState: .Normal)
            isPlaying = true
        }
    }
    
    @IBAction func changeWaveform(sender: UISegmentedControl) {
        
        let index = sender.selectedSegmentIndex
        
        oscillatorInstrument.oscillator.waveform = waveforms[index]
        tablePlot.table = waveforms[index]
        AKOrchestra.updateInstrument(oscillatorInstrument)
        
        if isPlaying {
            oscillatorInstrument.restart()
        }
        
    }

}