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
    print(String(data: data, encoding: .utf8)!)
} catch let error {
    print("Failed to encode the saved game! \(error)")
}
// END serialization_encoding

let string = """
{"achievements":["foundAllSecretRooms"],"levelNumber":3,"playerName":"Grabthar"}
"""

/*
 //This results in the following:
// BEGIN serialization_example
{"achievements":["foundAllSecretRooms"],"levelNumber":3,"playerName":"Grabthar"}
// END serialization_example
*/

let data = string.data(using: .utf8)!

// BEGIN serialization_decoding
var decodedSavedGame : SavedGame?

do {
    let decoder = JSONDecoder()
    
    decodedSavedGame = try decoder.decode(SavedGame.self, from: data)
} catch let error {
    print("Failed to decode the saved game! \(error)")
}

// 'decodedSavedGame' will now be either nil or contain a SavedGame object
decodedSavedGame?.playerName // = "Grabthar"
// END serialization_decoding

// BEGIN serialization_get_url
let fileManager = FileManager.default
guard let documentsURL = fileManager.urls(
    for: FileManager.SearchPathDirectory.documentDirectory,
    in:FileManager.SearchPathDomainMask.userDomainMask).last else {
        
        fatalError("Failed to find the documents folder!")
}

let savedGameURL = documentsURL
    .appendingPathComponent("SavedGame.json")
// END serialization_get_url

// BEGIN serialization_write_data
do {
    try data.write(to: savedGameURL)
} catch let error {
    print("Error writing: \(error)")
}
// END serialization_write_data

// BEGIN serialization_read_data
var loadedData : Data?

do {
    loadedData = try Data(contentsOf: savedGameURL)
} catch let error {
    print("Error reading: \(error)")
}

// END serialization_read_data

