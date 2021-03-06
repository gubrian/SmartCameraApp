//
//  FaceDetection.h
//  SmartCamera
//
//  Created by gubrian on 2/26/14.
//  Copyright (c) 2014 gubrian. All rights reserved.
//

#import "Detection.h"

@interface FaceDetection : Detection

// Loads the xml file for face detection.
-(id) init:(int) index;

-(void) updateSequence:(std::vector<cv::Rect>&) faces;

@end
