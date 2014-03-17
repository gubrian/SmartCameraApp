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

const int SECONDS_PHOTO = 3;

@synthesize videoCamera;
@synthesize imageView;

-(void)timerFireMethod:(NSTimer *)theTimer {
    if (self.seconds == 0) {
        [self stopWatch];
        AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
        // We stop the phone and take photo for the user.
        [self.face storeImage:_oldImage];
        //Since A User don't want to do photo second time, we remove all the objects in the  tracking sequence.
        [self.face.sequence removeAllObjects];
    }else{
        self.seconds--;
        NSString *title = [NSString stringWithFormat:@"%ld seconds left", (long)self.seconds];
        timeCount.text = title;
    }
}

-(Detection *)face {
    if(_face == nil) {
        _face = [[FaceDetection alloc]init:0];
    }
    return _face;
}

-(void) changeDetection:(NSString*) item {
    [self.face.sequence removeAllObjects];
    if(![self.currentDetector isEqualToString:item]) {
        
        if([item  isEqual: @"Face Detection"]) {
            _face = [[FaceDetection alloc]init:0];
        }
        if([item  isEqual: @"Face Detection LBP"]) {
            _face = [[FaceDetection alloc]init:1];
        }
        if([item  isEqual: @"Eye Detection"]) {
            _face = [[EyeDetection alloc]init];
        }
        if([item  isEqual: @"Mouth Detection"]) {
            _face = [[MouthDetection alloc]init];
        }
        self.currentDetector = item;
    }
}

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
    self.seconds = SECONDS_PHOTO;
    self.frames = 0;
    self.move = [[MovementDetection alloc]init];
    self.currentDate = [[NSDate alloc] init];
    self.switchTab = NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        [videoCamera start];
    });
}



- (void)processImage:(cv::Mat&)image;
{
    if(!self.switchTab) {
        [self updateFPS];
        [self detectAndDraw:self.face matImage:image];
        self.oldImage = image.clone();
    }
}

-(void) updateFPS{
    self.frames++;
    if(self.frames >= 15) {
        double timeInterval = 0;
        NSDate *timeElapsed =  [[NSDate alloc] init];
        timeInterval = [timeElapsed timeIntervalSinceDate:self.currentDate];
        timeInterval = (double)self.frames / timeInterval;
        self.currentDate = timeElapsed;
        self.frames = 0;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.fpsIndicator.text = [NSString stringWithFormat:@"FPS:%lf", timeInterval];
        });
        if([self.move judgeMove:self.face detectorName:self.currentDetector]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if(![self.timer isValid])
                   [self takePhoto];
            });
        }
    }
}

-(void) takePhoto{
    timeCount.alpha = 1;
    self.cancelButton.alpha = 1;
    NSString *title = [NSString stringWithFormat:@"%ld seconds left", (long)self.seconds];
    timeCount.text = title;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
}

-(void) detectAndDraw:(Detection*) detector matImage:(cv::Mat&) mat{
    std::vector<cv::Rect> results= [detector doDetection:mat];
    // Draw all detected faces
    if(!results.empty()) {
        if(![self.face isKindOfClass:MouthDetection.class])
        {
            const cv::Rect& single = results[0];
            [self drawSingle:mat singleResult:single];
        } else {
            for( int i = 0; i < MIN(results.size(),3); i++) {
                const cv::Rect& single = results[i];
                [self drawSingle:mat singleResult:single];
            }
        }
    }
}

-(void) drawSingle:(cv::Mat&) mat singleResult:(const cv::Rect&) single {
    // Get top-left and bottom-right corner points
    cv::Point tl(single.x, single.y);
    cv::Point br = tl + cv::Point(single.width, single.height);
    // Draw rectangle around the face
    cv::Scalar magenta = cv::Scalar(255, 0, 255);
    cv::rectangle(mat, tl, br, magenta, 4, 8, 0);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender {
    [self stopWatch];
}

-(void) stopWatch {
    if([self.timer isValid]) {
        [self.timer invalidate];
        self.seconds = SECONDS_PHOTO;
        timeCount.alpha = 0;
        self.cancelButton.alpha = 0;
    }
    [self.face.sequence removeAllObjects];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.switchTab = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [self stopWatch];
    self.switchTab = YES;
}

- (IBAction)changeCamera:(id)sender {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self stopWatch];
        [self.videoCamera stop];
        if(self.videoCamera.defaultAVCaptureDevicePosition == AVCaptureDevicePositionFront) {
            self.videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;
        } else {
            self.videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionFront;
        }
        [self.videoCamera start];
    });
}
@end
