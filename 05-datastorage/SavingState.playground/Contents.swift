//: Playground - noun: a place where people can play

import UIKit

// BEGIN serialization_data
// The list of achievements that the player can get.
enum Achievements : String, Codable {
    case startedPlaying
    case finishedGameInTenMinutes
    case foundAllSecretRooms
}

// The data that represents a saved game.
class SavedGame : Codable {
    
    var levelNumber = 0
    var playerName = ""
    
    var achievements : Set<Achievements> = []
    
}

let savedGame = SavedGame()

// Store some data
savedGame.levelNumber = 3
savedGame.playerName = "Grabthar"
savedGame.achievements.insert(Achievements.foundAllSecretRooms)
// END serialization_data


// BEGIN serialization_encoding
do {
    // Encode the data
    let encoder = JSONEncoder()

    let data = try encoder.encode(savedGame)
    
    // We can now write the data to disk
} catch let error {
    print("Failed to encode the saved game! \(error)")
}
// END serialization_encoding

// BEGIN serialization_decoding
let decoder = JSONDecoder()

//try! decoder.decode(SavedGame.self, from: data)
// END serialization_decoding
