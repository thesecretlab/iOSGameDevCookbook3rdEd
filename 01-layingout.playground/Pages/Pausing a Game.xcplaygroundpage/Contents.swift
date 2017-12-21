//: [Previous](@previous)

import Foundation

class GameObject {
    func update(deltaTime : Float) {
        
        // 'deltaTime' is the number of seconds since
        // this was last called.
        
        // This method is overriden by subclasses to update
        // the object's state - position, direction, and so on.
    }
    
    var canPause = true
}

let gameObjects : [GameObject] = []

var paused = false

let deltaTime : Float = 0.1

// BEGIN pausing
for gameObject in gameObjects {
    
    // Update it if we're not paused, or if this game object
    // ignores the paused state
    if paused == false || gameObject.canPause == false {
        gameObject.update(deltaTime: deltaTime)
    }
    
}
// END pausing

//: [Next](@next)
