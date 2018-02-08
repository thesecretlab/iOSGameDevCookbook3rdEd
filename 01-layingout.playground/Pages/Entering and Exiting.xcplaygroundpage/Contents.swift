//: [Previous](@previous)

import Foundation
import UIKit

import PlaygroundSupport

class ViewController: UIViewController {
    
    // BEGIN enteringandexiting_example
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let center = NotificationCenter.default
        
        let didBecomeActive = #selector(
            UIApplicationDelegate.applicationDidBecomeActive(_:)
        )
        
        let willEnterForeground = #selector(
            UIApplicationDelegate.applicationWillEnterForeground(_:)
        )
        
        let willResignActive = #selector(
            UIApplicationDelegate.applicationWillResignActive(_:)
        )
        
        let didEnterBackground = #selector(
            UIApplicationDelegate.applicationDidEnterBackground(_:)
        )
        
        center.addObserver(self,
                           selector: didBecomeActive,
                           name: Notification.Name.UIApplicationDidBecomeActive,
                           object: nil)
        
        center.addObserver(self,
                           selector: willEnterForeground,
                           name: Notification.Name.UIApplicationWillEnterForeground,
                           object: nil)
        
        center.addObserver(self,
                           selector: willResignActive,
                           name: Notification.Name.UIApplicationWillResignActive,
                           object: nil)
        
        center.addObserver(self,
                           selector: didEnterBackground,
                           name: Notification.Name.UIApplicationDidEnterBackground,
                           object: nil)
        
    }
    
    func applicationDidBecomeActive(notification : Notification) {
        print("Application became active")
    }
    
    func applicationDidEnterBackground(notification : Notification) {
        print("Application entered background - unload textures!")
    }
    
    func applicationWillEnterForeground(notification : Notification) {
        print("Application will enter foreground - reload " +
            "any textures that were unloaded")
    }
    
    func applicationWillResignActive(notification : Notification) {
        print("Application will resign active - pause the game now!")
    }
    
    deinit {
        // Remove this object from the notification center
        NotificationCenter.default.removeObserver(self)
    }
    // END enteringandexiting_example
    
}

PlaygroundPage.current.liveView = ViewController()

//: [Next](@next)
