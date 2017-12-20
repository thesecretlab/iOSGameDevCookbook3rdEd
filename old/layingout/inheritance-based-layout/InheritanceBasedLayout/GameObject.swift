//
//  GameObject.swift
//  InheritanceBasedLayout
//
//  Created by Jon Manning on 12/01/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

// BEGIN inheritance_gameobject
class GameObject: NSObject {
    func update(deltaTime : Float) {
        
        // 'deltaTime' is the number of seconds since 
        // this was last called.
        
        // This method is overriden by subclasses to update 
        // the object's state - position, direction, and so on.
    }
}
// END inheritance_gameobject
