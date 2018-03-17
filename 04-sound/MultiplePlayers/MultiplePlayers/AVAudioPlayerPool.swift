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
    class func player(url : URL) -> AVAudioPlayer? {

        // Try and find a player that can be reused and is not playing
        let availablePlayers = players.filter { (player) -> Bool in
            return player.isPlaying == false && player.url == url
        }
        
        // If we found one, return it
        if let playerToUse = availablePlayers.first {
            print("Reusing player for \(url.lastPathComponent)")
            return playerToUse
        }
        
        // Didn't find one? Create a new one
        
        do {
            let newPlayer = try AVAudioPlayer(contentsOf: url)
            players.append(newPlayer)
            return newPlayer
        } catch let error {
            print("Couldn't load \(url.lastPathComponent): \(error)")
            return nil
        }
        
        
    }
    
}
// END pool
