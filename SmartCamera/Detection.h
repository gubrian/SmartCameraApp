//
//  Detection.h
//  SmartCamera
//
//  Created by gubrian on 2/25/14.
//  Copyright (c) 2014 gubrian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <opencv2/opencv.hpp>


// The class for loading xml file, and do detection.
// Try to avoid duplicate image memory.
@interface Detection : NSObject
-(cv::CascadeClassifier) detector: (NSString*) file_name;

@end
