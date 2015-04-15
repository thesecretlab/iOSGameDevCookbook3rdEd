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
            preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK",
            style: UIAlertActionStyle.Default,
            handler: nil))
        
        self.presentViewController(alert,
            animated: true, completion: nil)
        // END alert_code

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
