//
//  ViewController.swift
//  DisplayLink
//
//  Created by Jon Manning on 12/01/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

// BEGIN displaylink_import
import QuartzCore
// END displaylink_import

class ViewController: UIViewController {
    
    // BEGIN displaylink_storage
    var displayLink : CADisplayLink?
    // END displaylink_storage

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
// BEGIN displaylink_setup
// Create and schedule the display link
displayLink = CADisplayLink(target: self, selector: "screenUpdated:")
displayLink?.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
// END displaylink_setup

        // BEGIN displaylink_pause
        // Pause the display link
        displayLink?.paused = true
        // END displaylink_pause
        
        // BEGIN displaylink_remove
        // Remove the display link; once done, you need to
        // remove it from memory
        displayLink?.invalidate()
        displayLink = nil
        // END displaylink_remove

        
    }
    
    // BEGIN displaylink_update
    func screenUpdated(displayLink : CADisplayLink) {
        // Update the game.
    }
    // END displaylink_update

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

