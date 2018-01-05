//
//  GameScene.swift
//  Forces
//
//  Created by Jon Manning on 16/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import SpriteKit

// BEGIN import
import CoreMotion
// END import

class PhysicsScene: SKScene {
    
// BEGIN motionmanager_property
let motionManager = CMMotionManager()
// END motionmanager_property
    
    override init(size: CGSize) {
        super.init(size: size)
        
// BEGIN motionmanager_update
motionManager.startDeviceMotionUpdatesToQueue(
    NSOperationQueue.mainQueue(), withHandler: { (motion, error) -> Void in
    if error != nil {
        println("Error getting motion data: \(error)")
    } else {
                
        let gravityMagnitude = 9.91
        let gravityVector = CGVector(
            dx: motion.gravity.x * gravityMagnitude,
            dy: motion.gravity.y * gravityMagnitude)
                
        self.physicsWorld.gravity = gravityVector
    }
})
// END motionmanager_update
        
        // Add a ball
        let ball = SKSpriteNode(color:SKColor.redColor(),
            size:CGSize(width:20, height:20))
        ball.physicsBody = SKPhysicsBody(rectangleOfSize:ball.size)
        ball.position = CGPoint(x: self.frame.midX,
            y: self.frame.midY)
        self.addChild(ball)
        
        // Add some walls
        let wallsNode = SKNode()
        wallsNode.position = CGPoint(x: self.frame.midX,
            y: self.frame.midY)
        
        let rect = CGRectOffset(self.frame,
            -self.frame.width / 2.0, -self.frame.height / 2.0)
        wallsNode.physicsBody = SKPhysicsBody(edgeLoopFromRect:rect)
        
        self.addChild(wallsNode)
    }
    
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
