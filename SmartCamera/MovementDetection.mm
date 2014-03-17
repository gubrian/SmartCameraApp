//
//  MovementDetection.m
//  SmartCamera
//
//  Created by gubrian on 3/4/14.
//  Copyright (c) 2014 gubrian. All rights reserved.
//

#import "MovementDetection.h"

@implementation MovementDetection

const int LBP = 10;
const int HARR = 5;

-(BOOL) eyeMove:(NSInteger) number moveSequence:(NSMutableArray*) sequence {
    int emptyCount = 0;
    if([sequence count] > 15) {
        for(int i = 0; i < [sequence count]; i++) {
            DetectedObject* o = [sequence objectAtIndex: i];
            if(o.width != -100 && o.count <= 10) {
                    if(i >= 1 && i < [sequence count] - 1 && ((DetectedObject*)[sequence objectAtIndex: i - 1]).width == -100 && ((DetectedObject*)[sequence objectAtIndex: i + 1]).width == -100) {
                    if(((DetectedObject*)[sequence objectAtIndex: i - 1]).count >= 2 && ((DetectedObject*)[sequence objectAtIndex: i - 1]).count < 4)
                        emptyCount ++;
                     if(((DetectedObject*)[sequence objectAtIndex: i + 1]).count >= 2 && ((DetectedObject*)[sequence objectAtIndex: i + 1]).count < 4)
                         emptyCount ++;
                }
            }
        }
        [sequence removeAllObjects];
    }
    if(emptyCount >= number && emptyCount< 2 * number) {
        return YES;
    }
    return NO;
}

-(BOOL) eyeMove:(NSMutableArray*) sequence {
    BOOL findLong = NO;
    if([sequence count] > 0) {
        for(int i = 0; i < [sequence count]; i++) {
            DetectedObject* o = [sequence objectAtIndex:i];
            if (o.width != -100 && o.count > 12) {
                findLong = YES;
                break;
            }
        }
        [sequence removeAllObjects];
        if(findLong) {
            return YES;
        }
    }
    return NO;
}


-(BOOL) faceMove:(NSInteger) number moveSequence:(NSMutableArray*) sequence {
    return NO;
}


-(BOOL) faceMove:(NSMutableArray*) sequence {
    
    BOOL findLong = NO;
    if([sequence count] > 0) {
        for(int i = 0; i < [sequence count]; i++) {
            DetectedObject* o = [sequence objectAtIndex:i];
            if (o.count > self.faceFps ) {
                findLong = YES;
                break;
            }
        }
        [sequence removeAllObjects];
        if(findLong) {
            return YES;
        }
    }
    return NO;
}


-(BOOL) judgeMove:(Detection*) detector detectorName:(NSString*) name {
    if([detector isKindOfClass:EyeDetection.class]) {
        return [self eyeMove:detector.sequence];
    }
    if([detector isKindOfClass:FaceDetection.class]) {
        self.faceFps = [name isEqual:@"Face Detection LBP"] ? LBP : HARR;
        return [self faceMove:detector.sequence];
    }
    return NO;
}

@end
