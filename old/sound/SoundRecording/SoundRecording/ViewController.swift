//
//  ViewController.swift
//  SoundRecording
//
//  Created by Jon Manning on 3/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    var audioRecorder : AVAudioRecorder?
    var audioPlayer : AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var destinationURL = self.audioRecordingURL()
        
// BEGIN setup
// destinationURL is the location of where we want to store our recording
var error : NSError?
        
audioRecorder = AVAudioRecorder(URL:destinationURL, settings:nil, error:&error)
        
if (error != nil) {
    println("Couldn't create a recorder: \(error)")
}
        
audioRecorder?.prepareToRecord()
// END setup

    }

    func audioRecordingURL() -> NSURL {
// BEGIN documents_url
let documentsURL = NSFileManager.defaultManager()
    .URLsForDirectory(NSSearchPathDirectory.DocumentDirectory,
        inDomains:NSSearchPathDomainMask.UserDomainMask).last as! NSURL
// END documents_url
        
// BEGIN filename
return documentsURL.URLByAppendingPathComponent("RecordedSound.wav")
// END filename

    }
    

    @IBAction func startRecording(sender : UIButton) {
        
        if (audioRecorder?.recording == true) {
// BEGIN stop
audioRecorder?.stop()
// END stop
            sender.setTitle("Start Recording", forState:UIControlState.Normal)
        } else {
// BEGIN record
audioRecorder?.record()
// END record
            sender.setTitle("Stop Recording", forState:UIControlState.Normal)
        }

    }
    
    @IBAction func playRecording(sender : UIButton) {
        audioPlayer = AVAudioPlayer(contentsOfURL:self.audioRecordingURL(), error:nil)
        
        audioPlayer?.play()
        
    }
    
    
}
            
           