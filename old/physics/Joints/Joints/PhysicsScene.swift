//
//  GameScene.swift
//  Joints
//
//  Created by Jon Manning on 16/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import SpriteKit

class PhysicsScene: SKScene {

    override init(size: CGSize) {
        super.init(size: size)
        
        self.backgroundColor = SKColor(red:0.15, green:0.15, blue:0.3, alpha:1.0)
        
        let scene = self
        
// BEGIN joints
let anchor = SKSpriteNode(color:SKColor.whiteColor(),
    size:CGSize(width: 100, height: 100))
anchor.position = CGPointMake(self.frame.midX, self.frame.midY)
anchor.physicsBody = SKPhysicsBody(rectangleOfSize:anchor.size)
anchor.physicsBody?.dynamic = false
        
scene.addChild(anchor)
        
let attachment = SKSpriteNode(color:SKColor.yellowColor(),
    size:CGSize(width: 100, height: 100))
attachment.position = CGPointMake(self.frame.midX + 100,
    self.frame.midY - 100)
attachment.physicsBody = SKPhysicsBody(rectangleOfSize:attachment.size)
        
scene.addChild(attachment)
        
let pinJoint = SKPhysicsJointPin.jointWithBodyA(anchor.physicsBody,
    bodyB:attachment.physicsBody, anchor:anchor.position)
        
// BEGIN add_joint
scene.physicsWorld.addJoint(pinJoint)
// END add_joint
// END joints

/*
// Removing joints
// BEGIN remove_joint
scene.physicsWorld.removeJoint(pinJoint)
// END remove_joint
*/
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        return nil
    }
    
}
