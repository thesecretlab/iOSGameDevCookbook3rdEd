//
//  ViewController.swift
//  SelectingAirplayDevice
//
//  Created by Jon Manning on 15/01/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController {

    @IBOutlet weak var volumeControlContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // BEGIN volumeview
        let volumeView = MPVolumeView()
        volumeView.showsRouteButton = true
        volumeView.showsVolumeSlider = false
        
        volumeView.sizeToFit()
        
        self.volumeControlContainerView.addSubview(volumeView)
        // END volumeview
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "screenConnected:", name: UIScreenDidConnectNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "screenDisconnected:", name: UIScreenDidConnectNotification, object: nil)
        
    }
    
    deinit {

        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func screenConnected(notification: NSNotification) {
        // We'll receive this notification when airplay
        // is enabled and mirroring is turned on
    }
    
    func screenDisconnected(notification: NSNotification) {
        // We'll receive this notification when we lose
        // either airplay or mirroring
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

