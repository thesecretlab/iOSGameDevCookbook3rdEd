//
//  ViewController.swift
//  Timers
//
//  Created by Jon Manning on 12/01/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // BEGIN timer_storage
    var timer : NSTimer?
    // END timer_storage

    // BEGIN timer_method
    func updateWithTimer(timer: NSTimer) {
        // Timer went off; update the game
        NSLog("Timer went off!")
    }
    // END timer_method

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // BEGIN timer_start
        // Start a timer
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.5,
            target: self, selector: "updateWithTimer",
            userInfo: nil, repeats: true)
        // END timer_start
        
        // BEGIN timer_stop
        // Stop a timer
        self.timer?.invalidate()
        self.timer = nil
        // END timer_stop
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

