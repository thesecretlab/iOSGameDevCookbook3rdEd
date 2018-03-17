//: [Previous](@previous)

import Foundation
import UIKit
import PlaygroundSupport

class ViewController: UIViewController {
    
    // BEGIN timer_storage
    var timer : Timer?
    // END timer_storage
    
    // BEGIN timer_method
    @objc
    func updateWithTimer(timer: Timer) {
        // Timer went off; update the game
        print("Timer went off!")
    }
    // END timer_method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // BEGIN timer_start
        // Start a timer
        self.timer = Timer.scheduledTimer(timeInterval: 0.5,
                                          target: self,
                                          selector: #selector(ViewController.updateWithTimer(timer:)),
                                                            userInfo: nil,
                                                            repeats: true)
        // END timer_start
        
        
        // BEGIN timer_stop
        // Stop a timer
        self.timer?.invalidate()
        self.timer = nil
        // END timer_stop
 
        
    }
    
}

PlaygroundPage.current.liveView = ViewController()


//: [Next](@next)
