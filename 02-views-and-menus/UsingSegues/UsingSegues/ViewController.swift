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
        self.performSegue(withIdentifier: "ShowPopup",
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            NSLog("About to run \(identifier)")
        }
    }
    // END prepare_for_segue



}

