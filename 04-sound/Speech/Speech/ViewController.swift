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
        self.speechSynthesizer.pauseSpeaking(at: AVSpeechBoundary.immediate)
        // Stop speaking after the current word
        self.speechSynthesizer.pauseSpeaking(at: AVSpeechBoundary.word)
        // END stop
        
        // Continuing speech:
        // BEGIN continue
        self.speechSynthesizer.continueSpeaking()
        // END continue
        
        */
        
        // Generate a new utterance from a string
        let textToSpeak = self.textToSpeakField.text ?? ""
        // BEGIN utterance
        let utterance = AVSpeechUtterance(string: textToSpeak)
        // END utterance
        
        // Speak the utterance
        // BEGIN speak
        self.speechSynthesizer.speak(utterance)
        // END speak
    }
    
    
}

