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
        
// BEGIN usage
if let url = NSBundle.mainBundle().URLForResource("TestSound",
    withExtension: "wav") {
    let player = AVAudioPlayerPool.playerWithURL(url)
    player?.play()
}
// END usage

    }
    
    @IBAction func playSound2(sender : AnyObject) {
        if let url = NSBundle.mainBundle().URLForResource("ReceiveMessage", withExtension: "aif") {
            let player = AVAudioPlayerPool.playerWithURL(url)
            player?.play()
        }
    }
    
    @IBAction func playSound3(sender : AnyObject) {
        if let url = NSBundle.mainBundle().URLForResource("SendMessage", withExtension: "aif") {
            let player = AVAudioPlayerPool.playerWithURL(url)
            player?.play()
        }
    }

}

