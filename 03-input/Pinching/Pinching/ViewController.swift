//
//  ViewController.swift
//  Pinching
//
//  Created by Jon Manning on 16/01/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

// BEGIN pinching
class ViewController: UIViewController {
    
    @IBOutlet weak var scalingView: UIView!
    @IBOutlet weak var scalingStatusLabel: UILabel!
    
    // The current scale of the view (1.0 = normal scale)
    var scale : Float = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pinched = #selector(ViewController.pinched(pinchGesture:))
        
        // Set up the rotation gesture
        let rotationGesture = UIPinchGestureRecognizer(target: self,
                                                       action: pinched)
        
        self.scalingView.isUserInteractionEnabled = true
        self.scalingView.addGestureRecognizer(rotationGesture)
        
        self.scalingStatusLabel?.text = "\(self.scale)x"
    }
    
    // When the rotation changes, update self.angle
    // and use that to rotate the view
    @objc func pinched(pinchGesture : UIPinchGestureRecognizer) {
        
        switch pinchGesture.state {
            
        case .changed:
            self.scale *= Float(pinchGesture.scale)
            
            // BEGIN reset
            pinchGesture.scale = 1.0
            // END reset
            
            self.scalingView.transform =
                CGAffineTransform(scaleX: CGFloat(self.scale),
                                  y: CGFloat(self.scale))
            
        default: () // do nothing
            
        }
        
        // Display the current scale factor
        self.scalingStatusLabel?.text = "\(self.scale)x"
        
    }
    
}
// END pinching


