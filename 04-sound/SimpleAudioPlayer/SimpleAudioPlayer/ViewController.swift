//
//  ViewController.swift
//  SimpleAudioPlayer
//
//  Created by Jon Manning on 3/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

// BEGIN player_avfoundation_import
import AVFoundation
// END player_avfoundation_import

class ViewController: UIViewController {
    
    var audioPlayer : AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // BEGIN player_creating
        // BEGIN player_resource
        guard let soundFileURL = Bundle.main.url(forResource: "TestSound",
                                                 withExtension:"wav") else {
                                                    print("URL not found")
                                                    return
        }
        // END player_resource
        
        // BEGIN player_create
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundFileURL)
        } catch let error {
            print("Failed to load the sound: \(error)")
        }
        // END player_create
        
        audioPlayer?.prepareToPlay()
        // END player_creating
        
    }
    
    @IBAction func playSound(sender : AnyObject) {
        
        // BEGIN player_play
        audioPlayer?.play()
        // END player_play
        
        /* 
         // BEGIN player_pause_stop
         // To pause:
         audioPlayer?.pause()
         // To stop:
         audioPlayer?.stop()
         // END player_pause_stop
         
         // To rewind:
         // BEGIN player_rewind
         audioPlayer.currentTime = 0
         // END player_rewind
         */
    }
    
    @IBAction func loopModeChanged(loopSwitch : UISwitch) {
        
        if (loopSwitch.isOn) {
            // BEGIN player_loop
            audioPlayer?.numberOfLoops = -1
            // END player_loop
        } else {
            // BEGIN player_no_loop
            audioPlayer?.numberOfLoops = 0
            // END player_no_loop
        }
        
        /* To loop one time (ie play twice):
         // BEGIN player_loop_once
         audioPlayer?.numberOfLoops = 1
         // END player_loop_once
         */
    }
}

