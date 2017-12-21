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
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        // Show a label when shaking begins
        self.shakingLabel.isHidden = false
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        // Hide the label 1 second after shaking ends
        let delayInSeconds : Double = 1.0
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            self.shakingLabel.isHidden = true
        }
        
    }
    // END motion_methods
    
    
    // BEGIN responder
    override var canBecomeFirstResponder: Bool {
        return true
    }
    // END responder
    // END shaking
    
    

}

