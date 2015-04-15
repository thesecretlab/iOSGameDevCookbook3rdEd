//
//  ViewController.swift
//  GameCenter
//
//  Created by Jon Manning on 18/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit
import GameKit

class ViewController: UIViewController, GKGameCenterControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    var friends : [GKPlayer] = []

    @IBOutlet weak var scoreTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authenticatePlayer()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
// BEGIN authenticating_player
func authenticatePlayer() {
    if let localPlayer = GKLocalPlayer.localPlayer() {
        // Assigning a block to the localPlayer's
        // authenticateHandler kicks off the process
        // of authenticating the user with Game Center.
        localPlayer.authenticateHandler = {
            (viewController, error) in
                
            if viewController != nil {
                // We need to present a view controller
                // to finish the authentication process
                self.presentViewController(viewController,
                    animated: true, completion: nil)
                    
            } else if localPlayer.authenticated {
                // We're authenticated, and can now use Game Center features
                println("Authenticated!")
                self.playerAuthenticated()
                    
            } else if let theError = error {
                // We're not authenticated.
                println("Error! \(error)")
                self.playerFailedToAuthenticate(theError)
            }
        }
    }
}
// END authenticating_player
    
    func playerAuthenticated() {
// BEGIN player_info
let player = GKLocalPlayer.localPlayer()
self.usernameLabel.text = player.alias
        
player.loadPhotoForSize(GKPhotoSizeSmall, withCompletionHandler: {
    (image, error) -> Void in
            
    if let theError = error {
        println("Can't load image: \(error)")
    } else if let theImage = image {
        self.imageView.image = image
    }
})
// END player_info
        
// BEGIN loading_friends
GKLocalPlayer.localPlayer().loadFriendPlayersWithCompletionHandler {
    (friends, error) -> Void in
    // Log out info about each friend
    for friend in friends as! [GKPlayer] {
        println("Friend: \(friend.displayName)")
    }
    
    // Store friends in a property
    self.friends = friends as! [GKPlayer]

}
// END loading_friends
    }
    
    func playerFailedToAuthenticate(error: NSError) {
        
    }
    
    func getScore() -> Int {
        // Attempt to convert the text field to an Int, but
        // fall back to the value 1000 if we can't
        return scoreTextField.text.toInt() ?? 1000
    }

    @IBAction func logScore(sender: AnyObject) {
// BEGIN reporting_score
// Use your own leaderboard ID here
let leaderboardID = "main_leaderboard"
        
// Get the score from your game
let scoreValue : Int = getScore()
        
let score = GKScore(leaderboardIdentifier: leaderboardID)
score.value = Int64(scoreValue)
        
GKScore.reportScores([score], withCompletionHandler: { (error) -> Void in
    if error != nil {
        println("Failed to report score: \(error)")
    } else {
        println("Successfully logged score!")
    }
})
// END reporting_score

        
        
    }
    
    @IBAction func logScoreAndChallengeFriend(sender: AnyObject) {
        
// BEGIN submit_challenge

let leaderboardID = "main_leaderboard"
let playersToChallenge : [GKPlayer] = getPlayersToChallenge()
let message = "Try and beat this!"
        
// Get the score from your game
let scoreValue : Int = getScore()
        
let score = GKScore(leaderboardIdentifier: leaderboardID)
score.value = Int64(scoreValue)
        
let challengeComposeViewController =
    score.challengeComposeControllerWithMessage(message,
        players: playersToChallenge) {
            (viewController, didChallenge, playersChallenged) -> Void in
            
            if didChallenge {
                println("\(playersChallenged.count) players challenged")
            }
            
            self.dismissViewControllerAnimated(true, completion: nil)
}
        
self.presentViewController(challengeComposeViewController,
    animated: true, completion: nil)
// END submit_challenge
    }
    
    func getPlayersToChallenge() -> [GKPlayer] {
        return self.friends
    }
    
    @IBAction func showScores(sender: AnyObject) {
// BEGIN log_scores
GKLeaderboard.loadLeaderboardsWithCompletionHandler {
    (leaderboards, error) -> Void in
            
    // Log an error if we can't load leaderboards
    if error != nil {
        println("Can't load leaderboards: \(error)")
        return
    }
            
    // For each leaderboard, load scores for it
    for leaderboard in leaderboards as! [GKLeaderboard] {
                
        leaderboard.loadScoresWithCompletionHandler {
            (scores, error) -> Void in
            if error != nil {
                println("Can't load scores for leaderboard \(leaderboard.title): \(error)")
            } else {
                // Log these scores to the console
                println("Leaderboard \"\(leaderboard.title)\":")
                for score in scores as! [GKScore] {
                    println("\(score.player.alias) \(score.player.playerID) - \(score.value)")
                }
            }
        }
    }
}
// END log_scores
    }

    
    @IBAction func showGameCenter(sender: AnyObject) {
// BEGIN show_game_center
let gameCenterViewController = GKGameCenterViewController()
gameCenterViewController.gameCenterDelegate = self
self.presentViewController(gameCenterViewController,
    animated: true, completion: nil)
// END show_game_center
    }
    
