//
//  CameraUtil.swift
//  OpenCVSwiftTest
//
//  Created by Okaylens-Ares on 23/05/2017.
//  Copyright © 2017 Okaylens-Ares. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class CameraUtil {
    
    class func imageFromSampleBuffer(buffer: CMSampleBuffer) -> UIImage {
        let pixelBuffer: CVImageBuffer = (CMSampleBufferGetImageBuffer(buffer))!
        let ciImage: CIImage = CIImage(cvPixelBuffer: pixelBuffer)
        
        let pixelBufferWidth: CGFloat = CGFloat(CVPixelBufferGetWidth(pixelBuffer))
        let pixelBufferHeight: CGFloat = CGFloat(CVPixelBufferGetHeight(pixelBuffer))
        let imageRec: CGRect = CGRect(x: 0, y: 0, width: pixelBufferWidth, height: pixelBufferHeight)
        let ciContext: CIContext = CIContext.init()
        let cgimage = ciContext.createCGImage(ciImage, from: imageRec)
        let image: UIImage = UIImage(cgImage: cgimage!)
        return image
    }
    
    class func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
}
