//
//  MovementDetection.h
//  SmartCamera
//
//  Created by gubrian on 3/4/14.
//  Copyright (c) 2014 gubrian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetectedObject.h"
#import "EyeDetection.h"
#import "FaceDetection.h"

@interface MovementDetection : NSObject

@property int faceFps;

// The cache to store the recently used face data structures.
-(BOOL) judgeMove:(Detection*) detector detectorName:(NSString*) name;

// Gets eye blink twice and do photo.
-(BOOL) eyeMove:(NSInteger) number moveSequence:(NSMutableArray*) sequence;

// If the eyes are stable, we will photo.
-(BOOL) eyeMove:(NSMutableArray*) sequence;

// If people nod twice, we will photo.
-(BOOL) faceMove:(NSInteger) number moveSequence:(NSMutableArray*) sequence;

// We judge that if there is a pause for user in the screen, we just take photo.
-(BOOL) faceMove:(NSMutableArray*) sequence;

@end
