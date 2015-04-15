//
//  ViewController.swift
//  CurrencyManager
//
//  Created by Jon Manning on 4/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // BEGIN usage
        let currency = CurrencyManager()
        
        currency.gold = 45
        currency.gems = 21
        
        currency.endGame()
        // END usage

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

