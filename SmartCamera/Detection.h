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

@interface Detection : NSObject
// Load the xml file
-(void) detector: (NSString*) file_name facedetector:(cv::CascadeClassifier&) faceDetector;

// Do detection on the
-(std::vector<cv::Rect>) doDetection: (cv::Mat&) image detector:(cv::CascadeClassifier&) faceDetector;

@end
