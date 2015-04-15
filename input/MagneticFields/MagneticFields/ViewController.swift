//
//  ViewController.swift
//  MagneticFields
//
//  Created by Jon Manning on 2/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    var motionManager = CMMotionManager()
    
    @IBOutlet weak var magneticFieldXLabel : UILabel!
    @IBOutlet weak var magneticFieldYLabel : UILabel!
    @IBOutlet weak var magneticFieldZLabel : UILabel!
    @IBOutlet weak var magneticFieldAverageLabel : UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        
// BEGIN magnets
motionManager.startMagnetometerUpdatesToQueue(NSOperationQueue.mainQueue()) {
    (magnetometerData, error) -> Void in
            
    let magneticField = magnetometerData.magneticField
            
    let xValue = String(format:"%.2f", magneticField.x)
    let yValue = String(format:"%.2f", magneticField.y)
    let zValue = String(format:"%.2f", magneticField.z)
            
    let average = (magneticField.x + magneticField.y + magneticField.z) / 3.0
            
    let averageValue = String(format:"%.2f", average)
            
    self.magneticFieldXLabel.text = xValue
    self.magneticFieldYLabel.text = yValue
    self.magneticFieldZLabel.text = zValue
    self.magneticFieldAverageLabel.text = averageValue

}
// END magnets

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



    
}