//
//  ViewController.swift
//  DraggingImage
//
//  Created by Jon Manning on 16/01/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var draggedView: UIView!
    
    // BEGIN dragging_drag
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // BEGIN dragging_interaction
        self.draggedView.isUserInteractionEnabled = true
        // END dragging_interaction
        
        // BEGIN dragging_setup
        let dragged = #selector(ViewController.dragged(dragGesture:))
        
        let drag = UIPanGestureRecognizer(target: self,
                                          action: dragged)
        self.draggedView.addGestureRecognizer(drag)
        // END dragging_setup
    }
    
    // BEGIN dragging_dragfunc
    @objc func dragged(dragGesture: UIPanGestureRecognizer) {
        
        if dragGesture.state == .began ||
            dragGesture.state == .changed {
            
            var newPosition = dragGesture.translation(in: dragGesture.view!)
            
            newPosition.x += dragGesture.view!.center.x
            newPosition.y += dragGesture.view!.center.y
            
            dragGesture.view!.center = newPosition
            
            dragGesture.setTranslation(CGPoint.zero,
                                       in: dragGesture.view)
        }
        
    }
    // END dragging_dragfunc
    // END dragging_drag
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

