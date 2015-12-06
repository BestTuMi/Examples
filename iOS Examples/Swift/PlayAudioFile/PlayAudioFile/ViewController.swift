//
//  ViewController.swift
//  PlayAudioFile
//
//  Created by Aurelius Prochazka on 6/30/14.
//  Copyright (c) 2014 Aurelius Prochazka. All rights reserved.
//

import UIKit
import AudioKit

class ViewController: UIViewController {
    
    var player: AKAudioPlayer?
    var timePitch: AKTimePitch?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let audiokit = AKManager.sharedInstance
        let file = NSBundle.mainBundle().pathForResource("blaster", ofType: "aiff")
        player = AKAudioPlayer(file!)
        
        timePitch = AKTimePitch(player!)
        
        let reverb = AKReverb(timePitch!)
        reverb.loadFactoryPreset(.LargeChamber)
        reverb.dryWetMix = 30
        audiokit.audioOutput = reverb
        audiokit.start()
    }

    @IBAction func playButtonPressed(sender: UIButton) {
        player!.stop()
        timePitch?.rate = randomFloat(0.2, 2.0)
        player!.play()
    }

}

