//
//  ViewController.swift
//  UserDefaults
//
//  Created by Jon Manning on 4/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // BEGIN getting_defaults
        let defaults = NSUserDefaults.standardUserDefaults()
        // END getting_defaults
        
        
        // BEGIN using_defaults
        defaults.setValue("A string", forKey: "mySetting")
        
        let string = defaults.valueForKey("mySetting") as? String
        // END using_defaults
        
        // BEGIN sync
        defaults.synchronize()
        // END sync
        
        if true {
        // BEGIN value_doesnt_exist
        let levelNumber = defaults.integerForKey("currentLevel")
        // END value_doesnt_exist
        }

        // BEGIN register_defaults
        let defaultValues = ["currentLevel": 1]
        defaults.registerDefaults(defaultValues)
        
        let levelNumber = defaults.integerForKey("currentLevel")
        // levelNumber will be either 1, or whatever was last stored in NSUserDefaults.
        // END register_defaults
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

