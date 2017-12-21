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

    var motionManager = CMMotionManager()
    
    override func viewDidLoad() {
        
        var mainQueue = NSOperationQueue.mainQueue()
        
// BEGIN compass
        
motionManager.startDeviceMotionUpdatesUsingReferenceFrame(
    CMAttitudeReferenceFrame.XTrueNorthZVertical,
    toQueue: mainQueue) { (motion, error) in
    var yaw = motion.attitude.yaw
            
    var yawDegrees = yaw * 180 / M_PI
            
    self.directionLabel.text = String(format:"Direction: %.0f°", yawDegrees)
            
}
// END compass
    }
    



}

