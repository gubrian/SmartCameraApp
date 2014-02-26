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

@interface embeddedViewController : UIViewController {
    cv::CascadeClassifier faceDetector;
}

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end
