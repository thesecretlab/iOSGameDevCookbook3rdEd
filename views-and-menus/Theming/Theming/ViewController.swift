//
//  ViewController.swift
//  Theming
//
//  Created by Jon Manning on 14/01/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var progressView: UIProgressView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        // BEGIN theming_button
        self.button.tintColor = UIColor.redColor()
        
        let image = UIImage(named: "Ball")
        self.button.setBackgroundImage(image,
            forState: UIControlState.Normal)
        // END theming_button
        
        // BEGIN theming_all_progressviews
        UIProgressView.appearance().progressTintColor = UIColor.purpleColor()
        // END theming_all_progressviews
        
        // BEGIN theming_progressview
        self.progressView.progressTintColor = UIColor.orangeColor()
        // END theming_progressview
        
        // BEGIN theming_navbar
        UINavigationBar.appearance()
            .setBackgroundImage(image,
                forBarMetrics: UIBarMetrics.Default)
        // END theming_navbar
        
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

