//
//  ViewController.swift
//  ExternalDisplays
//
//  Created by Jon Manning on 15/01/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // BEGIN externaldisplay_log
        for connectedScreen in UIScreen.screens {
            if connectedScreen == UIScreen.main {
                NSLog("Main screen: \(connectedScreen)")
            } else {
                NSLog("External screen: \(connectedScreen)")
            }
        }
        // END externaldisplay_log
        
        // Getting the main screen:
        // BEGIN externaldisplay_mainscreen
        let mainScreen = UIScreen.main
        // END externaldisplay_mainscreen
        
        _ = mainScreen
        
        // BEGIN externaldisplay_external_screen
        if UIScreen.screens.count >= 2 {
            
            // This next step requires that there's a view controller
            // in the storyboard with the Identifier "ExternalScreen"
            let viewController = self.storyboard?
                .instantiateViewController(withIdentifier: "ExternalScreen")
            
            // Try and get the last screen..
            if let connectedScreen = UIScreen.screens.last {
                
                // Create a window, and put the view controller in it
                let window = UIWindow(frame: connectedScreen.bounds)
                window.rootViewController = viewController
                window.makeKeyAndVisible()
                
                // Put the window on the screen.
                window.screen = connectedScreen
            }
        }
        // END externaldisplay_external_screen
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

