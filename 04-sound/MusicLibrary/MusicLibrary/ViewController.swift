//
//  ViewController.swift
//  MusicLibrary
//
//  Created by Jon Manning on 3/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit
import MediaPlayer

// BEGIN delegate
class ViewController: UIViewController, MPMediaPickerControllerDelegate {
    // END delegate
    
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var artistLabel : UILabel!
    @IBOutlet weak var albumLabel : UILabel!
    
    // BEGIN observer
    var trackChangedObserver : AnyObject?
    // END observer
    
    
    func updateTrackInformation() {
        // BEGIN track_info
        let musicPlayer = MPMusicPlayerController.systemMusicPlayer
        
        let currentTrack : MPMediaItem? = musicPlayer.nowPlayingItem
        let title = currentTrack?.value(forProperty: MPMediaItemPropertyTitle)
            as? String ?? "None"
        let artist = currentTrack?.value(forProperty: MPMediaItemPropertyArtist)
            as? String ?? "None"
        let album = currentTrack?.value(forProperty: MPMediaItemPropertyAlbumTitle)
            as? String ?? "None"
        
        self.titleLabel.text = title
        self.artistLabel.text = artist
        self.albumLabel.text = album
        // END track_info
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateTrackInformation()
        
        // BEGIN start_observe
        trackChangedObserver = NotificationCenter.default
            .addObserver(forName: .MPMusicPlayerControllerNowPlayingItemDidChange, object: nil, queue: OperationQueue.main) { (notification) -> Void in
                self.updateTrackInformation()
        }
        // END start_observe
        
        // BEGIN start_notify
        let musicPlayer = MPMusicPlayerController.systemMusicPlayer
        
        musicPlayer.beginGeneratingPlaybackNotifications()
        // END start_notify
        
    }
    
    // BEGIN stop_notify
    deinit {
        NotificationCenter.default.removeObserver(trackChangedObserver!)
    }
    // END stop_notify
    
    func setPlaybackState() {
        
        // BEGIN playback_control
        let musicPlayer = MPMusicPlayerController.systemMusicPlayer
        
        musicPlayer.play()
        musicPlayer.pause()
        musicPlayer.skipToBeginning()
        musicPlayer.skipToNextItem()
        musicPlayer.skipToPreviousItem()
        musicPlayer.beginSeekingForward()
        musicPlayer.beginSeekingBackward()
        musicPlayer.stop()
        // END playback_control
        
        
        //musicPlayer.playbackState
        
    }
    
    @IBAction func showMediaPicker()  {
        
        // BEGIN show_picker
        let picker = MPMediaPickerController(mediaTypes:MPMediaType.anyAudio)
        
        // BEGIN picking_multiple
        picker.allowsPickingMultipleItems = true
        // END picking_multiple
        // BEGIN picking_cloud
        picker.showsCloudItems = true
        // END picking_cloud
        
        picker.delegate = self
        
        self.present(picker, animated:false, completion:nil)
        // END show_picker
        
    }
    
    // BEGIN picker_delegate_methods
    func mediaPicker(mediaPicker: MPMediaPickerController!,
                     didPickMediaItems mediaItemCollection: MPMediaItemCollection!) {
        
        for item in mediaItemCollection.items {
            if let itemName = item.value(forProperty: MPMediaItemPropertyTitle)
                as? String {
                print("Picked item: \(itemName)")
            }
            
        }
        
        // BEGIN play_selection
        let musicPlayer = MPMusicPlayerController.systemMusicPlayer
        
        musicPlayer.setQueue(with: mediaItemCollection)
        
        musicPlayer.play()
        // END play_selection
        
        self.dismiss(animated: false, completion:nil)
    }
    
    func mediaPickerDidCancel(mediaPicker: MPMediaPickerController!) {
        self.dismiss(animated: false, completion:nil)
    }
    // END picker_delegate_methods
    
}




