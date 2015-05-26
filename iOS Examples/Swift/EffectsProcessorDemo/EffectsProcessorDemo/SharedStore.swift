//
//  SharedStore.swift
//  EffectsProcessorDemo
//
//  Created by Matthew Fecher on 5/23/15.
//  Copyright (c) 2015 audiokit.io. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
    
class SharedStore: NSObject {
    
    var audioFilePlayer = AudioFilePlayer()
    var reverb: Reverb?
    var variableDelay: VariableDelay?
    var moogLadder: MoogLadder?
    
    var currentSong: MPMediaItem?
    var isPlaying: Bool?
    
    // Singleton in Swift 1.2, just one line...
    static let globals = SharedStore()
}
