//: [Previous](@previous)

import Foundation

// BEGIN componentbased_component
class Component {
    
    // The game object this component is attached to
    var gameObject : GameObject?
    
    func update(deltaTime : Float) {
        // Update this component
    }
    
}
// END componentbased_component

// BEGIN componentbased_gameobject
class GameObject {
    
    // The collection of Component objects attached to us
    var components : [Component] = []
    
    // Add a component to this gameobject
    func add(component : Component) {
        components.append(component)
        component.gameObject = self
    }
    
    // Remove a component from this game object, if we have it
    func remove(component : Component) {
        
        // Figure out the index at which this component exists
        
        // Note the use of the === (three equals) operator,
        // which checks to see if two variables refer to the same object
        // (as opposed to "==", which checks to see if two variables
        // have the same value, which means different things for
        // different types of data)
        
        if let index = components.index(where: { $0 === component}) {
            component.gameObject = nil
            components.remove(at: index)
        }
    }
    
    // Update this object by updating all components
    func update(deltaTime : Float) {
        
        for component in self.components {
            component.update(deltaTime: deltaTime)
        }
        
    }
    
    // Returns the first component of type T attached to this
    // game object
    func findComponent<T: Component>() -> T?{
        
        for component in self.components {
            if let theComponent = component as? T {
                return theComponent
            }
        }
        
        return nil;
    }
    
    // Returns an array of all components of type T
    // (this returned array might be empty)
    func findComponents<T: Component>() -> [T?] {
        // NOTE: this returns an array of T? (that is,
        // optionals), even though it doesn't strictly need
        // to. This is because Xcode 6.1.1's Swift compiler
        // was crashing when this function returned an array of T
        // (that is, non-optionals.) Your mileage may vary.
        
        var foundComponents : [T] = []
        
        for component in self.components {
            if let theComponent = component as? T {
                foundComponents.append(theComponent)
            }
        }
        
        return foundComponents
    }
    
}
// END componentbased_gameobject

// BEGIN componentbased_example
// Define a type of component
class DamageTaking : Component {
    var hitpoints : Int = 10
    
    func takeDamage(amount : Int) {
        hitpoints -= amount
    }
}

// Make an object - no need to subclass GameObject,
// because its behavior is determined by which
// components it has
let monster = GameObject()

// Add a new Damageable component
monster.add(component: DamageTaking())

// Get a reference to the first Damageable component
let damage : DamageTaking? = monster.findComponent()
damage?.takeDamage(amount: 5)

// When the game needs to update, send all game
// objects the "update" message.
// This makes all components run their update logic.
monster.update(deltaTime: 0.33)
// END componentbased_example

//: [Next](@next)
