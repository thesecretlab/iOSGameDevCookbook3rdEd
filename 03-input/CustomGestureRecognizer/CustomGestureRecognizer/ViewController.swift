//
//  ViewController.swift
//  CustomGestureRecognizer
//
//  Created by Jon Manning on 16/01/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

// BEGIN example
class ViewController: UIViewController {
    
    @IBOutlet weak var customGestureView : UIView!
    @IBOutlet weak var customGestureStatusLabel : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let downUp = #selector(ViewController.downUp(downUpGesture:))
        
        let downUpGesture = DownUpGestureRecognizer(target:self, action:downUp)
        
        self.customGestureView.addGestureRecognizer(downUpGesture)

    }
    
    @objc func downUp(downUpGesture: DownUpGestureRecognizer) {
        
        switch downUpGesture.state {
        case .began:
            self.customGestureStatusLabel.text = "Gesture began"
            
        case .changed:
            self.customGestureStatusLabel.text = "Gesture changed, phase = " +
            "\(downUpGesture.phase)"
            
        case .ended:
            self.customGestureStatusLabel.text = "Gesture ended"
            
        case .cancelled:
            self.customGestureStatusLabel.text = "Gesture cancelled"
            
        case .possible:
            self.customGestureStatusLabel.text = "Gesture possible"
            
        case .failed:
            self.customGestureStatusLabel.text = "Gesture failed"
            
            
        }
    }

}
// END example