// BEGIN dismiss_game_center
func gameCenterViewControllerDidFinish(
    gameCenterViewController: GKGameCenterViewController!) {
    self.dismissViewControllerAnimated(true, completion: nil)
}
// END dismiss_game_center

    @IBAction func startMatchmaking(sender: AnyObject) {
// BEGIN create_match_request
let matchRequest = GKMatchRequest()
        
matchRequest.maxPlayers = 2
matchRequest.minPlayers = 2
// END create_match_request
        
// BEGIN matchmaker_view_controller
let matchmakerViewController =
        GKMatchmakerViewController(matchRequest: matchRequest)
matchmakerViewController.matchmakerDelegate = self
self.presentViewController(matchmakerViewController,
    animated: true, completion: nil)
// END matchmaker_view_controller
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var deltaTime : Double {
        return 1.0;
    }
    
    var timeOfMostRecentPacket : NSTimeInterval = 0.0
    var timeOfSecondMostRecentPacket : NSTimeInterval = 0.0
    var interpolationTime = 0.0
    
    func interpolatePoint(point: CGPoint?, withPoint otherPoint: CGPoint?, amount : Double) -> CGPoint {
        return CGPoint(x: 0, y: 0)
    }
    
    func packetReceived() {
// BEGIN interpolation_data_received
timeOfSecondMostRecentPacket = timeOfMostRecentPacket
timeOfMostRecentPacket = NSDate.timeIntervalSinceReferenceDate()
interpolationTime = 0.0
// END interpolation_data_received
    }
    
    func updateFrame() {
        
        let object = ExampleNetworkedObject()
        
// BEGIN interpolation_each_frame
// Update interpolation time to include the time taken to render
// this frame
self.interpolationTime += deltaTime
        
// Work out how far we should interpolate between the second most
// recent known location and the most recent location
// Note that if we don't get info for a while, this value will go over
// 1.0, meaning that we'll be extrapolating
let interpolationPoint = interpolationTime /
    (timeOfMostRecentPacket - timeOfSecondMostRecentPacket)
        
// secondMostRecentKnownPosition and mostRecentKnownPosition
// should be updated every time we get new data
let origin = object.secondMostRecentKnownPosition
let destination = object.mostRecentKnownPosition
        
// Interpolate from the two known positions to get our current position
object.position = interpolatePoint(origin,
    withPoint: destination, amount: interpolationPoint)
// END interpolation_each_frame
    }
    
    

}

extension ViewController : GKMatchmakerViewControllerDelegate {
// BEGIN match_maker_delegate
func matchmakerViewController(viewController: GKMatchmakerViewController!,
    didFindMatch match: GKMatch!) {
    // We have a match, and can send data to other players using the GKMatch
    // object
    self.dismissViewControllerAnimated(true, completion: nil)
}
    
func matchmakerViewController(viewController: GKMatchmakerViewController!,
    didFailWithError error: NSError!) {
    // We failed to get a match
    self.dismissViewControllerAnimated(true, completion: nil)
}
    
func matchmakerViewControllerWasCancelled(
    viewController: GKMatchmakerViewController!) {
    // The user cancelled the match-maker
    self.dismissViewControllerAnimated(true, completion: nil)
}
// END match_maker_delegate

    

}

