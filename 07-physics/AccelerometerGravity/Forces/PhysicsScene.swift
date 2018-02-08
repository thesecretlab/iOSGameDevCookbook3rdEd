//
//  GameScene.swift
//  Forces
//
//  Created by Jon Manning on 16/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import SpriteKit

// BEGIN motion_import
import CoreMotion
// END motion_import

class PhysicsScene: SKScene {
    
    // BEGIN motion_motionmanager_property
    let motionManager = CMMotionManager()
    // END motion_motionmanager_property
    
    override init(size: CGSize) {
        super.init(size: size)
        
        // BEGIN motion_motionmanager_update
        motionManager.startDeviceMotionUpdates(
            to: OperationQueue.main, withHandler: { (motion, error) -> Void in
                if let motion = motion {
                    let gravityMagnitude = 9.91
                    let gravityVector = CGVector(
                        dx: motion.gravity.x * gravityMagnitude,
                        dy: motion.gravity.y * gravityMagnitude)
                    
                    self.physicsWorld.gravity = gravityVector
                } else if let error = error {
                    print("Error getting motion data: \(error)")
                } else {
                    fatalError("Failed to get motion data OR error?")
                }
        })
        // END motion_motionmanager_update
        
        // Add a ball
        let ball = SKSpriteNode(color:SKColor.red,
                                size:CGSize(width:20, height:20))
        ball.physicsBody = SKPhysicsBody(rectangleOf: ball.size)
        ball.position = CGPoint(x: self.frame.midX,
                                y: self.frame.midY)
        self.addChild(ball)
        
        // Add some walls
        let wallsNode = SKNode()
        wallsNode.position = CGPoint(x: self.frame.midX,
                                     y: self.frame.midY)
        
        let rect = self.frame.offsetBy(dx: -self.frame.width / 2.0,
                                       dy: -self.frame.height / 2.0)
        wallsNode.physicsBody = SKPhysicsBody(edgeLoopFrom:rect)
        
        self.addChild(wallsNode)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
