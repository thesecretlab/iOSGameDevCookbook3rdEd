//
//  ViewController.swift
//  Compass
//
//  Created by Jon Manning on 2/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    @IBOutlet weak var directionLabel : UILabel!

    
    override func viewDidLoad() {
        
        let mainQueue = OperationQueue.main
        
        // BEGIN compass
        
        motionManager.startDeviceMotionUpdates(
            using: CMAttitudeReferenceFrame.xTrueNorthZVertical,
            to: mainQueue) { (motion, error) in
                
                // Ensure that we have a CMDeviceMotion to work with
                guard let motion = motion else {
                    if let error = error {
                        print("Failed to get motion: \(error)")
                    }
                    return
                }
                
                let yaw = motion.attitude.yaw
                
                let yawDegrees = yaw * 180 / .pi
                
                self.directionLabel.text = String(format:"Direction: %.0f°", yawDegrees)
                
        }
        // END compass
    }
    
    var motionManager = CMMotionManager()

}

