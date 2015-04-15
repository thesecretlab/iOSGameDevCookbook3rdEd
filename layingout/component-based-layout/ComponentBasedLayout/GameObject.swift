//
//  GameObject.swift
//  ComponentBasedLayout
//
//  Created by Jon Manning on 12/01/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

// BEGIN componentbased_gameobject
class GameObject: NSObject {
   
    // The collection of Component objects attached to us
    var components : [Component] = []
    
    // Add a component to this gameobject
    func addComponent(component : Component) {
        components.append(component)
        component.gameObject = self
    }
    
    // Remove a component from this game object, if we have it
    func removeComponent(component : Component) {
        if let index = find(components, component) {
            component.gameObject = nil
            components.removeAtIndex(index)
        }
    }
    
    // Update this object by updating all components
    func update(deltaTime : Float) {
        
        for component in self.components {
            component.update(deltaTime)
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


