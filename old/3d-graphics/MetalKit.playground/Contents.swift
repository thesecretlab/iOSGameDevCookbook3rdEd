//: A UIKit based Playground for presenting user interface
  
import UIKit
import MetalKit
import PlaygroundSupport


class MetalView : MTKView {
    
    init(device: MTLDevice) {
        super.init()
        self.device = device
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        render()
    }
    
    func render() {
        let green = MTLClearColor(red: 0, green: 0.8, blue: 0.1, alpha: 1)
        
        guard let renderPassDescriptor = self.currentRenderPassDescriptor else {
            fatalError("Failed to get the current render pass descriptor!")
        }
        
        let commandQueue = device.newCommandQueue()
        
        let commandBuffer = commandQueue.commandBuffer()
        let encoder = commandBuffer.renderCommandEncoderWithDescriptor(renderPassDescriptor)
        
        
        
        encoder.endEncoding()
        commandBuffer.presentDrawable(currentDrawable!)
        commandBuffer.commit()
    }
}

class MyViewController : UIViewController {
    override func loadView() {
        
        guard let device = MTLCreateSystemDefaultDevice() else {
            fatalError("Failed to create the Metal device!")
        }
        
        let view = MetalView(device: device)
        
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
