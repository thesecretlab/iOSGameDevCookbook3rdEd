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
    
    // BEGIN drag
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // BEGIN interaction
        self.draggedView.isUserInteractionEnabled = true
        // END interaction
        
        // BEGIN setup
        let dragged = #selector(ViewController.dragged(dragGesture:))
        
        let drag = UIPanGestureRecognizer(target: self,
                                          action: dragged)
        self.draggedView.addGestureRecognizer(drag)
        // END setup
    }
    
    // BEGIN dragfunc
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
    // END dragfunc
    // END drag
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

