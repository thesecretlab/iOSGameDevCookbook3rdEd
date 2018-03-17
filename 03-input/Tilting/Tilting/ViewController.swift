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
        let mainQueue = OperationQueue.main
        
        motionManager.startDeviceMotionUpdates(to: mainQueue) {
            (motion, error) in
            
            // Ensure that we have a CMDeviceMotion to work with
            guard let motion = motion else {
                if let error = error {
                    print("Failed to get device motion: \(error)")
                }
                return
            }
            
            let roll = motion.attitude.roll
            let rollDegrees = roll * 180 / .pi
            
            let yaw = motion.attitude.yaw
            let yawDegrees = yaw * 180 / .pi
            
            let pitch = motion.attitude.pitch
            let pitchDegrees = pitch * 180 / .pi
            
            self.rollLabel.text = String(format:"Roll: %.2f°", rollDegrees)
            self.yawLabel.text = String(format: "Yaw: %.2f°", yawDegrees)
            self.pitchLabel.text = String(format: "Pitch: %.2f°", pitchDegrees)
        }
        
    }
    // END tilt



}

