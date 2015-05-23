//
//  ViewController.swift
//  PlayAudioFile
//
//  Created by Aurelius Prochazka on 6/30/14.
//  Copyright (c) 2014 Aurelius Prochazka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let conductor = AudioFileConductor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    @IBAction func playButtonPressed(sender: UIButton) {
        conductor.playBlaster()
    }

}

