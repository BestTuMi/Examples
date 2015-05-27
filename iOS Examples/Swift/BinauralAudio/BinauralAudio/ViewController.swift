//
//  ViewController.swift
//  BinauralAudio
//
//  Created by Matthew Fecher on 5/26/15.
//  Copyright (c) 2015 audiokit.io. All rights reserved.
//

import UIKit
import CoreMotion



class ViewController: UIViewController {
    
    @IBOutlet weak var headView: HeadView!
    
    // Properties
    let player = Player()
    let motionManager = CMMotionManager()
    let center = NSNotificationCenter()
    var isPlaying: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add Instrument
        AKOrchestra.addInstrument(player)
        
        // CMMotionManager
        motionManager.deviceMotionUpdateInterval = 1/10.0
        motionManager.gyroUpdateInterval = 0.1
        
        motionManager.startDeviceMotionUpdatesUsingReferenceFrame(CMAttitudeReferenceFrame.XTrueNorthZVertical, toQueue: NSOperationQueue.mainQueue()) {
            (motion: CMDeviceMotion?, _) in
            
            // Attitude -----------------------------------------------------------
            if let attitude: CMAttitude = motion?.attitude {
                var d = [String:Float]()
                d["roll"] = Float(attitude.roll)
                d["pitch"] = Float(attitude.pitch)
                d["yaw"] = Float(attitude.yaw)
                self.receivedOrientationDictionary(d)
            }
        }
    }
    
    @IBAction func play(sender: UIButton) {
        if !isPlaying {
            player.play()
            isPlaying = true
            sender.setTitle("Stop", forState: .Normal)
        } else if isPlaying {
            player.stop()
            isPlaying = false
            sender.setTitle("Play", forState: .Normal)
        }
    }
    
    // MARK: - Helper Methods
    
    func degrees(radian: Float) -> Float {
        return (180 * radian / Float(M_PI))
    }
    
    func receivedOrientationDictionary(data: NSDictionary) {
        
        let pitch = data["pitch"] as! Float
        let yaw = data["yaw"] as! Float
        
        player.elevation.value = degrees(pitch)
        player.azimuth.value = degrees(yaw)
        player.reverbFeedback.value = fabs(degrees(yaw))/360.0
        player.reverbLevel.value = fabs(degrees(yaw))/360.0
        
        headView.azimuth = CGFloat(-degrees(yaw))
        headView.setNeedsDisplay()
    }
}

