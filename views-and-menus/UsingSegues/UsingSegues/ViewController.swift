//
//  ViewController.swift
//  UsingSegues
//
//  Created by Jon Manning on 14/01/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // BEGIN manual_segue
    @IBAction func showPopup(sender: AnyObject) {
        self.performSegueWithIdentifier("ShowPopup",
            sender: self)
    }
    // END manual_segue
    
    // BEGIN exit
    @IBAction func closePopup(segue: UIStoryboardSegue) {
        NSLog("Second view controller was closed!")
    }
    // END exit

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // BEGIN prepare_for_segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        NSLog("About to run \(segue.identifier)")
    }
    // END prepare_for_segue



}

