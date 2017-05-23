//
//  ImageConverter.m
//  OpenCVSwiftTest
//
//  Created by Okaylens-Ares on 23/05/2017.
//  Copyright © 2017 Okaylens-Ares. All rights reserved.
//
#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "OpenCVSwiftTest-Bridging-Header.h"
#import "ImageConverter.h"

@implementation ImageConverter

+ (UIImage *)ConvertImage:(UIImage *)image {
    cv::Mat mat;
    UIImageToMat(image, mat);

    cv::Mat gray;
    cv::cvtColor(mat, gray, CV_RGB2GRAY);
    
    cv::Mat bin;
    cv::threshold(gray, bin, 0, 255, cv::THRESH_BINARY | cv::THRESH_OTSU);
    
    UIImage *binImg = MatToUIImage(bin);
    return binImg;

}

@end
