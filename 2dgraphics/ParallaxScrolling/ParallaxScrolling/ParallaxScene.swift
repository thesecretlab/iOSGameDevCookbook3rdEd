//
//  ParallaxScene.swift
//  ParallaxScrolling
//
//  Created by Jon Manning on 5/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit
import SpriteKit

// BEGIN parallax
class ParallaxScene: SKScene {

    // Sky
    var skyNode : SKSpriteNode
    var skyNodeNext : SKSpriteNode
    
    // Foreground hills
    var hillsNode : SKSpriteNode
    var hillsNodeNext : SKSpriteNode
    
    // Background hills
    var distantHillsNode : SKSpriteNode
    var distantHillsNodeNext : SKSpriteNode
    
    // Path
    var pathNode : SKSpriteNode
    var pathNodeNext : SKSpriteNode
    
    // Time of last frame
    var lastFrameTime : NSTimeInterval = 0
    
    // Time since last frame
    var deltaTime : NSTimeInterval = 0

    override init(size: CGSize) {
        
        // Prepare the sky sprites
        skyNode = SKSpriteNode(texture: 
            SKTexture(imageNamed: "Sky"))
        skyNode.position = CGPoint(x: size.width / 2.0,
            y: size.height / 2.0)
        
        skyNodeNext = skyNode.copy() as! SKSpriteNode
        skyNodeNext.position =
            CGPoint(x: skyNode.position.x + skyNode.size.width,
                y: skyNode.position.y)
        
        // Prepare the background hill sprites
        distantHillsNode = SKSpriteNode(texture: 
            SKTexture(imageNamed: "DistantHills"))
        distantHillsNode.position =
            CGPoint(x: size.width / 2.0,
                y: size.height - 284)
        
        distantHillsNodeNext = distantHillsNode.copy() as! SKSpriteNode
        distantHillsNodeNext.position =
            CGPoint(x: distantHillsNode.position.x +
                distantHillsNode.size.width,
                y: distantHillsNode.position.y)
        
        // Prepare the foreground hill sprites
        hillsNode = SKSpriteNode(texture: 
            SKTexture(imageNamed: "Hills"))
        hillsNode.position =
            CGPoint(x: size.width / 2.0,
                y: size.height - 384)
        
        hillsNodeNext = hillsNode.copy() as! SKSpriteNode
        hillsNodeNext.position =
            CGPoint(x: hillsNode.position.x + hillsNode.size.width,
                y: hillsNode.position.y)
        
        // Prepare the path sprites
        pathNode = SKSpriteNode(texture: 
            SKTexture(imageNamed: "Path"))
        pathNode.position =
            CGPoint(x: size.width / 2.0,
                y: size.height - 424)
        
        pathNodeNext = pathNode.copy() as! SKSpriteNode
        pathNodeNext.position =
            CGPoint(x: pathNode.position.x +
                pathNode.size.width,
                y: pathNode.position.y)
        
        super.init(size: size)
        
        
        // Add the sprites to the scene
        self.addChild(skyNode)
        self.addChild(skyNodeNext)
        
        self.addChild(distantHillsNode)
        self.addChild(distantHillsNodeNext)
        
        self.addChild(hillsNode)
        self.addChild(hillsNodeNext)
        
        self.addChild(pathNode)
        self.addChild(pathNodeNext)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }
    
    // Move a pair of sprites leftward based on a speed value;
    // when either of the sprites goes off-screen, move it to the
    // right so that it appears to be seamless movement
    func moveSprite(sprite : SKSpriteNode,
        nextSprite : SKSpriteNode, speed : Float) -> Void {
        var newPosition = CGPointZero
        
        // For both the sprite and its duplicate:
        for spriteToMove in [sprite, nextSprite] {
            
            // Shift the sprite leftward based on the speed
            newPosition = spriteToMove.position
            newPosition.x -= CGFloat(speed * Float(deltaTime))
            spriteToMove.position = newPosition
            
            // If this sprite is now offscreen (i.e., its rightmost edge is
            // farther left than the scene's leftmost edge):
            if spriteToMove.frame.maxX < self.frame.minX {
                
                // Shift it over so that it's now to the immediate right
                // of the other sprite.
                // This means that the two sprites are effectively
                // leap-frogging each other as they both move.
                spriteToMove.position =
                    CGPoint(x: spriteToMove.position.x +
                        spriteToMove.size.width * 2,
                        y: spriteToMove.position.y)
            }
            
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        // First, update the delta time values:
        
        // If we don't have a last frame time value, this is the first frame,
        // so delta time will be zero.
        if lastFrameTime <= 0 {
            lastFrameTime = currentTime
        }
        
        // Update delta time
        deltaTime = currentTime - lastFrameTime
        
        // Set last frame time to current time
        lastFrameTime = currentTime
        
        // Next, move each of the four pairs of sprites.
        // Objects that should appear move slower than foreground objects.
        self.moveSprite(skyNode, nextSprite:skyNodeNext, speed:25.0)
        self.moveSprite(distantHillsNode, nextSprite:distantHillsNodeNext,
            speed:50.0)
        self.moveSprite(hillsNode, nextSprite:hillsNodeNext, speed:100.0)
        self.moveSprite(pathNode, nextSprite:pathNodeNext, speed:150.0)
    }
    
}
// END parallax


