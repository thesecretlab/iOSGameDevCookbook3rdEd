//
//  MainMenuViewController.swift
//  CreatingViewControllers
//
//  Created by Jon Manning on 14/01/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    // BEGIN outlet
    @IBOutlet weak var textField: UITextField!
    // END outlet
    
    // Example of an action method that takes no parameters:
    // BEGIN action_no_params
    @IBAction func actionWithNoParameters() {
        
    }
    // END action_no_params
    
    // BEGIN action
    @IBAction func buttonPressed(sender: AnyObject) {
    // END action
        
        // BEGIN alert_code
        let alert = UIAlertController(title: "Button tapped",
            message: "The button was tapped",
            preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK",
                                      style: UIAlertActionStyle.default,
            handler: nil))
        
        self.present(alert,
            animated: true, completion: nil)
        // END alert_code

        
    }
    

}
