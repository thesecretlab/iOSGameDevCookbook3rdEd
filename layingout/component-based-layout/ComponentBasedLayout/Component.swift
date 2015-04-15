//
//  Component.swift
//  ComponentBasedLayout
//
//  Created by Jon Manning on 12/01/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

// BEGIN componentbased_component
class Component: NSObject {
   
    // The game object this component is attached to
    var gameObject : GameObject?
    
    func update(deltaTime : Float) {
        // Update this component
    }
    
}
// END componentbased_component