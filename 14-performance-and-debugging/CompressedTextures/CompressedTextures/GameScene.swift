//
//  GameScene.swift
//  CompressedTextures
//
//  Created by Jon Manning on 16/1/18.
//  Copyright © 2018 Jon Manning. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        guard let spriteNode = self.childNode(withName: "//sprite") as? SKSpriteNode else {
            fatalError("Failed to find sprite!")
        }
        
        let texture = SKTexture(imageNamed: "MyTexture")
        
        spriteNode.texture = texture
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
