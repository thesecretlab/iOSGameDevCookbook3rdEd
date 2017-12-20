//
//  ViewController.swift
//  ComponentBasedLayout
//
//  Created by Jon Manning on 12/01/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
monster.addComponent(DamageTaking())
        
// Get a reference to the first Damageable component
let damage : DamageTaking? = monster.findComponent()
damage?.takeDamage(5)
        
// When the game needs to update, send all game
// objects the "update" message.
// This makes all components run their update logic.
monster.update(0.33)

// END componentbased_example

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

