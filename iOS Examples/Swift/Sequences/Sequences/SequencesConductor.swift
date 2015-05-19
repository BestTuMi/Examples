//
//  SequencesConductor.swift
//  Sequences
//
//  Created by Matthew Fecher on 5/17/15.
//  Copyright (c) 2015 audiokit.io. All rights reserved.
//

class SequencesConductor {

    // Instance Variables (instruments, processors, etc.)
    let instrument = SeqInstrument()
    let sequence = AKSequence()
    
    init() {
        // Add instruments
        AKOrchestra.addInstrument(instrument)
    }
    
    func playPhraseOfNotesOfDuration(duration: Float) {
        
        let phrase = AKPhrase()
        
        for i in 0...12 {
            let note = SeqInstrumentNote()
            note.frequency.floatValue = 440*(pow(2.0,Float(i)/12))
            note.duration.value = duration
            
            let time = duration * Float(i)
            phrase.addNote(note, atTime: time)
        }
        
        instrument.playPhrase(phrase)
    }
    
    func playSequenceOfNotePropertiesOfDuration(duration: Float) {
        
        let note = SeqInstrumentNote(frequency: 440)
        
        for i in 0...12 {
            let update = AKEvent() {
                note.frequency.floatValue = 440*(pow(2.0,Float(i)/12))
            }
            
            let time = duration * Float(i)
            sequence.addEvent(update, atTime: time)
        }
        
        let stopNote = AKEvent() { note.stop() }
        sequence.addEvent(stopNote, atTime: duration * 13)
        
        instrument.playNote(note)
        sequence.play()
    }
    
    func playSequenceOfInstrumentPropertiesOfDuration(duration: Float) {
        
        let note = SeqInstrumentNote(frequency: 440)
        
        let noteOn = AKEvent() {
            self.instrument.playNote(note)
        }
        
        sequence.addEvent(noteOn)
        
        for i in 0...12 {
            let update = AKEvent() {
                self.instrument.modulation.value = pow(2.0,Float(i)/12)
            }
            let time = duration * Float(i)
            sequence.addEvent(update, atTime: time)
        }
        
        for i in 0...12 {
            let update = AKEvent() {
                self.instrument.modulation.value = 3.0 - pow(2.0,Float(i)/12)
            }
            let time = duration * (Float(i) + 12)
            sequence.addEvent(update, atTime: time)
        }
        
        let stopNote = AKEvent() { note.stop() }
        sequence.addEvent(stopNote, atTime: duration * 25)
        
        instrument.playNote(note)
        sequence.play()
    }
    
}





















