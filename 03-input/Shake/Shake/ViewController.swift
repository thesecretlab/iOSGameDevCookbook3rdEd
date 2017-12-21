//
//  ViewController.swift
//  Shake
//
//  Created by Jon Manning on 2/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var shakingLabel : UILabel!
    
// BEGIN shaking
// BEGIN motion_methods
override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent) {
        
    // Show a label when shaking begins
    self.shakingLabel.hidden = false
}
    
override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        
    // Hide the label 1 second after shaking ends
    var delayInSeconds : Float = 1.0
        
    var popTime = dispatch_time(DISPATCH_TIME_NOW,
        (Int64)(delayInSeconds * Float(NSEC_PER_SEC)))
        
    dispatch_after(popTime, dispatch_get_main_queue()) {
        self.shakingLabel.hidden = true
    }
}
// END motion_methods

    
// BEGIN responder
override func canBecomeFirstResponder() -> Bool {
    return true
}
// END responder
// END shaking


}

