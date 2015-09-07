//
//  SamplesViewController.swift
//  EffectsProcessorDemo
//
//  Created by Nicholas Arner on 1/30/15.
//  Copyright (c) 2015 AudioKit. All rights reserved.
//

import UIKit

class SamplesViewController: UIViewController {
    
    var startTime: Float!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        startTime = 0
    }
    
    func playFile(file: String) {
        let global = SharedStore.globals
        
        global.audioFilePlayer.stop()
        AKOrchestra.reset()
        
        // Create the orchestra and instruments
        global.audioFilePlayer = AudioFilePlayer(filename: file)
        global.variableDelay = VariableDelay(audioSource: global.audioFilePlayer.auxilliaryOutput)
        global.moogLadder = MoogLadder(audioSource: global.variableDelay!.auxilliaryOutput)
        global.reverb = AKReverbPedal(stereoInput: global.moogLadder!.auxilliaryOutput)
        
        AKOrchestra.addInstrument(global.audioFilePlayer)
        AKOrchestra.addInstrument(global.variableDelay!)
        AKOrchestra.addInstrument(global.moogLadder!)
        AKOrchestra.addInstrument(global.reverb!)
        
        let playback = Playback(startTime: startTime)
        global.variableDelay!.play()
        global.moogLadder!.play()
        global.reverb!.play()
        global.audioFilePlayer.playNote(playback)
        global.isPlaying = true
        
    }

    @IBAction func playFirstSample(sender: UIButton) {
        let file = AKManager.pathToSoundFile("PianoBassDrumLoop", ofType: "wav")
        playFile(file!)
    }
    
    @IBAction func playSecondSample(sender: UIButton) {
        let file = AKManager.pathToSoundFile("808loop", ofType: "wav")
        playFile(file!)
    }
    
    @IBAction func stop(sender: UIButton) {
        
        let global = SharedStore.globals
        
        if global.isPlaying == false {
            let playback = Playback(startTime: startTime)
            global.audioFilePlayer.playNote(playback)
            sender.setTitle("Pause", forState: .Normal)
            global.isPlaying = true
            
        } else {
            startTime = startTime + global.audioFilePlayer.filePosition!.value
            global.audioFilePlayer.stop()
            sender.setTitle("Play", forState: .Normal)
            global.isPlaying = false
        }
    }
    
}
