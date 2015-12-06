//
//  ViewController.swift
//  TouchRegions
//
//  Created by Matthew Fecher on 5/23/15.
//  Copyright (c) 2015 audiokit.io. All rights reserved.
//

import UIKit
import AudioKit

class ViewController: UIViewController {

    @IBOutlet weak var leftView: TouchView!
    @IBOutlet weak var rightView: TouchView!
    @IBOutlet weak var frequencyLabel: UILabel!
    @IBOutlet weak var carrierMultiplierLabel: UILabel!
    @IBOutlet weak var modulatingMultiplierLabel: UILabel!
    @IBOutlet weak var modulationIndexLabel: UILabel!
    
    // Properties
    let audiokit = AKManager.sharedInstance
    let fm = AKFMOscillator(amplitude: 0.0)
    let minFrequency: Float = 440.0
    let maxFrequency: Float = 880.0
    let minCarrierMultiplier: Float = 0.0
    let maxCarrierMultiplier: Float = 2.0
    let minModulatingMultiplier: Float = 0.0
    let maxModulatingMultiplier: Float = 2.0
    let minModulationIndex: Float = 0.0
    let maxModulationIndex: Float = 30
    let minAmplitude: Float = 0.0
    let maxAmplitude: Float = 0.2
    
    var leftTouchImageView: UIImageView!
    var rightTouchImageView: UIImageView!
    private var myContext = 0 // observer context
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // KVO
        let options = NSKeyValueObservingOptions.New
        leftView.addObserver(self, forKeyPath: "horizontalPercentage", options: options, context: &myContext)
        leftView.addObserver(self, forKeyPath: "verticalPercentage", options: options, context: &myContext)
        rightView.addObserver(self, forKeyPath: "horizontalPercentage", options: options, context: &myContext)
        rightView.addObserver(self, forKeyPath: "verticalPercentage", options: options, context: &myContext)
        
        // Add Instrument
        audiokit.audioOutput = fm
        audiokit.start()
        
        // Setup Touch Visual Indicators
        leftTouchImageView = UIImageView(frame: CGRectMake(-350, -350, 50, 50))
        leftTouchImageView.image = UIImage(named: "circle")
        
        rightTouchImageView = UIImageView(frame: CGRectMake(-350, -350, 50, 50))
        rightTouchImageView.image = UIImage(named: "circle")
        
        self.view.addSubview(leftTouchImageView)
        self.view.addSubview(rightTouchImageView)
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if context == &myContext {
            
            let middle: CGFloat = self.view.frame.size.width / 2.0
            let height: CGFloat = self.view.frame.size.height
            
            if keyPath == "horizontalPercentage" {
                let newValue = change![NSKeyValueChangeNewKey] as! Float
                
                if (object as! TouchView) == leftView {
                    fm.amplitude = maxAmplitude
                    fm.baseFrequency = newValue * (maxFrequency - minFrequency) + minFrequency

                    frequencyLabel.text = String(format: "fm.baseFrequency = %0.6f", fm.baseFrequency)
                    leftTouchImageView.center = CGPointMake(CGFloat(newValue) * middle, leftTouchImageView.center.y)
                }
                
                if (object as! TouchView) == rightView {
                    fm.modulatingMultiplier = newValue * (maxModulatingMultiplier - minModulatingMultiplier) + minModulatingMultiplier
                    modulatingMultiplierLabel.text = String(format: "fm.modulatingMultiplier = %0.6f", fm.modulatingMultiplier)
                    rightTouchImageView.center = CGPointMake(CGFloat(newValue) * middle + middle, rightTouchImageView.center.y)
                }
                
            } else if keyPath == "verticalPercentage" {
                let newValue = change![NSKeyValueChangeNewKey] as! Float
                
                if (object as! TouchView) == leftView {
                    fm.carrierMultiplier = newValue * (maxCarrierMultiplier - minCarrierMultiplier) + minCarrierMultiplier
                    carrierMultiplierLabel.text = String(format: "fm.carrierMultiplier = %0.6f", fm.carrierMultiplier)
                    leftTouchImageView.center = CGPointMake(leftTouchImageView.center.x, CGFloat(newValue) * height)
                }
                
                if (object as! TouchView) == rightView {
                    fm.modulationIndex = newValue * (maxModulationIndex - minModulationIndex) + minModulationIndex
                    modulationIndexLabel.text = String(format: "fm.modulationIndex = %0.6f", fm.modulationIndex)
                    rightTouchImageView.center = CGPointMake(rightTouchImageView.center.x, CGFloat(newValue) * height)
                }
            
            } else {
                NSException.raise("Unexpected Keypath", format: "%@", arguments: getVaList([keyPath as! CVarArgType]))
            }
        
        } else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }
    
}

