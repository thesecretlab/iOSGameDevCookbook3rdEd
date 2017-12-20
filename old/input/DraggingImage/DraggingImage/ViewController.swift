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
        self.draggedView.userInteractionEnabled = true
        // END interaction
        
        // BEGIN setup
        let drag = UIPanGestureRecognizer(target: self,
            action: "dragged:")
        self.draggedView.addGestureRecognizer(drag)
        // END setup
    }
    
    // BEGIN dragfunc
    func dragged(dragGesture: UIPanGestureRecognizer) {
        
        if dragGesture.state == .Began ||
            dragGesture.state == .Changed {
                
                var newPosition = dragGesture.translationInView(dragGesture.view!)
                
                newPosition.x += dragGesture.view!.center.x
                newPosition.y += dragGesture.view!.center.y
                
                dragGesture.view!.center = newPosition
                
                dragGesture.setTranslation(CGPointZero,
                    inView: dragGesture.view)
        }
        
    }
    // END dragfunc
    // END drag


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

