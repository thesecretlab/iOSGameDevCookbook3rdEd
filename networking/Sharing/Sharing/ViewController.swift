//
//  ViewController.swift
//  Sharing
//
//  Created by Jon Manning on 18/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func shareText(sender: AnyObject) {
// BEGIN share_text
// Get a string from somewhere
let textToShare : String = self.textField.text
// Put it in an array
let activityItems = [textToShare]
        
// Create an activity view controller and present it
let activityViewController =
    UIActivityViewController(activityItems: activityItems,
        applicationActivities: nil)
self.presentViewController(activityViewController,
    animated: true, completion: nil)
// END share_text
    }

    @IBAction func shareTextImageAndURL(sender: AnyObject) {
// BEGIN share_text_image_url
let textToShare : String = self.textField.text
let URLToShare = NSURL(string: "http://oreilly.com")!
let imageToShare = self.imageView.image!
let activityItems = [textToShare, URLToShare, imageToShare]

let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
self.presentViewController(activityViewController, animated: true, completion: nil)
// END share_text_image_url

        
    }
    
    @IBAction func shareTextAndURL(sender: AnyObject) {

// BEGIN share_text_url
let textToShare : String = self.textField.text
let URLToShare = NSURL(string: "http://oreilly.com")!
let activityItems = [textToShare, URLToShare]
        
let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
self.presentViewController(activityViewController, animated: true, completion: nil)
// END share_text_url

    
    }
}

