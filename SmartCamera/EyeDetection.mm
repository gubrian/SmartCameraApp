//
//  EyeDetection.m
//  SmartCamera
//
//  Created by gubrian on 3/10/14.
//  Copyright (c) 2014 gubrian. All rights reserved.
//

#import "EyeDetection.h"

@implementation EyeDetection

-(id) init{
    self = [super init];
    NSString* cascadePath = [[NSBundle mainBundle]
                             pathForResource:@"haarcascade_mcs_eyepair_big"
                             ofType:@"xml"];
    [super buildDetector:cascadePath];
    return self;
}

-(void) updateSequence:(std::vector<cv::Rect>&) faces {
    DetectedObject *o = [self.sequence lastObject];
    if(faces.empty()) {
        if(o.width == -100) {
            o.count++;
        } else {
            if(o.count == 1) {
                [self.sequence removeLastObject];
            }
            [self.sequence addObject:[[DetectedObject alloc]init:-100 Y:-100 Width:-100 Height:-100]];
        }
        return;
    }
    if(![o compare:faces[0]]) {
        if(o.count == 1) {
            [self.sequence removeLastObject];
        }
        [self.sequence addObject:[[DetectedObject alloc]init:faces[0].x Y:faces[0].y Width:faces[0].width Height:faces[0].height]];
    }
    
}

@end
