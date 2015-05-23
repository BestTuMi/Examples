//
//  AudioFileConductor.swift
//  PlayAudioFile
//
//  Created by Matthew Fecher on 5/23/15.
//  Copyright (c) 2015 audiokit.io. All rights reserved.
//

class AudioFileConductor {
    
    let audioFilePlayer = AudioFilePlayer()

    init() {
        // Add instruments
        AKOrchestra.addInstrument(audioFilePlayer)
    }
    
    func playBlaster() {
        let note = AudioFilePlayerNote()
        note.speed.randomize()
        note.duration.value = 4.0 // seconds maximum
        audioFilePlayer.playNote(note)
    }
}
