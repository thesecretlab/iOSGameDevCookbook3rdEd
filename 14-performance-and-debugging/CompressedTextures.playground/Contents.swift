//: Playground - noun: a place where people can play

//import UIKit
import GLKit
import SpriteKit
import MetalKit

//GLKTextureLoader().

var str = "Hello, playground"

let pvrtcDataURL =  #fileLiteral(resourceName: "MyCompressedTexture.pvr")
let pvrtcData = try! Data(contentsOf: pvrtcDataURL)
let texture =  SKTexture(data: pvrtcData, size: CGSize(width: 1024, height: 1024))
texture.size()
