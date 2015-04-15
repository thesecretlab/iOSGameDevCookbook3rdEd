//
//  ViewController.swift
//  RotatingIn3D
//
//  Created by Jon Manning on 14/01/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {

    @IBOutlet weak var rotatingView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // BEGIN animation
        // BEGIN animation_create
        let animation = CABasicAnimation(keyPath: "transform.rotation.y")
        // END animation_create
        
        // BEGIN animation_from_to
        animation.fromValue = 0.0
        animation.toValue = M_PI * 2.0
        // END animation_from_to
        
        // BEGIN animation_repeat
        animation.repeatCount = Float.infinity
        animation.duration = 2.0
        // END animation_repeat
        
        // BEGIN animation_add
        self.rotatingView.layer.addAnimation(animation, forKey: "spin")
        // END animation_add
        
        // BEGIN animation_transform
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / 500.0
        self.rotatingView.layer.transform = transform
        // END animation_transform
        // END animation
        
        // BEGIN animation_stop
        self.rotatingView.layer
            .removeAnimationForKey("spin")
        // END animation_stop

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

