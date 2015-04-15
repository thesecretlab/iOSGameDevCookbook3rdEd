//
//  ViewController.swift
//  Pausing
//
//  Created by Jon Manning on 13/01/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var gameObjects : [GameObject] = []
    
    var paused = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let deltaTime : Float = 0.01
        
        // BEGIN pausing
        for gameObject in self.gameObjects {
            
            // Update it if we're not paused, or if this game object
            // ignores the paused state
            if self.paused == false || gameObject.canPause == false {
                gameObject.update(deltaTime)
            }
            
        }
        // END pausing

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

