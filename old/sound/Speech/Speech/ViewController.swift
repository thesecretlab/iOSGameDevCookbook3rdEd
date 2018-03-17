//
//  ViewController.swift
//  Speech
//
//  Created by Jon Manning on 3/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    // BEGIN create
    var speechSynthesizer = AVSpeechSynthesizer()
    // END create
    
    @IBOutlet weak var textToSpeakField : UITextField!

    @IBAction func speakText(sender : AnyObject) {
        
        /* Stopping speech:

        // BEGIN stop
        // Stop speaking immediately
        self.speechSynthesizer.pauseSpeakingAtBoundary(AVSpeechBoundary.Immediate)
        // Stop speaking after the current word
        self.speechSynthesizer.pauseSpeakingAtBoundary(AVSpeechBoundary.Word)
        // END stop
        
        // Continuing speech:
        // BEGIN continue
        self.speechSynthesizer.continueSpeaking()
        // END continue
        
        */
        
        // Generate a new utterance from a string
        // BEGIN utterance
        let utterance = AVSpeechUtterance(string:self.textToSpeakField.text)
        // END utterance
        
        // Speak the utterance
        // BEGIN speak
        self.speechSynthesizer.speakUtterance(utterance)
        // END speak
    }
    
    
}

