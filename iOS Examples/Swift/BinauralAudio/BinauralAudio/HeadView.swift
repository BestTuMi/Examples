//
//  HeadView.swift
//  BinauralAudio
//
//  Created by Matthew Fecher on 5/26/15.
//  Copyright (c) 2015 audiokit.io. All rights reserved.
//

import UIKit

class HeadView: UIView {

    var azimuth: CGFloat = 0.0
    var volume: CGFloat!

    override func drawRect(rect: CGRect) {
        StyleKit.drawHeadAndSpeakerWithAzimuth(azimuth)
    }

}
