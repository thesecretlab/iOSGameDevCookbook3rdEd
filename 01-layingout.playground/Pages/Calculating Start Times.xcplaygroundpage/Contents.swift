//: [Previous](@previous)

import Foundation
import UIKit

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
            .timeIntervalSinceDate(self.gameStartDate!)
        NSLog("The game started \(timeSinceGameStart) seconds ago")
        // END game_start_time_get
        
        // BEGIN game_start_time_format
        let hours = timeSinceGameStart / 3600.0 // 3600 seconds in an hour
        let minutes = timeSinceGameStart % 3600.0 / 60.0 // 60 seconds in a minute
        let seconds = timeSinceGameStart % 60.0 // remaining seconds
        
        NSLog("Time elapsed: \(hours):\(minutes):\(seconds)")
        // END game_start_time_format
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//: [Next](@next)
