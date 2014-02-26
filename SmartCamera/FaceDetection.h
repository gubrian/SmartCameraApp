//
//  FaceDetection.h
//  SmartCamera
//
//  Created by gubrian on 2/26/14.
//  Copyright (c) 2014 gubrian. All rights reserved.
//

#import "Detection.h"

@interface FaceDetection : Detection
-(id) init: (cv::CascadeClassifier&) faceDetector;

@end
