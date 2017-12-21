//
//  ViewController.swift
//  AddingImages
//
//  Created by Jon Manning on 14/01/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // BEGIN imagenamed
        let image = UIImage(named: "Spaceship")
        // END imagenamed
        
        // this line of code exists to prevent a warning of 'image'
        // being unused
        _ = image
        
    }

}

