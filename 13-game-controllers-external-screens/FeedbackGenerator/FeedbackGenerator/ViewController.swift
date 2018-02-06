//
//  ViewController.swift
//  FeedbackGenerator
//
//  Created by Jon Manning on 31/1/18.
//  Copyright © 2018 Jon Manning. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // BEGIN feedback_impact
        // Prepare 'impact' feedback generators with the
        // style of feedback you want
        let lightImpact = UIImpactFeedbackGenerator(style: .light)
        let mediumImpact = UIImpactFeedbackGenerator(style: .medium)
        let heavyImpact = UIImpactFeedbackGenerator(style: .heavy)
    
    // END feedback_impact
    
    // BEGIN feedback_notification
        // Prepare a 'notification' feedback generator
        let notification = UINotificationFeedbackGenerator()
    
    // END feedback_notification
    
    // BEGIN feedback_selection
        // Prepare a 'selection changed' feedback generator
        let selection = UISelectionFeedbackGenerator()
    
    // END feedback_selection
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectionChanged(_ sender: Any) {
        // BEGIN feedback_selection
        selection.selectionChanged()
        // END feedback_selection
    }
    
    @IBAction func impactLight(_ sender: Any) {
        // BEGIN feedback_impact
        // Play a 'light impact' notification
        lightImpact.impactOccurred()
        
        // END feedback_impact
    }
    
    @IBAction func impactMedium(_ sender: Any) {
        // BEGIN feedback_impact
        // Play a 'medium impact' notification
        mediumImpact.impactOccurred()
        
        // END feedback_impact
    }
    
    @IBAction func impactHeavy(_ sender: Any) {
        // BEGIN feedback_impact
        // Play a 'heavy impact' notification
        heavyImpact.impactOccurred()
        
        // END feedback_impact
    }
    
    @IBAction func warningNotification(_ sender: Any) {
        
        // BEGIN feedback_notification
        notification.notificationOccurred(.warning)
        
        // END feedback_notification
        
    }
    @IBAction func successNotification(_ sender: Any) {
        // BEGIN feedback_notification
        notification.notificationOccurred(.success)
        
        // END feedback_notification
    }
    
    @IBAction func errorNotification(_ sender: Any) {
        // BEGIN feedback_notification
        notification.notificationOccurred(.error)
        
        // END feedback_notification
    }
    
    @IBAction func prepareNotification(_ sender: Any) {
        // BEGIN feedback_prepare
        heavyImpact.prepare()
        
        // END feedback_prepare
    }
    
    @IBAction func deliverPreparedNotification(_ sender: Any) {
        
        // BEGIN feedback_prepare_deliver
        // Note that we aren't calling a special method,
        // just the regular one.  However, the notification
        // will be delivered more quickly if the Taptic Engine
        // was already in the prepared state.
        heavyImpact.impactOccurred()
        
        // END feedback_prepare_deliver
    }
}

