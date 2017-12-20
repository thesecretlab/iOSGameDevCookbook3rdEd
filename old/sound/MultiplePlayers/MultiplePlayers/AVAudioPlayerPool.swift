//
//  AVAudioPlayerPool.swift
//  MultiplePlayers
//
//  Created by Jon Manning on 3/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit
import AVFoundation

// BEGIN pool
// An array of all players stored in the pool; not accessible
// outside this file
private var players : [AVAudioPlayer] = []

class AVAudioPlayerPool: NSObject {
   
    // Given the URL of a sound file, either create or reuse an audio player
    class func playerWithURL(url : NSURL) -> AVAudioPlayer? {

        // Try and find a player that can be reused and is not playing
        let availablePlayers = players.filter { (player) -> Bool in
            return player.playing == false && player.url == url
        }
        
        // If we found one, return it
        if let playerToUse = availablePlayers.first {
            println("Reusing player for \(url.lastPathComponent)")
            return playerToUse
        }
        
        // Didn't find one? Create a new one
        var error : NSError? = nil
        if let newPlayer = AVAudioPlayer(contentsOfURL:url, error:&error) {
            println("Creating new player for url \(url.lastPathComponent)")
            players.append(newPlayer)
            return newPlayer
        } else {
            // We might not be able to create one, so log and return nil
            println("Couldn't load \(url.lastPathComponent): \(error)")
            return nil

        }
    }
    
}
// END pool
