//
//  ViewController.swift
//  MultiplePlayers
//
//  Created by Jon Manning on 3/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func playSound1(sender : AnyObject) {
        
        // BEGIN multipleplayers_usage
        if let url = Bundle.main.url(forResource: "TestSound",
                                                          withExtension: "wav") {
            let player = AVAudioPlayerPool.player(url: url)
            player?.play()
        }
        // END multipleplayers_usage
        
    }
    
    @IBAction func playSound2(sender : AnyObject) {
        if let url = Bundle.main.url(forResource: "ReceiveMessage", withExtension: "aif") {
            let player = AVAudioPlayerPool.player(url: url)
            player?.play()
        }
    }
    
    @IBAction func playSound3(sender : AnyObject) {
        if let url = Bundle.main.url(forResource: "SendMessage", withExtension: "aif") {
            let player = AVAudioPlayerPool.player(url: url)
            player?.play()
        }
    }
    
}

