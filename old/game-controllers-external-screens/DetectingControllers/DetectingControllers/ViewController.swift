//
//  ViewController.swift
//  DetectingControllers
//
//  Created by Jon Manning on 15/01/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

// BEGIN import
import GameController
// END import

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
// BEGIN list_controllers
for controller in GCController.controllers() as! [GCController] {
    NSLog("Found a controller: \(controller)")
}
// END list_controllers

        
// BEGIN wireless_search
// Once called, you'll receive
// GCControllerDidConnectNotification and
// GCControllerDidDisconnectNotification for
// wireless devices
GCController.startWirelessControllerDiscoveryWithCompletionHandler { () -> Void in
    NSLog("Finished searching for wireless controllers")
}
// END wireless_search

        
// BEGIN notifications
NSNotificationCenter.defaultCenter().addObserver(self,
    selector: "controllerConnected:", name: GCControllerDidConnectNotification, object: nil)
        
NSNotificationCenter.defaultCenter().addObserver(self,
    selector: "controllerDisconnected:", name: GCControllerDidDisconnectNotification, object: nil)
// END notifications

        
        
    }
    
    func controllerConnected(notification: NSNotification) {
        let controller = notification.object as! GCController
        
        NSLog("Controller connected: \(controller.vendorName)")
        
// BEGIN controller_type
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
// END controller_type

        
        // Check if this controller is physically connected
// BEGIN attached
if controller.attachedToDevice {
    NSLog("This gamepad is physically attached")
} else {
    NSLog("This gamepad is wireless")
}
// END attached

        
        // Turn on the first light on the controller
// BEGIN playerindex
controller.playerIndex = 0
// END playerindex
        
        // Getting info from the controller
// BEGIN button_values
// Pressed (true/false)
let isButtonAPressed = controller.gamepad.buttonA.pressed
        
// Pressed amount (0.0 .. 1.0)
let buttonAPressAmount = controller.gamepad.buttonA.value
// END button_values
        
// BEGIN axis_values
let horizontalAxis = controller.gamepad.dpad.xAxis
        
// Alternatively, just ask if the left button is pressed
let isLeftDirectionPressed = controller.gamepad.dpad.left.pressed
// END axis_values
        
// BEGIN valuechanged
controller.gamepad.buttonA.valueChangedHandler
    = { (input: GCControllerButtonInput!, value:Float, pressed:Bool) in
                
        NSLog("Button A pressed: \(pressed)")
                
}
// END valuechanged

        
// BEGIN pause
controller.controllerPausedHandler =
    { (controller: GCController!) in
                
    NSLog("Pause button pressed")
                
}
// END pause

    }

    func controllerDisconnected(notification: NSNotification) {
        let controller = notification.object as! GCController
        NSLog("Controller disconnected: \(controller.vendorName)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

