//
//  EyeDetection.h
//  SmartCamera
//
//  Created by gubrian on 3/10/14.
//  Copyright (c) 2014 gubrian. All rights reserved.
//

#import "Detection.h"

@interface EyeDetection : Detection
// Loads the xml file for eye detection.
-(id) init;

-(void) updateSequence:(std::vector<cv::Rect>&) faces;

@end
