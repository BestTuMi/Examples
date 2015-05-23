//
//  AudioFilePlayer.swift
//  PlayAudioFile
//
//  Created by Matthew Fecher on 5/23/15.
//  Copyright (c) 2015 audiokit.io. All rights reserved.
//

class AudioFilePlayer: AKInstrument {

    override init() {
        super.init()
        
        // NOTE BASED CONTROL ==================================================
        let note = AudioFilePlayerNote()
        
        // INSTRUMENT DEFINITION ==================================================
        let file = NSBundle.mainBundle().pathForResource("blaster", ofType: "aiff")
        let fileTable = AKSoundFileTable(filename: file)
        
        let looper = AKMonoSoundFileLooper(soundFile: fileTable)
        looper.frequencyRatio = note.speed
        looper.loopMode = AKMonoSoundFileLooper.loopPlaysOnce()
        
        // EFFECT
        let reverb = AKReverb(input: looper)
        reverb.feedback.value = 0.85
        
        // AUDIO OUTPUT ========================================================
        setStereoAudioOutput(reverb)
    }
}

// -----------------------------------------------------------------------------
// MARK: - Instrument Note
// -----------------------------------------------------------------------------

class AudioFilePlayerNote: AKNote {
    
    // Note Properties
    var speed = AKNoteProperty(value: 1.0, minimum: 0.2, maximum: 2.0)
    
    override init() {
        super.init()
        addProperty(speed)
    }
    
    convenience init(speed: Float) {
        self.init()
        self.speed.value = speed
    }
}
