//
//  ViewController.swift
//  OverlayingMenus
//
//  Created by Jon Manning on 14/01/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func showPauseMenu(sender: AnyObject) {
        
        // BEGIN load_nib
        // Load the nib
        let nib = UINib(nibName: "PauseMenu", bundle: nil)
        
        // Instantiate a copy of the objects stored in the nib
        let loadedObjects = nib.instantiateWithOwner(self,
            options: nil)
        // END load_nib

        // BEGIN add_view
        // Try to get the first object, as a UIView
        if let pauseMenuView = loadedObjects[0] as? UIView {
            // Add it to the screen and center it
            self.view.addSubview(pauseMenuView)
            pauseMenuView.center = self.view.center
        }
        // END add_view
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

