//
//  ViewController.swift
//  CoreMLDemo
//
//  Created by Jon Manning on 9/2/18.
//  Copyright © 2018 Jon Manning. All rights reserved.
//

import UIKit

// BEGIN camera_import
import AVFoundation
// END camera_import
// BEGIN vision_import
import Vision
// END vision_import

// BEGIN camera_viewcontroller
class ViewController: UIViewController {
    
    // BEGIN camera_label
    @IBOutlet weak var outputLabel: UILabel!
    // END camera_label
    
    // BEGIN vision_model
    // Produces a Vision wrapper for a CoreML model.
    lazy var model : VNCoreMLModel = {
        let coreMLModel = Inceptionv3().model
        
        do {
            return try VNCoreMLModel(for: Inceptionv3().model)
            
        } catch let error {
            fatalError("Failed to create model! \(error)")
        }
    }()
    // END vision_model
    
    // An output that's used to capture still images.
    let photoOutput = AVCapturePhotoOutput()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let captureSession = AVCaptureSession()
        
        // Search for available capture devices that are
        // 1. on the rear of the device
        // 2. are a wide angle camera (not a telephoto)
        // 3. can capture video
        
        let availableDevices = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInWideAngleCamera],
            mediaType: AVMediaType.video,
            position: .back).devices
        
        // Find the first one
        guard let rearCamera = availableDevices.first else {
            fatalError("No suitable capture device found!")
        }
        
        // Set up the capture device and add it to the capture session
        do {
        
            let captureDeviceInput = try AVCaptureDeviceInput(device: rearCamera)
            captureSession.addInput(captureDeviceInput)
        
        } catch {
            print("Failed to create the device input! \(error)")
        }
        
        // Add the photo capture output to the session.
        captureSession.addOutput(photoOutput)
        
        // BEGIN camera_output_delegate_setup
        let captureOutput = AVCaptureVideoDataOutput()
        // Set up the video output, and add it to the capture session
        // Tell the capture output to notify us every time it captures a frame of video
        
        captureOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(captureOutput)
        // END camera_output_delegate_setup
        
        // Create a preview layer for the session
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        // Add it to the view, underneath everything
        previewLayer.frame = view.frame
        view.layer.insertSublayer(previewLayer, at: 0)
        
        // Start the session
        captureSession.startRunning()
    }
    
    // Called when the user taps on the view.
    @IBAction func capturePhoto(_ sender: Any) {
        
        // Specify that we want to capture a JPEG
        // image from the camera.
        let settings = AVCapturePhotoSettings(format: [
            AVVideoCodecKey: AVVideoCodecType.jpeg
            ])
        
        // Signal that we want to capture a photo, and it
        // should notify this object when done
        photoOutput.capturePhoto(
            with: settings,
            delegate: self
        )
    }
}

// Contains methods that respond to a photo being captured.
extension ViewController : AVCapturePhotoCaptureDelegate {
    
    // Called after a requested photo has finished being
    // captured.
    func photoOutput(
        _ output: AVCapturePhotoOutput,
        didFinishProcessingPhoto photo: AVCapturePhoto,
        error: Error?) {
        
        if let error = error {
            print("Error processing photo: \(error)")
        } else if let jpegData = photo.fileDataRepresentation() {
            
            // jpegData now contains an encoded JPEG image
            // that we can use
            
            let photoSizeKilobytes = jpegData.count / 1024
            
            print("Captured a photo! It was " +
                "\(photoSizeKilobytes)kb in size.")
        }
    }
}
// END camera_viewcontroller

// BEGIN vision_capturedelegate
extension ViewController : AVCaptureVideoDataOutputSampleBufferDelegate {
    
    // Called every time a frame is captured
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        // Create a request that uses the model
        
        let request = VNCoreMLRequest(model: model) { (finishedRequest, error) in
            
            // Ensure that we have an array of results
            guard let results = finishedRequest.results
                as? [VNClassificationObservation] else {
                    return
            }
            
            // Ensure that we have at least one result
            guard let observation = results.first else {
                return
            }
            
            // This whole queue runs on a background
            // queue, so we need to be sure we update
            // the UI on the main queue
            OperationQueue.main.addOperation {
                self.outputLabel.text =
                "\(observation.identifier)"
            }
        }
        
        // Convert the frame into a CVPixelBuffer, which
        // Vision can use
        guard let pixelBuffer: CVPixelBuffer =
            CMSampleBufferGetImageBuffer(sampleBuffer) else {
                return
        }
        
        // Create and execute a handler that uses this request
        let handler = VNImageRequestHandler(
            cvPixelBuffer: pixelBuffer,
            options: [:]
        )
        
        try? handler.perform([request])
    }
    
}
// END vision_capturedelegate
