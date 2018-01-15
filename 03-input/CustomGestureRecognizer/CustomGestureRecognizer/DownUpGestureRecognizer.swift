//
//  DownUpGestureRecognizer.swift
//  CustomGestureRecognizer
//
//  Created by Jon Manning on 16/01/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

// BEGIN recognizer
import UIKit.UIGestureRecognizerSubclass

class DownUpGestureRecognizer: UIGestureRecognizer {
    
    // Represents the two phases that the gesture can be in:
    // moving down, or moving up after having moved down
    enum DownUpGesturePhase : CustomStringConvertible {
        case movingDown, movingUp
        
        // The 'CustomStringConvertible' protocol above means
        // that this type can be turned into a string.
        // This means you can say "\(somePhase)" and it will
        // turn into the correct string.
        // The following property adds support for this.
        var description: String {
            get {
                switch self {
                case .movingDown:
                    return "Moving Down"
                case .movingUp:
                    return "Moving Up"
                }
            }
        }
    }
    
    var phase : DownUpGesturePhase = .movingDown
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        
        // The gesture begins in the moving down phase.
        self.phase = .movingDown
        
        if self.numberOfTouches > 1 {
            
            // If there's more than one touch, this is not the type of gesture
            // we're looking for, so fail immediately
            self.state = .failed
        } else {
            
            // Else, this touch could possible turn into a down-up gesture
            self.state = .possible
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        
        // We know we only have one touch, beacuse touchesBegan will stop
        // recognizing when more than one touch is detected
        guard let touch = touches.first else {
            return
        }
        
        // Get the current and previous position of the touch
        let position = touch.location(in: touch.view)
        let lastPosition = touch.previousLocation(in: touch.view)
        
        // If the state is Possible, and the touch has moved down, the
        // gesture has Begun
        if self.state == .possible && position.y > lastPosition.y {
            self.state = .began
        }
        
        // If the state is Began or Changed, and the touch has moved, the
        // gesture will change state
        else if self.state == .began ||
            self.state == .changed {
            
            // If the phase of the gesture is MovingDown, and the touch moved
            // down, the gesture has Changed
            if self.phase == .movingDown && position.y >
                lastPosition.y {
                    self.state = .changed
            }
            // If the phase of the gesture is MovingDown, and the touch moved
            // up, the gesture has Changed also, change the phase to MovingUp
            else if self.phase == .movingDown && position.y <
                lastPosition.y {
                    self.phase = .movingUp
                    self.state = .changed
            }
            // If the phase of the gesture is MovingUp, and the touch moved
            // down, then the gesture has Failed
            else if self.phase == .movingUp && position.y >
                lastPosition.y {
                self.state = .failed
            }
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        
        // If the touch ends while the phase is MovingDown, the gesture
        // has Failed.
        if self.phase == .movingDown {
            self.state = .failed
        }
        // If the touch ends while the phase is MovingUp, the gesture has
        // Ended.
        else if self.phase == .movingUp {
            self.state = .ended
        }
    }
   
}
// END recognizer

