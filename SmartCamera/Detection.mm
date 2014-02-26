//
//  Detection.m
//  SmartCamera
//
//  Created by gubrian on 2/25/14.
//  Copyright (c) 2014 gubrian. All rights reserved.
//

#import "Detection.h"

@implementation Detection

-(void) detector: (NSString*) file_name facedetector:(cv::CascadeClassifier&) faceDetector{
    faceDetector.load([file_name UTF8String]);
}

-(std::vector<cv::Rect>) doDetection: (UIImage*) image detector:(cv::CascadeClassifier&)faceDetector{
    cv::Mat faceImage;
    UIImageToMat(image, faceImage);
    cv::Mat gray;
    cvtColor(faceImage, gray, CV_BGR2GRAY);
    std::vector<cv::Rect> faces;
    faceDetector.detectMultiScale(gray, faces, 1.1,
                                  2, 0|CV_HAAR_SCALE_IMAGE, cv::Size(30, 30));
    // Draw all detected faces
    for(unsigned int i = 0; i < faces.size(); i++)
    {
        const cv::Rect& face = faces[i];
        // Get top-left and bottom-right corner points
        cv::Point tl(face.x, face.y);
        cv::Point br = tl + cv::Point(face.width, face.height);
        
        // Draw rectangle around the face
        cv::Scalar magenta = cv::Scalar(255, 0, 255);
        cv::rectangle(faceImage, tl, br, magenta, 4, 8, 0);
    }

    
    return faces;
}

@end
