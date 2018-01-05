//
//  GameScene.swift
//  Collisions
//
//  Created by Jon Manning on 16/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import SpriteKit

// BEGIN contact_bitmask
let myObjectBitMask : UInt32 = 0x00001
// END contact_bitmask

class PhysicsScene: SKScene, SKPhysicsContactDelegate {
    
    override init(size: CGSize) {
        super.init(size: size)
        
        createPhysicsSprite()
        createStaticPhysicsSprite()
        
        // BEGIN contact_delegate
        self.physicsWorld.contactDelegate = self
        // END contact_delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        return nil
    }
    
    // BEGIN physics_contact
    func didBegin(_ contact: SKPhysicsContact) {
        print("Contact started between \(contact.bodyA) and \(contact.bodyB)")
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        print("Contact ended between \(contact.bodyA) and \(contact.bodyB)")
    }
    // END physics_contact
    
    
    func createPhysicsSprite() {
        let physicsSprite = SKSpriteNode(color:SKColor.white, size:CGSize(width: 100, height: 100))
    
        physicsSprite.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 100)
        physicsSprite.physicsBody = SKPhysicsBody(rectangleOf:physicsSprite.size)
    
        // BEGIN apply_bitmask
        physicsSprite.physicsBody?.contactTestBitMask = myObjectBitMask;
        // END apply_bitmask
    
        self.addChild(physicsSprite)
    }
    
    func createStaticPhysicsSprite() {
        let staticSprite = SKSpriteNode(color:SKColor.yellow, size:CGSize(width: 200, height: 25))
    
        staticSprite.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 100)
        staticSprite.physicsBody = SKPhysicsBody(rectangleOf:staticSprite.size)
        staticSprite.physicsBody?.isDynamic = false
    
        staticSprite.physicsBody?.contactTestBitMask = myObjectBitMask
    
        self.addChild(staticSprite)
    }

}
