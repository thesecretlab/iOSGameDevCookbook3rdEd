//: [Previous](@previous)

import Foundation

// BEGIN inheritance_gameobject
class GameObject {
    func update(deltaTime : Float) {
        
        // 'deltaTime' is the number of seconds since
        // this was last called.
        
        // This method is overriden by subclasses to update
        // the object's state - position, direction, and so on.
    }
}
// END inheritance_gameobject

// BEGIN inheritance_monster
class Monster: GameObject {
    
    var hitPoints : Int = 10 // how much health we have
    var target : GameObject? // the game object we're attacking
    
    override func update(deltaTime: Float) {
        
        super.update(deltaTime: deltaTime)
        
        // Do some monster-specific updating
        
    }
    
}
// END inheritance_monster


//: [Next](@next)
