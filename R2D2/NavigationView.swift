//
//  NavigationView.swift
//  R2D2
//
//  Created by Aritro Paul on 15/12/19.
//  Copyright © 2019 Aritro Paul. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation


protocol NavigationViewDelegate: class {
    func reachedDestination()
    func navigationDidStop()
}

class NavigationView: UIView {
    
    var captureSession: AVCaptureSession?
    var videoDataOutput: AVCaptureVideoDataOutput!
    var videoDataOutputQueue: DispatchQueue!
    var previewLayer:AVCaptureVideoPreviewLayer!
    var captureDevice : AVCaptureDevice!
    weak var delegate: NavigationViewDelegate?

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupNavigationView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupNavigationView()
    }
    
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
    override var layer: AVCaptureVideoPreviewLayer {
        return super.layer as! AVCaptureVideoPreviewLayer
    }
    
}

extension NavigationView {
    
    func setupNavigationView() {
        setupAVCapture()
    }
    
    func setupAVCapture(){
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = AVCaptureSession.Preset.hd1280x720
        guard let device = AVCaptureDevice
        .default(AVCaptureDevice.DeviceType.builtInWideAngleCamera,
                 for: .video,
                 position: AVCaptureDevice.Position.back) else {
                            return
        }
        captureDevice = device
        beginSession()
    }

    func beginSession(){
        var deviceInput: AVCaptureDeviceInput!

        do {
            deviceInput = try AVCaptureDeviceInput(device: captureDevice)
            guard deviceInput != nil else {
                print("error: cant get deviceInput")
                return
            }

            if (self.captureSession?.canAddInput(deviceInput) ?? false){
                self.captureSession?.addInput(deviceInput)
            }

            videoDataOutput = AVCaptureVideoDataOutput()
            videoDataOutput.alwaysDiscardsLateVideoFrames=true
            videoDataOutputQueue = DispatchQueue(label: "VideoDataOutputQueue")
//            videoDataOutput.setSampleBufferDelegate(self, queue:self.videoDataOutputQueue)

            if captureSession?.canAddOutput(self.videoDataOutput) ?? false{
                captureSession?.addOutput(self.videoDataOutput)
            }

            videoDataOutput.connection(with: .video)?.isEnabled = true

            self.layer.session = captureSession
            self.layer.videoGravity = .resizeAspectFill
            
            captureSession?.startRunning()
            
            
        } catch let error as NSError {
            deviceInput = nil
            print("error: \(error.localizedDescription)")
        }
    }

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // do stuff here
    }

    // clean up AVCapture
    func stopCamera(){
        captureSession?.stopRunning()
    }
}
