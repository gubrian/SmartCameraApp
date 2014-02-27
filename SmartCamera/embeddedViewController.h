//
//  embeddedViewController.h
//  SmartCamera
//
//  Created by gubrian on 2/24/14.
//  Copyright (c) 2014 gubrian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Detection.h"
#import "FaceDetection.h"
#include "opencv2/core/core.hpp"

@interface embeddedViewController : UIViewController<CvVideoCameraDelegate> {
    cv::CascadeClassifier faceDetector;
    CvVideoCamera* videoCamera;
    IBOutlet UIImageView *imageView;
}

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) CvVideoCamera* videoCamera;
- (IBAction)start:(id)sender;



@end
