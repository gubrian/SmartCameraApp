//
//  embeddedViewController.h
//  SmartCamera
//
//  Created by gubrian on 2/24/14.
//  Copyright (c) 2014 gubrian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EyeDetection.h"
#import "FaceDetection.h"
#import "MouthDetection.h"
#import "MovementDetection.h"
#import "rollViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface embeddedViewController : UIViewController<CvVideoCameraDelegate> {
    CvVideoCamera* videoCamera;
    IBOutlet UIImageView *imageView;
    IBOutlet UILabel *timeCount;
}

@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property BOOL switchTab;
@property (strong, nonatomic) IBOutlet UILabel *fpsIndicator;
@property (strong, nonatomic) Detection* face;
@property (nonatomic, strong) CvVideoCamera* videoCamera;
@property NSInteger seconds;
@property NSTimer *timer;
@property cv::Mat oldImage;
@property NSInteger frames;
@property NSDate *currentDate;
@property MovementDetection* move;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property NSString* currentDetector;

// Change the camera.
- (IBAction)changeCamera:(id)sender;
// Cancel the photo stuff
- (IBAction)cancel:(id)sender;
// The timer function for taking picture
-(void)timerFireMethod:(NSTimer *)theTimer;
// Used to know the fps in the detection.
-(void) updateFPS;
// Start the timer counter and take photo.
-(void) takePhoto;
// Use the different feature to do detection
-(void) changeDetection:(NSString*) item;
// Draw the single result on the image.
-(void) drawSingle:(cv::Mat&) mat singleResult:(const cv::Rect&) single;
// Stop the watch.
-(void) stopWatch;
@end
