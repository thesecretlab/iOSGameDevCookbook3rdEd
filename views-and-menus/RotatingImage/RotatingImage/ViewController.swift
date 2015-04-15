//
//  ViewController.swift
//  RotatingImage
//
//  Created by Jon Manning on 14/01/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var transformedView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
// BEGIN rotate
self.transformedView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
// END rotate
        
        // BEGIN transform
        var transform = CGAffineTransformIdentity // <1>
        transform = CGAffineTransformTranslate(transform, 50, 0) // <2>
        transform = CGAffineTransformRotate(transform, CGFloat(M_PI_2)) // <3>
        transform = CGAffineTransformScale(transform, 0.5, 2) // <4>
        
        self.transformedView.transform = transform // <5>
        // END transform
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

