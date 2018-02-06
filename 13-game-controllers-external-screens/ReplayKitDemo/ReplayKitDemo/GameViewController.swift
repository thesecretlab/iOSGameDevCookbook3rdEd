//
//  GameViewController.swift
//  ReplayKitDemo
//
//  Created by Jon Manning on 2/2/18.
//  Copyright © 2018 Jon Manning. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

// BEGIN replaykit_import
import ReplayKit
// END replaykit_import

class GameViewController: UIViewController {
    
    @IBOutlet weak var toolbar: UIToolbar!
    
    @IBOutlet weak var recordingControlButton: UIBarButtonItem!
    
    enum RecordingMode {
        case recording, notRecording
    }
    
    func updateRecordButton(mode: RecordingMode) {
        
        recordingControlButton.target = self
        
        switch mode {
        case .recording:
            recordingControlButton.title = "Stop Recording"
            recordingControlButton.action = #selector(GameViewController.stopRecording)
        case .notRecording:
            recordingControlButton.title = "Start Recording"
            recordingControlButton.action = #selector(GameViewController.startRecording)
        }
    }
    
    @objc func startRecording(_ sender: Any) {
        
        // BEGIN replaykit_recorder
        let recorder = RPScreenRecorder.shared()
        // END replaykit_recorder
        
        // BEGIN replaykit_recorder_configure
        recorder.isMicrophoneEnabled = true
        
        // Requires "Privacy - Camera Usage Description"
        // in Info.plist to be set
        recorder.isCameraEnabled = true
        // END replaykit_recorder_configure
        
        // BEGIN replaykit_record
        recorder.startRecording { (error) in
            // handle error
            
            if let error = error {
                print("Error starting recording: \(error)")
            } else {
                print("Recording started successfully")
                
                // BEGIN replaykit_record_skip
                OperationQueue.main.addOperation {
                    self.updateRecordButton(mode: .recording)
                    
                }
                // END replaykit_record_skip
                
            }
            
        }
        // END replaykit_record
    }
    
    @objc func stopRecording(_ sender: Any) {
        // Show the start button
        let recorder = RPScreenRecorder.shared()
        
        // BEGIN replaykit_stop
        recorder.stopRecording { (viewController, error) in
            
            if let error = error {
                print("Error finishing recording: \(error)")
            } else if let viewController = viewController {
                viewController.previewControllerDelegate = self
                self.present(viewController, animated: true, completion: nil)
            } else {
                fatalError("Didn't get an error or a view controller?")
            }
            
        }
        // END replaykit_stop
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
        updateRecordButton(mode: .notRecording)
        
        
        
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

// BEGIN replaykit_delegate
extension GameViewController : RPPreviewViewControllerDelegate {
    
    func previewControllerDidFinish(_ previewController: RPPreviewViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
// END replaykit_delegate
