//
//  ViewController.swift
//  SimpleAudioPlayer
//
//  Created by Jon Manning on 3/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

// BEGIN avfoundation_import
import AVFoundation
// END avfoundation_import

class ViewController: UIViewController {
    
    var audioPlayer : AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // BEGIN creating
        // BEGIN resource
        guard let soundFileURL = Bundle.main.url(forResource: "TestSound",
                                                 withExtension:"wav") else {
                                                    print("URL not found")
                                                    return
        }
        // END resource
        
        // BEGIN create
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundFileURL)
        } catch let error {
            print("Failed to load the sound: \(error)")
        }
        // END create
        
        audioPlayer?.prepareToPlay()
        // END creating
        
    }
    
    @IBAction func playSound(sender : AnyObject) {
        
        // BEGIN play
        audioPlayer?.play()
        // END play
        
        /* 
         // BEGIN pause_stop
         // To pause:
         audioPlayer?.pause()
         // To stop:
         audioPlayer?.stop()
         // END pause_stop
         
         // To rewind:
         // BEGIN rewind
         audioPlayer.currentTime = 0
         // END rewind
         */
    }
    
    @IBAction func loopModeChanged(loopSwitch : UISwitch) {
        
        if (loopSwitch.isOn) {
            // BEGIN loop
            audioPlayer?.numberOfLoops = -1
            // END loop
        } else {
            // BEGIN no_loop
            audioPlayer?.numberOfLoops = 0
            // END no_loop
        }
        
        /* To loop one time (ie play twice):
         // BEGIN loop_once
         audioPlayer?.numberOfLoops = 1
         // END loop_once
         */
    }
}

