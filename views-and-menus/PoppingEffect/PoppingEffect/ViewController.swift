//
//  ViewController.swift
//  PoppingEffect
//
//  Created by Jon Manning on 14/01/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

// BEGIN quartzcore
import QuartzCore
// END quartzcore

class ViewController: UIViewController {

    @IBOutlet weak var poppingView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
// BEGIN pop
let keyframeAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        
keyframeAnimation.keyTimes = [0.0, 0.7, 1.0]
        
keyframeAnimation.values = [0.0, 1.2, 1.0]
        
keyframeAnimation.duration = 0.4
        
keyframeAnimation.timingFunction =
    CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
self.poppingView.layer.addAnimation(keyframeAnimation,
    forKey: "pop")
// END pop

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

