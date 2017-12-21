//
//  ViewController.swift
//  Steering
//
//  Created by Jon Manning on 2/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    var motionManager = CMMotionManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
// BEGIN steer
motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue()) {
    (motion, error) -> Void in
            
    // Maximum steering left is -50 degrees, maximum steering right is
    // 50 degrees
    var maximumSteerAngle = 50.0
            
    // When in landscape,
    var rotationAngle = motion.attitude.pitch * 180.0 / M_PI
            
    // -1.0 = hard left, 1.0 = hard right
    var steering = 0.0
            
    var orientation = UIApplication.sharedApplication().statusBarOrientation
            
    if orientation == UIInterfaceOrientation.LandscapeLeft  {
        steering = rotationAngle / -maximumSteerAngle
    } else if orientation == UIInterfaceOrientation.LandscapeRight {
        steering = rotationAngle / maximumSteerAngle
    }
            
    // Limit the steering to between -1.0 and 1.0
    steering = fmin(steering, 1.0)
    steering = fmax(steering, -1.0)
            
    println("Steering: \(steering)")
}
// END steer

        
        
    }

    


}

