//
//  FaceDetection.m
//  SmartCamera
//
//  Created by gubrian on 2/26/14.
//  Copyright (c) 2014 gubrian. All rights reserved.
//

#import "FaceDetection.h"

@implementation FaceDetection

-(id) init: (cv::CascadeClassifier&) faceDetector{
    self = [super init];
    NSString* cascadePath = [[NSBundle mainBundle]
                             pathForResource:@"haarcascade_frontalface_alt"
                             ofType:@"xml"];
    [self detector:cascadePath facedetector:faceDetector];
    return self;
}

@end