class ExampleNetworkedObject {
    var objectID : Int = 0
    var position : CGPoint = CGPoint(x: 0, y: 0)
    
    var mostRecentKnownPosition : CGPoint?
    var secondMostRecentKnownPosition : CGPoint?
}

// Create a block that will contain the data we're sending
// BEGIN data_block
struct DataBlock {
    var objectID : Int
    var position : (x: Float, y: Float)
}
// END data_block

extension ViewController : GKMatchDelegate {
// BEGIN match_player_disconnected
func match(match: GKMatch!, player: GKPlayer!,
    didChangeConnectionState state: GKPlayerConnectionState) {
    if state == GKPlayerConnectionState.StateDisconnected {
        // The player has disconnected; update the game's UI
    }
}
// END match_player_disconnected
    
// BEGIN match_should_reinvite
func match(match: GKMatch!,
    shouldReinviteDisconnectedPlayer player: GKPlayer!) -> Bool {
    return true
}
// END match_should_reinvite
}

extension ViewController {
    
    
    func exampleSendingObject() {
        let networkedObject = ExampleNetworkedObject()
        let match = GKMatch()
// BEGIN sending_data

// Store data in a block
var data = DataBlock(objectID: networkedObject.objectID,
    position: (x: Float(networkedObject.position.x),
        Float(networkedObject.position.y)))
        
// Convert it to an NSData
let dataToSend = NSData(bytes: &data, length: sizeof(DataBlock))
        
// Send the data
// match is a GKMatch, which you can get using the match-maker
var error : NSError?
match.sendDataToAllPlayers(dataToSend,
    withDataMode: GKMatchSendDataMode.Unreliable, error: &error)
        
if error != nil {
    println("Error sending data: \(error)")
}
// END sending_data
        
        
    }
    
    func findObjectWithID(id: Int) -> ExampleNetworkedObject? {
        return nil
    }
    
// BEGIN receiving_data
func dataReceived(data : NSData) {
    
    // Start with an empty datablock
    var objectInfo = DataBlock(objectID: 0, position: (x: 0, y: 0))
    
    // Fill it with data
    data.getBytes(&objectInfo, length: sizeof(DataBlock))
    
    // Get the object, and put the new data into it
    let object = findObjectWithID(objectInfo.objectID)
    
    object?.position = CGPoint(x: CGFloat(objectInfo.position.x),
                               y: CGFloat(objectInfo.position.y))
    }
// END receiving_data

}

extension ViewController {
    
    func getSaveData() -> NSData {
        return "Save Info".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
    }
    
    func useSavedGames() {
        
        
// BEGIN saving_game
let localPlayer = GKLocalPlayer.localPlayer()
        
let saveData : NSData = getSaveData()
        
localPlayer.saveGameData(getSaveData(), withName: "My Save") {
    (savedGame, error) -> Void in
    if error != nil {
        println("Error saving: \(error)")
    }
}
// END saving_game
        
// BEGIN fetching_saved_games
localPlayer.fetchSavedGamesWithCompletionHandler {
    (savedGames, error) -> Void in
    if error != nil {
        println("Failed to find games: \(error)")
        return
    }
            
    println("Found \(savedGames).count games")
    for save in savedGames as! [GKSavedGame] {
        // List each game
        println("- \(save.name): (from \(save.deviceName), modified \(save.modificationDate))")
                
        // Call save.loadDataWithCompletionHandler to get the data itself
    }
            
}
// END fetching_saved_games

// BEGIN delete_save
localPlayer.deleteSavedGamesWithName("My Save") { (error) -> Void in
    if error != nil {
        println("Error removing save: \(error)")
    }
}
// END delete_save
        
    }
    
}

extension ViewController : GKTurnBasedMatchmakerViewControllerDelegate {
    
