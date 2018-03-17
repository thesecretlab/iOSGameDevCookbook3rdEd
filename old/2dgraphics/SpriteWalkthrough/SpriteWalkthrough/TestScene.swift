//
//  TestScene.swift
//  SpriteWalkthrough
//
//  Created by Jon Manning on 5/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit
import SpriteKit

class TestScene: SKScene {
    
// BEGIN created_prop
var contentCreated = false
// END created_prop
    
// BEGIN move_to_view
override func didMoveToView(view: SKView) {
    if self.contentCreated == false {
        self.createSceneContents()
        self.contentCreated = true
    }
}
// END move_to_view
    
    /* Commented out because we replace it with other versions
    // in other recipes
// BEGIN create_scene_contents
func createSceneContents() {
    // BEGIN background_color
    self.backgroundColor = SKColor.blackColor()
    // END background_color
    self.scaleMode = SKSceneScaleMode.AspectFit
}
// END create_scene_contents
    */
    
    
    func createSceneContents() {
        self.backgroundColor = SKColor.blackColor()
        self.scaleMode = SKSceneScaleMode.AspectFit
        
        let myScene = self
        
// BEGIN adding_sprite
// BEGIN create_sprite
let sprite = SKSpriteNode(color: UIColor.greenColor(),
    size: CGSize(width: 64, height: 64))
// END create_sprite
        
// BEGIN sprite_position
sprite.position = CGPoint(x: 100, y: 100)
// END sprite_position
        
// BEGIN sprite_add_child
myScene.addChild(sprite)
// END sprite_add_child
// END adding_sprite
        
// BEGIN textnode
// BEGIN textnode_create
let textNode = SKLabelNode(fontNamed: "Zapfino")
// END textnode_create
// BEGIN textnode_properties
textNode.text = "Hello, world!"
textNode.fontSize = 42
textNode.position = CGPoint(x: myScene.frame.midX, y: myScene.frame.midY)
// END textnode_properties
        
textNode.name = "helloNode"
        
myScene.addChild(textNode)
// END textnode
        
// BEGIN list_fonts
for fontFamilyName in UIFont.familyNames() as! [String] {
    for fontName in UIFont.fontNamesForFamilyName(fontFamilyName) as! [String] {
        println("Available font: \(fontName)")
    }
}
// END list_fonts
        
        
        let node = sprite
        
// BEGIN actions
// In this example, 'node' is any SKNode
            
// Move 100 pixels up and 100 pixels to the right over 1 second
let moveUp = SKAction.moveBy(CGVector(dx: 100, dy: 100), duration: 1.0)
        
// Fade out over 0.5 seconds
let fadeOut = SKAction.fadeOutWithDuration(0.5)
        
// Run a block of code
let runBlock = SKAction.runBlock { () -> Void in
    println("Hello!")
}
        
// Remove the node
let remove = SKAction.removeFromParent()
        
// Run the movement and fading blocks at the same time
let moveAndFade = SKAction.group([moveUp, fadeOut])
        
// Move and fade, then run the block, then remove the node
let sequence = SKAction.sequence([moveAndFade, runBlock, remove])
        
// Run these actions on the node
node.runAction(sequence)
// END actions

        let action1 = SKAction()
        let action2 = SKAction()
        let action3 = SKAction()
        
        if true {
// BEGIN group
let group = SKAction.group([action1, action2, action3])
// END group
        
// BEGIN sequence
let sequence = SKAction.sequence([action1, action2, action3])
// END sequence
        
// BEGIN grouped_sequences
let sequence1 = SKAction.sequence([action1, action2])
let sequence2 = SKAction.sequence([action1, action2])
        
let groupedSequences = SKAction.group([sequence1, sequence2])
// END grouped_sequences
        }
        
        if true {
// BEGIN completion_block
let action = SKAction.fadeOutWithDuration(1.0)
            
node.runAction(action, completion: { () -> Void in
    println("Action's done!")
})
// END completion_block
            
// BEGIN action_with_key
node.runAction(action, withKey: "My Action")
// END action_with_key
            
// BEGIN get_action_with_key
let theAction = node.actionForKey("My Action")
// END get_action_with_key
            
// BEGIN remove_action_with_key
node.removeActionForKey("My Action")
// END remove_action_with_key
            
// BEGIN remove_all_actions
node.removeAllActions()
// END remove_all_actions
        }
        
// BEGIN texture_sprite
let imageSprite = SKSpriteNode(imageNamed: "Spaceship")
// END texture_sprite
        
        myScene.addChild(imageSprite)
        
// BEGIN shape_node
let path = UIBezierPath(roundedRect: CGRect(x: -100, y: -100,
                                            width: 200, height: 200),
                        cornerRadius: 20)
        
let shape = SKShapeNode(path: path.CGPath)
        
shape.strokeColor = SKColor.greenColor()
shape.fillColor = SKColor.redColor()
        
shape.glowWidth = 4
        
shape.position = CGPoint(x: myScene.frame.midX,
                         y: myScene.frame.midY)
        
myScene.addChild(shape)
// END shape_node
        
// BEGIN blend_mode
shape.blendMode = SKBlendMode.Add
// END blend_mode
        
        
        imageSprite.removeFromParent()
        
// BEGIN effect_node
let effect = SKEffectNode()
        
let filter = CIFilter(name: "CIGaussianBlur")
filter.setValue(20.0, forKey: "inputRadius")
        
effect.filter = filter;
        
myScene.addChild(effect)
effect.addChild(imageSprite)
// END effect_node
        
// BEGIN bezier_paths
let rectangle = UIBezierPath(rect:CGRect(x: 0, y: 0,
    width: 100, height: 200))
        
let roundedRect = UIBezierPath(roundedRect:CGRect(x: -100, y: -100,
    width: 200, height: 200),
    cornerRadius:20)
        
let oval = UIBezierPath(ovalInRect:CGRect(x: 0, y: 0,
                                          width: 100, height: 200))
        
let customShape = UIBezierPath()
customShape.moveToPoint(CGPoint(x: 0, y: 0))
customShape.addLineToPoint(CGPoint(x: 0, y: 100))
customShape.addCurveToPoint(CGPoint(x: 0, y: 0),
    controlPoint1:CGPoint(x: 100, y: 100),
    controlPoint2:CGPoint(x: 100, y: 0))
        
customShape.closePath()
// END bezier_paths
        
// BEGIN particle

let fireNode = SKEmitterNode(fileNamed: "Fire.sks")
        
myScene.addChild(fireNode)
// END particle
        
        let cameraNode = SKNode()
// BEGIN shakenode_using
shakeNode(textNode)
// END shakenode_using
        
// BEGIN noise
let noiseTexture = SKTexture(noiseWithSmoothness: 0.2,
    size: CGSize(width: 200, height: 200), grayscale: true)
let noiseSprite = SKSpriteNode(texture: noiseTexture)
myScene.addChild(noiseSprite)
// END noise
        
        noiseSprite.position = CGPoint(x: self.size.width, y: self.size.height - 25)
        noiseSprite.anchorPoint = CGPoint(x: 1.0, y: 1.0)
        
// BEGIN animation
// Load the texture atlas that contains the frames
let atlas = SKTextureAtlas(named: "Animation")
        
// Get the list of texture names, and sort them
let textureNames = (atlas.textureNames as! [String]).sorted {
    (first, second) -> Bool in
    return first < second
}
        
// Load all textures
var allTextures : [SKTexture] = textureNames.map { (textureName) -> SKTexture in
    return atlas.textureNamed(textureName)
}
        
// Create the sprite, and give it the initial frame; position it
// in the middle of the screen
let animatedSprite = SKSpriteNode(texture:allTextures[0])
animatedSprite.position = CGPoint(x: self.frame.midX,
    y: self.frame.midY)
self.addChild(animatedSprite)
        
// Make the sprite animate using the loaded textures, at a rate of
// 30 frames per second
let animationAction = SKAction.animateWithTextures(allTextures,
    timePerFrame:(1.0/30.0))
        
animatedSprite.runAction(SKAction.repeatActionForever(animationAction))
// END animation

        
    }
    
// BEGIN shake_node
func shakeNode(node: SKNode) {
    // Cancel any existing shake actions
    node.removeActionForKey("shake")
        
    // The number of individual movements that the shake will be made up of
    let shakeSteps = 15
        
    // How "big" the shake is
    let shakeDistance = 20.0
        
    // How long the shake should go on for
    let shakeDuration = 0.25
        
    // An array to store the individual movements in
    var shakeActions : [SKAction] = []
        
    // Loop 'shakeSteps' times
    for i in 0...shakeSteps  {
            
        // How long this specific shake movement will take
        let shakeMovementDuration : Double = shakeDuration / Double(shakeSteps)
            
        // This will be 1.0 at the start and gradually move down to 0.0
        let shakeAmount : Double = Double(shakeSteps - i) / Double(shakeSteps)
            
        // Take the current position - we'll then add an offset from that
        var shakePosition = node.position
            
        // Pick a random amount from -shakeDistance to shakeDistance
        let xPos = (Double(arc4random_uniform(UInt32(shakeDistance*2))) -
                    Double(shakeDistance)) * shakeAmount
        let yPos = (Double(arc4random_uniform(UInt32(shakeDistance*2))) -
            Double(shakeDistance)) * shakeAmount
        shakePosition.x = shakePosition.x + CGFloat(xPos)
        shakePosition.y = shakePosition.y + CGFloat(yPos)
            
        // Create the action that moves the node to the new location, and
        // add it to the list
        let shakeMovementAction = SKAction.moveTo(shakePosition,
            duration:shakeMovementDuration)
        shakeActions.append(shakeMovementAction)
            
    }
        
    // Run the shake!
    let shakeSequence = SKAction.sequence(shakeActions)
    node.runAction(shakeSequence, withKey:"shake")
        

}
// END shake_node

    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        // Transition to a new scene on touch
        let newScene = OtherScene()
        newScene.size = self.size
        
        /* Without transition
// BEGIN show_no_transition
// newScene is an SKScene object that you want to switch to
self.view?.presentScene(newScene)
// END show_no_transition
        */
        
        /* With transition */
// BEGIN show_transition
// BEGIN crossfade
let crossFade = SKTransition.crossFadeWithDuration(0.5)
// END crossfade
self.view?.presentScene(newScene, transition: crossFade)
// END show_transition
    }
    


}

class OtherScene : SKScene {
    
    var contentCreated = false
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = SKColor.redColor()
        self.scaleMode = SKSceneScaleMode.AspectFit
    }
    
}
