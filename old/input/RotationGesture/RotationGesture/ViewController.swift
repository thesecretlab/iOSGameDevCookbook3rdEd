//
//  ViewController.swift
//  RotationGesture
//
//  Created by Jon Manning on 16/01/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

// BEGIN rotation
class ViewController: UIViewController {
    
    @IBOutlet weak var rotationView: UIView!
    @IBOutlet weak var rotationStatusLabel: UILabel!

    // The current angle of the rotation, in radians
    var angle : Float = 0.0
    
    // Converts self.angle from radians to degrees,
    // and wrap around at 360 degrees
    var angleDegrees : Float {
        get {
            return self.angle * 180.0 / Float(M_PI) % 360.0
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the rotation gesture
        let rotationGesture = UIRotationGestureRecognizer(target: self,
            action: "rotated:")
        
        self.rotationView.userInteractionEnabled = true
        self.rotationView.addGestureRecognizer(rotationGesture)
        
        self.rotationStatusLabel?.text = "\(self.angleDegrees)°"
    }
    
    // When the rotation changes, update self.angle
    // and use that to rotate the view
    func rotated(rotationGesture : UIRotationGestureRecognizer) {
        
        switch rotationGesture.state {
            
        case .Changed:
            self.angle += Float(rotationGesture.rotation)
            
            rotationGesture.rotation = 0.0
            
            self.rotationView.transform =
                CGAffineTransformMakeRotation(CGFloat(self.angle))
            
        default: () // do nothing
            
        }
        
        // Display the rotation
        self.rotationStatusLabel?.text = "\(self.angleDegrees)°"
        
    }

}
// END rotation

