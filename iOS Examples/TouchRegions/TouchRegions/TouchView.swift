//
//  TouchView.swift
//  TouchRegions
//
//  Created by Matthew Fecher on 5/23/15.
//  Copyright (c) 2015 audiokit.io. All rights reserved.
//

import UIKit

class TouchView: UIView {
    
    dynamic var horizontalPercentage: CGFloat = 0.0
    dynamic var verticalPercentage: CGFloat = 0.0
    var firstTouch: UITouch?
    
    // MARK: - Handle Touches
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touchSet = touches as NSSet
        for touch in touchSet {
            if firstTouch == nil || (touch as? UITouch) == firstTouch {
                let touchPoint = touch.locationInView(self)
                self.setPercentagesWithTouchPoint(touchPoint)
            }
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touchSet = touches as NSSet
        for touch in touchSet {
            if firstTouch == nil || (touch as? UITouch) == firstTouch {
                let touchPoint = touch.locationInView(self)
                self.setPercentagesWithTouchPoint(touchPoint)
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touchSet = touches as NSSet
        for touch in touchSet {
            if firstTouch == nil || (touch as? UITouch) == firstTouch {
                let touchPoint = touch.locationInView(self)
                self.setPercentagesWithTouchPoint(touchPoint)
                firstTouch = nil
            }
        }
    }
    
    // MARK: - Set Percentages
    
    func setPercentagesWithTouchPoint(touchPoint: CGPoint) {
        if touchPoint.x > 0 && touchPoint.x < self.bounds.size.width &&
            touchPoint.y > 0 && touchPoint.y < self.bounds.size.height {
                
            self.horizontalPercentage = touchPoint.x / self.bounds.size.width
            self.verticalPercentage = touchPoint.y / self.bounds.size.height
        }
    }

}
