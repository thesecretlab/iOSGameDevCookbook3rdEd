//
//  ViewController.swift
//  ParallaxScrolling
//
//  Created by Jon Manning on 5/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the view.
        if let spriteView = self.view as? SKView {
            spriteView.showsFPS = true
            spriteView.showsNodeCount = true
            
            // Create and configure the scene.
            let scene = ParallaxScene(size: spriteView.bounds.size)
            scene.scaleMode = SKSceneScaleMode.AspectFill
            
            // Present the scene.
            spriteView.presentScene(scene)

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

