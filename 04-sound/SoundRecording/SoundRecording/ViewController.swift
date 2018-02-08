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
        
        let destinationURL = self.audioRecordingURL
        
        // BEGIN recording_setup
        // destinationURL is the location of where we want to store our recording
        
        do {
            audioRecorder = try AVAudioRecorder(url:destinationURL, settings: [:])
        } catch let error {
            print("Couldn't create a recorder: \(error)")
        }
        
        audioRecorder?.prepareToRecord()
        // END recording_setup
        
    }
    
    var audioRecordingURL : URL {
        // BEGIN recording_documents_url
        let documentsURL = FileManager.default
            .urls(for: FileManager.SearchPathDirectory.documentDirectory,
                  in:FileManager.SearchPathDomainMask.userDomainMask).last!
        // END recording_documents_url
        
        // BEGIN recording_filename
        return documentsURL.appendingPathComponent("RecordedSound.wav")
        // END recording_filename
        
    }
    
    
    @IBAction func startRecording(sender : UIButton) {
        
        if (audioRecorder?.isRecording == true) {
            // BEGIN recording_stop
            audioRecorder?.stop()
            // END recording_stop
            sender.setTitle("Start Recording", for:UIControlState.normal)
        } else {
            // BEGIN recording_record
            audioRecorder?.record()
            // END recording_record
            sender.setTitle("Stop Recording", for:UIControlState.normal)
        }
        
    }
    
    @IBAction func playRecording(sender : UIButton) {
        audioPlayer = try? AVAudioPlayer(contentsOf:self.audioRecordingURL)
        
        audioPlayer?.play()
        
    }
    
    
}


