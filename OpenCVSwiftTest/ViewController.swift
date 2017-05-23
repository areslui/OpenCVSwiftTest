//
//  ViewController.swift
//  OpenCVSwiftTest
//
//  Created by Okaylens-Ares on 22/05/2017.
//  Copyright © 2017 Okaylens-Ares. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    @IBOutlet weak var imageView: UIImageView!

    var session: AVCaptureSession!
    var device: AVCaptureDevice!
    var output: AVCaptureVideoDataOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if initCamera() {
            session.startRunning()
        }
    }
    
    var taken: Bool = false
    @IBAction func take(_ sender: Any) {
        if !self.taken {
            self.taken = true
            self.imageView.image = ImageConverter.convert(self.imageView.image)
        }
    }
    
    func initCamera() -> Bool {
        session = AVCaptureSession()
        session.sessionPreset = AVCaptureSessionPresetMedium
        
        let devices = AVCaptureDevice.devices()
        
        for d in devices! {
            if ((d as AnyObject).position == AVCaptureDevicePosition.back) {
                device = d as! AVCaptureDevice
            }
        }
        if device == nil {
            return false
        }
        do {
            let myInput: AVCaptureDeviceInput?
            try myInput = AVCaptureDeviceInput(device: device)
            
            if session.canAddInput(myInput) {
                session.addInput(myInput)
            }else {
                return false
            }
            output = AVCaptureVideoDataOutput()
            output.videoSettings = [kCVPixelBufferPixelFormatTypeKey as AnyHashable: Int(kCVPixelFormatType_32BGRA)]
            
            try device.lockForConfiguration()
            device.activeVideoMinFrameDuration = CMTimeMake(1, 15)
            device.unlockForConfiguration()
            
            let queue: DispatchQueue = DispatchQueue(label: "MyQueue", attributes: [])
            output.setSampleBufferDelegate(self, queue: queue)
            output.alwaysDiscardsLateVideoFrames = true
        }catch let error as NSError {
            print(error)
            return false
        }
        if session.canAddOutput(output) {
            session.addOutput(output)
        }else {
            return false
        }
        for connection in output.connections {
            if let conn = connection as? AVCaptureConnection {
                if conn.isVideoOrientationSupported {
                    conn.videoOrientation = AVCaptureVideoOrientation.portrait
                }
            }
        }
        return true
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
        DispatchQueue.main.async(execute: {
            if !self.taken {
                let image: UIImage = CameraUtil.imageFromSampleBuffer(buffer: sampleBuffer)
                self.imageView.image = image
            }
        })
    }
}














