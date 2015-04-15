//
//  ViewController.swift
//  UsingDynamics
//
//  Created by Jon Manning on 14/01/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var animatedView: UIView!
    
// BEGIN animator_storage
var animator : UIDynamicAnimator?
// END animator_storage

    override func viewDidLoad() {
        super.viewDidLoad()
        
// BEGIN animator_create
self.animator = UIDynamicAnimator(referenceView: self.view)
// END animator_create

// BEGIN gravity
let gravity = UIGravityBehavior(items: [self.animatedView])
        
self.animator?.addBehavior(gravity)
// END gravity

// BEGIN collision
let collision = UICollisionBehavior(items: [self.animatedView])
        
collision.translatesReferenceBoundsIntoBoundary = true
        
self.animator?.addBehavior(collision)
// END collision
        
// BEGIN collision_inset_bounds
collision.setTranslatesReferenceBoundsIntoBoundaryWithInsets(
    UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
// END collision_inset_bounds
        
// BEGIN attachment
// Anchor = top of the screen, centered
let anchor = CGPoint(x: self.view.bounds.width / 2, y: 0)
        
let attachment = UIAttachmentBehavior(item: self.animatedView,
    attachedToAnchor: anchor)
        
self.animator?.addBehavior(attachment)
// END attachment

        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

