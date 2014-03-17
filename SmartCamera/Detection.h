//
//  Detection.h
//  SmartCamera
//
//  Created by gubrian on 2/25/14.
//  Copyright (c) 2014 gubrian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "opencv2/highgui/ios.h"
#import "vector"
#import "opencv2/core/core.hpp"
#import "DetectedObject.h"

@interface Detection : NSObject
{
    cv::CascadeClassifier faceDetector;
}

@property NSMutableArray* sequence;

// Load the xml file
-(void) buildDetector: (NSString*) file_name;

// Do detection on the
-(std::vector<cv::Rect>) doDetection: (cv::Mat&) image;

-(void) updateSequence:(const std::vector<cv::Rect>&) faces;

// Store the image into camera roll.
-(void) storeImage:(cv::Mat&) oldImage;

// Transfer Mat to UIImage
- (UIImage *)imageWithCVMat:(const cv::Mat&)mat;

@end
