//
//  ViewController.swift
//  Grid
//
//  Created by Jon Manning on 13/01/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var grid = Grid()
        
        grid.addObject("Hello", atPosition: GridPoint(x: 0, y: 0))
        
        grid.objectsAtPosition(GridPoint(x: 0, y: 0))
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

