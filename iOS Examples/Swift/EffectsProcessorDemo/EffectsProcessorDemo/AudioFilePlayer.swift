//
//  AudioFilePlayer.swift
//  Effects Processor Demo
//
//  Created by Matthew Fecher on 5/23/15.
//  Copyright (c) 2015 audiokit.io. All rights reserved.
//

class AudioFilePlayer: AKInstrument {
    
    // Instrument Properties
    var filePosition: AKInstrumentProperty?
    
    // Auxilliary Outputs
    var auxilliaryOutput = AKStereoAudio()

    init(filename: String) {
        super.init()

        // NOTE BASED CONTROL ==================================================
        let note = Playback()
        
        // INSTRUMENT DEFINITION ==================================================
        filePosition = AKInstrumentProperty(value: 0)
        
        let fileIn = AKFileInput(filename: filename)
        fileIn.startTime = note.startTime
        fileIn.loop = true
        
        // Output to global effects processing
        auxilliaryOutput = AKStereoAudio.globalParameter()
        self.assignOutput(auxilliaryOutput, to:fileIn)
      
    }
    
    convenience override init() {
        let docDirs: [NSString] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let docDir = docDirs[0]
        let file = docDir.stringByAppendingPathComponent("exported") as NSString
        
        self.init(filename: file.stringByAppendingPathExtension("wav")!)
    }

}

// -----------------------------------------------------------------------------
// MARK: - Note
// -----------------------------------------------------------------------------

class Playback: AKNote {
    
    // Note Properties
    var startTime = AKNoteProperty(value: 0, minimum: 0, maximum: 100000000)
    
    override init() {
        super.init()
        addProperty(startTime)
    }
    
    convenience init(startTime: Float) {
        self.init()
        self.startTime.value = startTime
    }
}
