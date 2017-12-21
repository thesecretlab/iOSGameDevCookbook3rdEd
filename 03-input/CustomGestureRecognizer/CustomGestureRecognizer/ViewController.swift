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
        
        let downUpGesture = DownUpGestureRecognizer(target:self, action:"downUp:")
        
        self.customGestureView.addGestureRecognizer(downUpGesture)

    }
    
    func downUp(downUpGesture: DownUpGestureRecognizer) {
        
        switch downUpGesture.state {
        case .Began:
            self.customGestureStatusLabel.text = "Gesture began"
            
        case .Changed:
            self.customGestureStatusLabel.text = "Gesture changed, phase = " +
            "\(downUpGesture.phase)"
            
        case .Ended:
            self.customGestureStatusLabel.text = "Gesture ended"
            
        case .Cancelled:
            self.customGestureStatusLabel.text = "Gesture cancelled"
            
        case .Possible:
            self.customGestureStatusLabel.text = "Gesture possible"
            
        case .Failed:
            self.customGestureStatusLabel.text = "Gesture failed"
            
            
        }
    }

}
// END example

