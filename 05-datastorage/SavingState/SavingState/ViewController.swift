//
//  ViewController.swift
//  SavingState
//
//  Created by Jon Manning on 4/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Encoding data
        // BEGIN encode
        let monster = Monster()
        
        let monsterData = NSKeyedArchiver.archivedData(withRootObject: monster)
        
        // monsterData can now be saved to disk
        // END encode
        
        // Decoding data
        // BEGIN decode
        // Load monsterData (an NSData) from somewhere, and then:
        
        let loadedMonster = NSKeyedUnarchiver
            .unarchiveObject(with: monsterData) as! Monster
        // END decode
        
    }

}

