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
        
        // BEGIN 3drotation_animation
        // BEGIN 3drotation_animation_create
        let animation = CABasicAnimation(keyPath: "transform.rotation.y")
        // END 3drotation_animation_create
        
        // BEGIN 3drotation_animation_from_to
        animation.fromValue = 0.0
        animation.toValue = .pi * 2.0
        // END 3drotation_animation_from_to
        
        // BEGIN 3drotation_animation_repeat
        animation.repeatCount = Float.infinity
        animation.duration = 2.0
        // END 3drotation_animation_repeat
        
        // BEGIN 3drotation_animation_add
        self.rotatingView.layer.add(animation, forKey: "spin")
        // END 3drotation_animation_add
        
        // BEGIN 3drotation_animation_transform
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / 500.0
        self.rotatingView.layer.transform = transform
        // END 3drotation_animation_transform
        // END 3drotation_animation
        
        // BEGIN 3drotation_animation_stop
        self.rotatingView.layer.removeAnimation(forKey: "spin")
        // END 3drotation_animation_stop

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

