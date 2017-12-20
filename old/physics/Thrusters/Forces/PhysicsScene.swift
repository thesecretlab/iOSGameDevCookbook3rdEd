//
//  GameScene.swift
//  Forces
//
//  Created by Jon Manning on 16/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import SpriteKit

class PhysicsScene: SKScene {

// BEGIN property
var lastTime = 0.0
// END property
    
    override init(size: CGSize) {
        super.init(size:size)
        
        self.backgroundColor = SKColor(red:0.15, green:0.15, blue:0.3, alpha:1.0)
        
        // Add the sprite
        let sprite = SKSpriteNode(color: SKColor.whiteColor(), size:CGSize(width: 100, height: 100))
        sprite.physicsBody = SKPhysicsBody(rectangleOfSize:sprite.size)
        sprite.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        sprite.name = "Box"
        
        self.addChild(sprite)
        
        // Add the walls
        let walls = SKNode()
        walls.physicsBody = SKPhysicsBody(edgeLoopFromRect:self.frame)
        self.addChild(walls)
    }
    
// BEGIN update_func
override func update(currentTime: NSTimeInterval) {
            
        if self.lastTime == 0 {
            self.lastTime = currentTime
        }
            
            
        let deltaTime = currentTime - self.lastTime
            
        if let node = self.childNodeWithName("Box") {
            
            node.physicsBody?.applyForce(CGVector(dx: 0 * deltaTime,
                                                  dy: 10 * deltaTime))
            node.physicsBody?.applyTorque(CGFloat(0.5 * deltaTime))
                    
        }
    }
// END update_func
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
