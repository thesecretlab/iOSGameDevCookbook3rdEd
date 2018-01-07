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
        
        let anchor = SKSpriteNode(color:SKColor.white,
                                  size:CGSize(width: 100, height: 100))
        anchor.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        let anchorBody = SKPhysicsBody(rectangleOf:anchor.size)
        anchor.physicsBody = anchorBody
        anchor.physicsBody?.isDynamic = false
        
        scene.addChild(anchor)
        
        let attachment = SKSpriteNode(color:SKColor.yellow,
                                      size:CGSize(width: 100, height: 100))
        attachment.position = CGPoint(x: self.frame.midX + 100,
                                      y :self.frame.midY - 100)
        
        let attachmentBody = SKPhysicsBody(rectangleOf:attachment.size)
        attachment.physicsBody = attachmentBody
        
        scene.addChild(attachment)
        
        let pinJoint = SKPhysicsJointPin.joint(withBodyA: anchorBody,
                                               bodyB:attachmentBody,
                                               anchor:anchor.position)
        
        // BEGIN add_joint
        scene.physicsWorld.add(pinJoint)
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
