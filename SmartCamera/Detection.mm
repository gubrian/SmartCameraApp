//
//  Detection.m
//  SmartCamera
//
//  Created by gubrian on 2/25/14.
//  Copyright (c) 2014 gubrian. All rights reserved.
//

#import "Detection.h"

@implementation Detection

@synthesize sequence;

// This function will load the xml file in file_name and initialize the cascade classifier
-(void) buildDetector: (NSString*) file_name {
    faceDetector.load([file_name UTF8String]);
    sequence = [[NSMutableArray alloc]init];
}

-(std::vector<cv::Rect>) doDetection: (cv::Mat&) faceImage {
    cv::Mat gray;
    cvtColor(faceImage, gray, CV_BGR2GRAY);
    std::vector<cv::Rect> faces;
    faceDetector.detectMultiScale(gray, faces, 1.1,
                                  2, 0|CV_HAAR_SCALE_IMAGE, cv::Size(30, 30));
    [self updateSequence:faces];
    return faces;
}

-(void) storeImage:(cv::Mat&) oldImage{
    UIImage* img = [self imageWithCVMat: oldImage];
    UIImageWriteToSavedPhotosAlbum(img,nil,nil,nil);
}

-(void) updateSequence:(const std::vector<cv::Rect>&) faces {
    
}

- (UIImage *)imageWithCVMat:(const cv::Mat&)mat
{
    cv::Mat cvMat;
    cv::cvtColor( mat, cvMat, CV_BGR2RGB);
    NSData *data = [NSData dataWithBytes:cvMat.data length:cvMat.elemSize() * cvMat.total()];
    CGColorSpaceRef colorSpace;
    if (cvMat.elemSize() == 1) {
        colorSpace = CGColorSpaceCreateDeviceGray();
    } else {
        colorSpace = CGColorSpaceCreateDeviceRGB();
    }
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    CGImageRef imageRef = CGImageCreate(cvMat.cols,                                     // Width
                                        cvMat.rows,                                     // Height
                                        8,                                              // Bits per component
                                        8 * cvMat.elemSize(),                           // Bits per pixel
                                        cvMat.step[0],                                  // Bytes per row
                                        colorSpace,                                     // Colorspace
                                        kCGImageAlphaNone | kCGBitmapByteOrderDefault,  // Bitmap info flags
                                        provider,                                       // CGDataProviderRef
                                        NULL,                                           // Decode
                                        false,                                          // Should interpolate
                                        kCGRenderingIntentDefault);                     // Intent
    
    UIImage *image = [[UIImage alloc] initWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    return image;
}


@end
