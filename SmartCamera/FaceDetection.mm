//
//  FaceDetection.m
//  SmartCamera
//
//  Created by gubrian on 2/26/14.
//  Copyright (c) 2014 gubrian. All rights reserved.
//

#import "FaceDetection.h"

@implementation FaceDetection

-(id) init:(int) index{
    if(index == 0) {
        self = [super init];
        NSString* cascadePath = [[NSBundle mainBundle]
                             pathForResource:@"haarcascade_frontalface_alt"
                             ofType:@"xml"];
        [super buildDetector:cascadePath];
    } else {
        self = [super init];
        NSString* cascadePath = [[NSBundle mainBundle]
                                 pathForResource:@"lbpcascade_frontalface"
                                 ofType:@"xml"];
        [super buildDetector:cascadePath];
    }
    return self;
}

-(void) updateSequence:(std::vector<cv::Rect>&) faces {
    DetectedObject *o = [self.sequence lastObject];
    if(!faces.empty() && (o== nil || (o != nil && ![o compare:faces[0]]))) {
        [self.sequence addObject:[[DetectedObject alloc]init:faces[0].x Y:faces[0].y Width:faces[0].width Height:faces[0].height]];
    }
}

@end