    func beginTurnBasedMatch() {
// BEGIN begin_turnbased_match
let matchRequest = GKMatchRequest()
matchRequest.minPlayers = 2
matchRequest.maxPlayers = 2

let matchmaker = GKTurnBasedMatchmakerViewController(matchRequest: matchRequest)
matchmaker.turnBasedMatchmakerDelegate = self
self.presentViewController(matchmaker, animated: true, completion: nil)
// END begin_turnbased_match
    }
    
// BEGIN turnbased_delegate_methods
func turnBasedMatchmakerViewController(
    viewController: GKTurnBasedMatchmakerViewController!, didFailWithError error: NSError!) {
    // We failed to find a match
    self.dismissViewControllerAnimated(true, completion: nil)
}
    
func turnBasedMatchmakerViewController(
    viewController: GKTurnBasedMatchmakerViewController!, didFindMatch match: GKTurnBasedMatch!) {
    // We now have a match
    self.dismissViewControllerAnimated(true, completion: nil)
        
    // The match has now begun.
        
    if match.currentParticipant.player.playerID ==
        GKLocalPlayer.localPlayer().playerID {
        // We are the current player.
    } else {
        // Someone else is the current player.
    }
    
}
    
func turnBasedMatchmakerViewControllerWasCancelled(
    viewController: GKTurnBasedMatchmakerViewController!) {
    // The user closed the matchmaker without creating a match
    self.dismissViewControllerAnimated(true, completion: nil)
}
    
func turnBasedMatchmakerViewController(
    viewController: GKTurnBasedMatchmakerViewController!, playerQuitForMatch match: GKTurnBasedMatch!) {
    // We're quitting this game.
        
    self.dismissViewControllerAnimated(true, completion: nil)
        
    let matchData = match.matchData
    // Do something with the match data to reflect the fact that we're
    // quitting (e.g., give all of our buildings to someone else,
    // or remove them from the game)
        
    match.participantQuitInTurnWithOutcome(GKTurnBasedMatchOutcome.Quit,
        nextParticipants: nil, turnTimeout: 2000.0, matchData: matchData) { (error) in
        // We've now finished telling Game Center that we've quit
    }
}
// END turnbased_delegate_methods
    
}

extension ViewController : GKLocalPlayerListener {
// BEGIN player_delegate_methods
func player(player: GKPlayer!,
    receivedTurnEventForMatch match: GKTurnBasedMatch!, didBecomeActive: Bool) {
    // The turn-based match has updated. We may now be the current player.
}
    
func player(player: GKPlayer!, matchEnded match: GKTurnBasedMatch!) {
    // The match has now ended.
        
    // List out the outcome for each player (if they came first, second,
    // third, etc, or quit)
    for participant in match.participants as! [GKTurnBasedParticipant] {
        println("\(participant.player.alias)'s outcome: \(participant.matchOutcome)")
    }
        
}
// END player_delegate_methods
    
// BEGIN turnbased_end_turn
func endTurn(match: GKTurnBasedMatch, gameData:NSData, nextParticipants:[GKTurnBasedParticipant]) {
        
    // nextParticipants is an the array of the players
    // in the match, in order of who should go next. You can get the list
    // of participants using match.participants. Game Center will tell the
    // first participant in the array that it's their turn; if they don't
    // do it within 600 seconds (10 minutes), it will be the player after
    // that's turn, and so on. (If the last participant in the array
    // doesn't complete their turn within 10 minutes, it remains their
    // turn.)
        
    match.endTurnWithNextParticipants(nextParticipants, turnTimeout: 2000.0, matchData: gameData) { (error)  in
        // We're done telling Game Center about the state of the game
    }
}
// END turnbased_end_turn
    
// BEGIN turnbased_end_match
func endMatch(match: GKTurnBasedMatch, finalGameData:NSData) {
    match.endMatchInTurnWithMatchData(finalGameData, completionHandler: {
        (error) in
        // We're done telling Game Center that the match is over
    })
}
// END turnbased_end_match
    
// BEGIN turnbased_update_turn
func updateTurn(match: GKTurnBasedMatch, gameData: NSData) {
    match.saveCurrentTurnWithMatchData(gameData, completionHandler: { (error) in
        // The game data has been saved, but it's still our turn
    })
        
}
// END turnbased_update_turn
    
    func findMatches() {
// BEGIN find_matches
GKTurnBasedMatch.loadMatchesWithCompletionHandler { (matches, error) -> Void in
    for match in matches as! [GKTurnBasedMatch] {
        // Show information about this match
    }
}
// END find_matches
    }
    
    
}

