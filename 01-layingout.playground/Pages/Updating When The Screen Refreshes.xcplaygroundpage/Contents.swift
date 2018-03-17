//: [Previous](@previous)

import Foundation
import UIKit
import PlaygroundSupport

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
        // Get a reference to the method we want to run when the
        // display updates
        let screenUpdated = #selector(screenUpdated(displayLink:))
        
        // Create and schedule the display link
        displayLink = CADisplayLink(target: self, selector: screenUpdated)
        displayLink?.add(to: RunLoop.main, forMode: RunLoopMode.commonModes)
        // END displaylink_setup
        
        // BEGIN displaylink_pause
        // Pause the display link
        displayLink?.isPaused = true
        // END displaylink_pause
        
        // BEGIN displaylink_remove
        // Remove the display link; once done, you need to
        // remove it from memory by setting all references to it to nil
        displayLink?.invalidate()
        displayLink = nil
        // END displaylink_remove
 
        
    }
    
    // BEGIN displaylink_update
    @objc func screenUpdated(displayLink : CADisplayLink) {
        // Update the game.
    }
    // END displaylink_update
    
}

PlaygroundPage.current.liveView = ViewController()


//: [Next](@next)
