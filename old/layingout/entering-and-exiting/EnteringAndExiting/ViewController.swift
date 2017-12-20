//
//  ViewController.swift
//  EnteringAndExiting
//
//  Created by Jon Manning on 12/01/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // BEGIN enteringandexiting_example
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let center = NSNotificationCenter.defaultCenter()
        
        center.addObserver(self,
            selector: "applicationDidBecomeActive:",
            name: UIApplicationDidBecomeActiveNotification,
            object: nil)
        
        center.addObserver(self,
            selector: "applicationWillEnterForeground:",
            name: UIApplicationWillEnterForegroundNotification,
            object: nil)

        center.addObserver(self,
            selector: "applicationWillResignActive:",
            name: UIApplicationWillResignActiveNotification,
            object: nil)
        
        center.addObserver(self,
            selector: "applicationDidEnterBackground:",
            name: UIApplicationDidEnterBackgroundNotification,
            object: nil)
        
    }
    
    func applicationDidBecomeActive(notification : NSNotification) {
        NSLog("Application became active")
    }
    
    func applicationDidEnterBackground(notification : NSNotification) {
        NSLog("Application entered background - unload textures!")
    }

    func applicationWillEnterForeground(notification : NSNotification) {
        NSLog("Application will enter foreground - reload " +
            "any textures that were unloaded")
    }
    
    func applicationWillResignActive(notification : NSNotification) {
        NSLog("Application will resign active - pause the game now!")
    }
    
    deinit {
        // Remove this object from the notification center
        NSNotificationCenter.defaultCenter()
            .removeObserver(self)
    }
    // END enteringandexiting_example
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

