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
    
    // BEGIN speech_create
    var speechSynthesizer = AVSpeechSynthesizer()
    // END speech_create
    
    @IBOutlet weak var textToSpeakField : UITextField!

    @IBAction func speakText(sender : AnyObject) {
        
        /* Stopping speech:

        // BEGIN speech_stop
        // Stop speaking immediately
        self.speechSynthesizer.pauseSpeaking(at: AVSpeechBoundary.immediate)
        // Stop speaking after the current word
        self.speechSynthesizer.pauseSpeaking(at: AVSpeechBoundary.word)
        // END speech_stop
        
        // Continuing speech:
        // BEGIN speech_continue
        self.speechSynthesizer.continueSpeaking()
        // END speech_continue
        
        */
        
        // Generate a new utterance from a string
        let textToSpeak = self.textToSpeakField.text ?? ""
        // BEGIN speech_utterance
        let utterance = AVSpeechUtterance(string: textToSpeak)
        // END speech_utterance
        
        // Speak the utterance
        // BEGIN speech_speak
        self.speechSynthesizer.speak(utterance)
        // END speech_speak
    }
    
    
}

