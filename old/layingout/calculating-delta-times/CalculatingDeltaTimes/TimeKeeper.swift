//
//  TimeKeeper.swift
//  CalculatingDeltaTimes
//
//  Created by Jon Manning on 12/01/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

// This is a dummy object, used in the example below.
class MovingObject {
    func move(# distance: Double) {
        
    }
}
let someMovingObject = MovingObject()

// BEGIN deltatime_timekeeper
class TimeKeeper: NSObject {
    
    var lastFrameTime : Double = 0.0
   
}
// END deltatime_timekeeper

extension TimeKeeper {
    
    // BEGIN deltatime_calculating
    func update(currentTime : Double) {
        
        // Calculate the time since this method was last called
        let deltaTime = currentTime - lastFrameTime
        
        // Move at 3 units per second
        let movementSpeed = 3.0
        
        // Multiply by deltaTime to work out how far
        // an object needs to move this frame
        someMovingObject.move(distance: movementSpeed * deltaTime)
        
        // Set last frame time to current time, so that
        // we can calculate the delta time when we're next
        // called
        lastFrameTime = currentTime
    }
    // END deltatime_calculating
    
    func currentTime() -> Void {
        // BEGIN deltatime_getting_current_time
        let currentTime = NSDate.timeIntervalSinceReferenceDate() as Double
        // END deltatime_getting_current_time
    }
    
    

}
