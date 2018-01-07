//
//  AppDelegate.swift
//  Behaviours
//
//  Created by Jon Manning on 17/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Override point for customization after application launch.
        
        let n = NavigationGrid(points: [
            CGPoint(x: 1, y: 1),
            CGPoint(x: 2, y: 1),
            CGPoint(x: 3, y: 1),
            CGPoint(x: 4, y: 1),
            CGPoint(x: 5, y: 1),
            
            CGPoint(x: 1, y: 2),
            CGPoint(x: 2, y: 2),
            CGPoint(x: 3, y: 2),
            CGPoint(x: 4, y: 2),
            CGPoint(x: 5, y: 2),
            
            ],
            maximumDistance: 1)
        
        let path = n.pathTo(start: CGPoint(x: 0, y: 0), end: CGPoint(x: 5, y: 2)) ?? []
        print(path.description)
        
        return true
    }


}

