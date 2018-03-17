//
//  ViewController.swift
//  SpriteWalkthrough
//
//  Created by Jon Manning on 5/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

// BEGIN import
import SpriteKit
// END import

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // BEGIN setup
        if let spriteView = self.view as? SKView {
            spriteView.showsDrawCount = true
            spriteView.showsFPS = true
            spriteView.showsNodeCount = true
        }
        // END setup

    }
    
    override func viewWillAppear(animated: Bool) {
        // BEGIN show_scene
        let scene = TestScene()
        scene.size = self.view.bounds.size
        if let spriteView = self.view as? SKView {
            spriteView.presentScene(scene)
        }
        // END show_scene
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
