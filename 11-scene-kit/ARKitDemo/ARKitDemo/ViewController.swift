//
//  ViewController.swift
//  ARKitDemo
//
//  Created by Jon Manning on 1/2/18.
//  Copyright © 2018 Jon Manning. All rights reserved.
//

import UIKit
import ARKit

// BEGIN arkit_vc
class ViewController: UIViewController, ARSCNViewDelegate {

    // The reference to the SceneKit view.
    @IBOutlet weak var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the scene file.
        guard let scene = SCNScene(named: "Cube.scn") else {
            fatalError("Failed to load scene!")
        }
        
        // Provide the scene to the ARKit view.
        sceneView.scene = scene
        
        // This view controller is the delegate
        // for the ARSCNView. (This requires that
        // we conform to the ARSCNViewDelegate
        // protocol, seen above.
        sceneView.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
      
        // Create an ARKit configuration for
        // tracking movement through the world.
        let configuration = ARWorldTrackingConfiguration()
        
        // Tell the ARSCNView to start running
        // augmented reality with this configuration.
        sceneView.session.run(configuration)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the ARKit view when this view controller goes away.
        sceneView.session.pause()
    }

    // BEGIN arkit_hittest
    // BEGIN arkit_hittest_signature
    @IBAction func sceneTapped(_ sender: UITapGestureRecognizer) {
    // END arkit_hittest_signature
        
        // This method is run when the tap gesture recognizer fires.
        
        // Get the location of the touch in the view.
        let touchLocation = sender.location(ofTouch: 0, in: sceneView)
        
        print("Tapped at \(touchLocation)")
        
        // Find all horizontal planes at this touch location
        let hitLocations = sceneView.hitTest(touchLocation,
                                             types: .estimatedHorizontalPlane)
        
        // Get the first location, if one was found
        guard let firstLocation = hitLocations.first else {
            print("Didn't find a hit location")
            return
        }
        
        // We'll now duplicate the 'box' object that was already present in the scene.
        
        // Find the first node named 'box'; we'll make a copy of it
        guard let cube = sceneView.scene.rootNode
            .childNode(withName: "box", recursively: false) else {
                
            print("Error: couldn't find the box?")
            return
        }
        
        // Create a copy of that cube and add it to the scene
        let newCube = cube.clone()
        sceneView.scene.rootNode.addChildNode(newCube)
        
        // Convert the position and orientation of the plane to a
        // type that SceneKit can use
        let newCubeTransform = SCNMatrix4(firstLocation.worldTransform)
        
        // Set this position and orientation
        newCube.setWorldTransform(newCubeTransform)
        
    }
    // END arkit_hittest
    
}
// END arkit_vc
