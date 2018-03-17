//
//  Monster.swift
//  InheritanceBasedLayout
//
//  Created by Jon Manning on 12/01/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

// BEGIN inheritance_monster
class Monster: GameObject {
   
    var hitPoints : Int = 10 // how much health we have
    var target : GameObject? // the game object we're attacking
    
    override func update(deltaTime: Float) {
        
        super.update(deltaTime)
        
        // Do some monster-specific updating
        
    }
    
}
// END inheritance_monster
