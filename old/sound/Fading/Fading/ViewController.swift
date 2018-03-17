//
//  ViewController.swift
//  Fading
//
//  Created by Jon Manning on 3/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var audioPlayer : AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSBundle.mainBundle().URLForResource("Beacon_Combat_High", withExtension:"m4a")
        
        audioPlayer = AVAudioPlayer(contentsOfURL:url, error:nil)
        
        audioPlayer?.numberOfLoops = -1
        audioPlayer?.volume = 1.0
        
        self.audioPlayer?.play()
    }
    
    @IBAction func fadeIn(sender : AnyObject) {
// BEGIN fading_in
fadePlayer(audioPlayer!, fromVolume: 0.0, toVolume: 1.0, overTime: 1.0)
// END fading_in
    }

    @IBAction func fadeOut(sender : AnyObject) {
// BEGIN fading_out
fadePlayer(audioPlayer!, fromVolume: 1.0, toVolume: 0.0, overTime: 1.0)
// END fading_out
    }
    
// BEGIN fading
func fadePlayer(player: AVAudioPlayer,
    fromVolume startVolume : Float,
    toVolume endVolume : Float,
    overTime time : Float) {
        
        // Update the volume every 1/100 of a second
        var fadeSteps : Int = Int(time) * 100
        // Work out how much time each step will take
        var timePerStep : Float = 1 / 100.0
        
        self.audioPlayer?.volume = startVolume;
            
        // Schedule a number of volume changes
        for step in 0...fadeSteps {
                
            let delayInSeconds : Float = Float(step) * timePerStep
            
            let popTime = dispatch_time(DISPATCH_TIME_NOW,
                Int64(delayInSeconds * Float(NSEC_PER_SEC)));
            dispatch_after(popTime, dispatch_get_main_queue()) {

                let fraction = (Float(step) / Float(fadeSteps))
                    
                player.volume = startVolume + (endVolume - startVolume) * fraction

            }
        }
}
// END fading

    
    


}

// We had to move this out of the main code to prevent
// code indentation issues - it's the same as the code above
// - JM

/*
// BEGIN fade_steps
// Update the volume every 1/100 of a second
var fadeSteps : Int = Int(time) * 100
// Work out how much time each step will take
var timePerStep : Float = 1 / 100.0
// END fade_steps

// BEGIN start_volume
self.audioPlayer?.volume = startVolume;
// END start_volume

// BEGIN step_loop_start
for step in 0...fadeSteps {
    
    let delayInSeconds : Float = Float(step) * timePerStep
// END step_loop_start

// BEGIN schedule_volume
let popTime = dispatch_time(DISPATCH_TIME_NOW,
    Int64(delayInSeconds * Float(NSEC_PER_SEC)));
dispatch_after(popTime, dispatch_get_main_queue()) {
// END schedule_volume

// BEGIN apply_volume
let fraction = (Float(step) / Float(fadeSteps))
    
player.volume = startVolume + (endVolume - startVolume) * fraction
// END apply_volume

*/