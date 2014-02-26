//
//  embeddedViewController.m
//  SmartCamera
//
//  Created by gubrian on 2/24/14.
//  Copyright (c) 2014 gubrian. All rights reserved.
//

#import "embeddedViewController.h"

@interface embeddedViewController ()

@end

@implementation embeddedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //We should add a function to import image.
    UIImage* image = [UIImage imageNamed:@"lena.png"];
    
    Detection* face = [[FaceDetection alloc]init:faceDetector];
    std::vector<cv::Rect> results= [face doDetection:image detector:faceDetector];
    
    cv::Mat faceImage;
    UIImageToMat(image, faceImage);
    
    // Draw all detected faces
    for(unsigned int i = 0; i < results.size(); i++)
    {
        const cv::Rect& face = results[i];
        // Get top-left and bottom-right corner points
        cv::Point tl(face.x, face.y);
        cv::Point br = tl + cv::Point(face.width, face.height);
        
        // Draw rectangle around the face
        cv::Scalar magenta = cv::Scalar(255, 0, 255);
        cv::rectangle(faceImage, tl, br, magenta, 4, 8, 0);
    }
    
    // Show resulting image
    self.imageView.image = MatToUIImage(faceImage);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
