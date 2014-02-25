//
//  Detection.m
//  SmartCamera
//
//  Created by gubrian on 2/25/14.
//  Copyright (c) 2014 gubrian. All rights reserved.
//

#import "Detection.h"

@implementation Detection
-(cv::CascadeClassifier) detector: (NSString*) file_name {
    cv::CascadeClassifier faceDetector;
    faceDetector.load([file_name UTF8String]);
    return faceDetector;
}

@end
