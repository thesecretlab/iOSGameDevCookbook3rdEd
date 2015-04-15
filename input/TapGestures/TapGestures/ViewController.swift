//
//  ViewController.swift
//  TapGestures
//
//  Created by Jon Manning on 16/01/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // BEGIN tap
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self,
            action: "tapped:")
        
        // In this case, we're adding it to the view controllers'
        // view, but you can add it to any view
        self.view.addGestureRecognizer(tap)
    }
    
    func tap(tapRecognizer : UITapGestureRecognizer) {
        if tapRecognizer.state == UIGestureRecognizerState.Ended {
            NSLog("View was tapped!")
        }
    }
    // END tap

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

