//
//  ViewController.swift
//  DetectingControllers
//
//  Created by Jon Manning on 15/01/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

// BEGIN controllers_import
import GameController
// END controllers_import

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // BEGIN controllers_list_controllers
        for controller in GCController.controllers() {
            NSLog("Found a controller: \(controller)")
        }
        // END controllers_list_controllers
        
        
        // BEGIN controllers_wireless_search
        // Once called, you'll receive
        // GCControllerDidConnectNotification and
        // GCControllerDidDisconnectNotification for
        // wireless devices
        GCController.startWirelessControllerDiscovery { () -> Void in
            NSLog("Finished searching for wireless controllers")
        }
        // END controllers_wireless_search
        
        
        // BEGIN controllers_notifications
        
        let connectedSelector = #selector(self.controllerConnected(notification:))
        let disconnectedSelector = #selector(self.controllerDisconnected(notification:))
        
        NotificationCenter.default.addObserver(self,
                                                       selector: connectedSelector,
                                                       name: .GCControllerDidConnect,
                                                       object: nil)
        
        NotificationCenter.default.addObserver(self,
                                                       selector: disconnectedSelector,
                                                       name: .GCControllerDidDisconnect,
                                                       object: nil)
        // END controllers_notifications
        
        
        
    }
    
    @objc func controllerConnected(notification: NSNotification) {
        guard let controller = notification.object as? GCController else {
            fatalError("controllerConnected didn't receive a controller?")
        }
        
        NSLog("Controller connected: \(controller.vendorName ?? "generic controller")")
        
        // BEGIN controllers_controller_type
        if controller.extendedGamepad != nil {
            // It's an extended gamepad
            NSLog("This is an extended gamepad")
        } else if controller.gamepad != nil {
            // It's a standard gamepad
            NSLog("This is a standard gamepad")
        } else {
            // It's something else entirely, and probably can't be used by your game\
            NSLog("I don't know what kind of gamepad this is")
        }
        // END controllers_controller_type
        
        
        // Check if this controller is physically connected
        // BEGIN controllers_attached
        if controller.isAttachedToDevice {
            NSLog("This gamepad is physically attached")
        } else {
            NSLog("This gamepad is wireless")
        }
        // END controllers_attached
        
        
        // Turn on the first light on the controller
        // BEGIN controllers_playerindex
        controller.playerIndex = GCControllerPlayerIndex.index1
        // END controllers_playerindex
        
        // Getting info from the controller
        // BEGIN controllers_button_values
        // Pressed (true/false)
        let isButtonAPressed = controller.gamepad?.buttonA.isPressed
        
        // Pressed amount (0.0 .. 1.0)
        let buttonAPressAmount = controller.gamepad?.buttonA.value
        // END controllers_button_values
        
        // BEGIN controllers_axis_values
        let horizontalAxis = controller.gamepad?.dpad.xAxis
        
        // Alternatively, just ask if the left button is pressed
        let isLeftDirectionPressed = controller.gamepad?.dpad.left.isPressed
        // END controllers_axis_values
        
        // BEGIN controllers_valuechanged
        controller.gamepad?.buttonA.valueChangedHandler
            = { (input: GCControllerButtonInput!, value:Float, pressed:Bool) in
                
                NSLog("Button A pressed: \(pressed)")
                
        }
        // END controllers_valuechanged
        
        
        // BEGIN controllers_pause
        controller.controllerPausedHandler =
            { (controller: GCController!) in
                
                NSLog("Pause button pressed")
                
        }
        // END controllers_pause
        
    }
    
    @objc func controllerDisconnected(notification: NSNotification) {
        let controller = notification.object as! GCController
        NSLog("Controller disconnected: \(controller.vendorName ?? "generic controller")")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

