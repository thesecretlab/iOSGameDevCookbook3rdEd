//: [Previous](@previous)

import Foundation
import UIKit

import PlaygroundSupport



class ViewController: UIViewController {
    
    // BEGIN game_start_time_storage
    // Store the time when the game started as a property
    var gameStartDate : Date?
    // END game_start_time_storage
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // BEGIN game_start_time_setup
        // When the game actually begins, store the current date
        self.gameStartDate = Date()
        // END game_start_time_setup
        
        // BEGIN game_start_time_get
        let now = Date()
        let timeSinceGameStart = now
            .timeIntervalSince(self.gameStartDate!)
        NSLog("The game started \(timeSinceGameStart) seconds ago")
        // END game_start_time_get
        
        // BEGIN game_start_time_format
        let hours = timeSinceGameStart / 3600.0 // 3600 seconds in an hour
        let minutes = timeSinceGameStart.truncatingRemainder(dividingBy: 3600) / 60.0 // 60 seconds in a minute
        let seconds = timeSinceGameStart.truncatingRemainder(dividingBy: 3600) / 60.0 // remaining seconds
        
        print("Time elapsed: \(hours):\(minutes):\(seconds)")
        // END game_start_time_format
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

PlaygroundPage.current.liveView = ViewController()

//: [Next](@next)
