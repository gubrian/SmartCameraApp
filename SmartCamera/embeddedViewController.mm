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

@synthesize videoCamera;
@synthesize imageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // Initialize camera
   
    self.videoCamera = [[CvVideoCamera alloc] initWithParentView:self.imageView];
    self.videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionFront;
    self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset352x288;
    self.videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    self.videoCamera.defaultFPS = 30;
    self.videoCamera.grayscaleMode = NO;
    self.videoCamera.delegate = self;
}

- (NSInteger)supportedInterfaceOrientations
{
    // Only portrait orientation
    return UIInterfaceOrientationMaskPortrait;
}

- (void)processImage:(cv::Mat&)image;
{
    Detection* face = [[FaceDetection alloc]init:faceDetector];
    [self detectAndDraw:face matImage:image];
}

-(void) detectAndDraw:(Detection*) detector matImage:(cv::Mat&) mat{
    std::vector<cv::Rect> results= [detector doDetection:mat detector:faceDetector];
    // Draw all detected faces
    for(unsigned int i = 0; i < results.size(); i++)
    {
        const cv::Rect& face = results[i];
        // Get top-left and bottom-right corner points
        cv::Point tl(face.x, face.y);
        cv::Point br = tl + cv::Point(face.width, face.height);
        
        // Draw rectangle around the face
        cv::Scalar magenta = cv::Scalar(255, 0, 255);
        cv::rectangle(mat, tl, br, magenta, 4, 8, 0);
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)start:(id)sender {
    [videoCamera start];
}
@end
