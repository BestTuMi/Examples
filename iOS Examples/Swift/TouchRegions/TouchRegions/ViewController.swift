//
//  ViewController.swift
//  TouchRegions
//
//  Created by Matthew Fecher on 5/23/15.
//  Copyright (c) 2015 audiokit.io. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var leftView: TouchView!
    @IBOutlet weak var rightView: TouchView!
    @IBOutlet weak var frequencyLabel: UILabel!
    @IBOutlet weak var carrierMultiplierLabel: UILabel!
    @IBOutlet weak var modulatingMultiplierLabel: UILabel!
    @IBOutlet weak var modulationIndexLabel: UILabel!
    
    // Properties
    let fm = FMOscillator()
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
        AKOrchestra.addInstrument(fm)
        AKOrchestra.start()
        
        fm.amplitude.value = fm.amplitude.minimum
        fm.play()
        
        // Setup Touch Visual Indicators
        leftTouchImageView = UIImageView(frame: CGRectMake(-350, -350, 50, 50))
        leftTouchImageView.image = UIImage(named: "circle")
        
        rightTouchImageView = UIImageView(frame: CGRectMake(-350, -350, 50, 50))
        rightTouchImageView.image = UIImage(named: "circle")
        
        self.view.addSubview(leftTouchImageView)
        self.view.addSubview(rightTouchImageView)
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        
        if context == &myContext {
            
            let middle: CGFloat = self.view.frame.size.width / 2.0
            let height: CGFloat = self.view.frame.size.height
            
            if keyPath == "horizontalPercentage" {
                let newValue = change[NSKeyValueChangeNewKey] as! Float
                
                if (object as! TouchView) == leftView {
                    fm.amplitude.value = fm.amplitude.maximum
                    fm.frequency.value = newValue * (fm.frequency.maximum - fm.frequency.minimum) + fm.frequency.minimum
                    frequencyLabel.text = String(format: "fm.baseFrequncy = %0.6f", fm.frequency.value)
                    leftTouchImageView.center = CGPointMake(CGFloat(newValue) * middle, leftTouchImageView.center.y)
                }
                
                if (object as! TouchView) == rightView {
                    fm.modulatingMultiplier.value = newValue * (fm.modulatingMultiplier.maximum - fm.modulatingMultiplier.minimum) + fm.modulatingMultiplier.minimum
                    modulatingMultiplierLabel.text = String(format: "fm.modulatingMultiplier = %0.6f", fm.modulatingMultiplier.value)
                    rightTouchImageView.center = CGPointMake(CGFloat(newValue) * middle + middle, rightTouchImageView.center.y)
                }
                
            } else if keyPath == "verticalPercentage" {
                let newValue = change[NSKeyValueChangeNewKey] as! Float
                
                if (object as! TouchView) == leftView {
                    fm.carrierMultiplier.value = newValue * (fm.carrierMultiplier.maximum - fm.carrierMultiplier.minimum) + fm.carrierMultiplier.minimum
                    carrierMultiplierLabel.text = String(format: "fm.carrierMultiplier = %0.6f", fm.carrierMultiplier.value)
                    leftTouchImageView.center = CGPointMake(leftTouchImageView.center.x, CGFloat(newValue) * height)
                }
                
                if (object as! TouchView) == rightView {
                    fm.modulationIndex.value = newValue * (fm.modulationIndex.maximum - fm.modulationIndex.minimum) + fm.modulationIndex.minimum
                    modulationIndexLabel.text = String(format: "fm.cmodulationIndex = %0.6f", fm.modulationIndex.value)
                    rightTouchImageView.center = CGPointMake(rightTouchImageView.center.x, CGFloat(newValue) * height)
                }
            
            } else {
                NSException.raise("Unexpected Keypath", format: "%@", arguments: getVaList([keyPath]))
            }
        
        } else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }
    
}

