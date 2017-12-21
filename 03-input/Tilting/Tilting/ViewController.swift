//
//  ViewController.swift
//  Tilting
//
//  Created by Jon Manning on 2/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    // BEGIN tilt
    @IBOutlet weak var pitchLabel : UILabel!
    @IBOutlet weak var yawLabel : UILabel!
    @IBOutlet weak var rollLabel : UILabel!
    
    var motionManager = CMMotionManager()

    override func viewDidLoad() {
        var mainQueue = NSOperationQueue.mainQueue()
        
        motionManager.startDeviceMotionUpdatesToQueue(mainQueue) {
            (motion, error) in
            
            var roll = motion.attitude.roll
            var rollDegrees = roll * 180 / M_PI
            
            var yaw = motion.attitude.yaw
            var yawDegrees = yaw * 180 / M_PI
            
            var pitch = motion.attitude.pitch
            var pitchDegrees = pitch * 180 / M_PI
            
            self.rollLabel.text = String(format:"Roll: %.2f°", rollDegrees)
            self.yawLabel.text = String(format: "Yaw: %.2f°", yawDegrees)
            self.pitchLabel.text = String(format: "Pitch: %.2f°", pitchDegrees)
        }
        
    }
    // END tilt



}

