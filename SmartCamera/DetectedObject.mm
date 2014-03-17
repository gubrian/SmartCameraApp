//
//  DetectedObject.m
//  SmartCamera
//
//  Created by gubrian on 3/10/14.
//  Copyright (c) 2014 gubrian. All rights reserved.
//

#import "DetectedObject.h"

@implementation DetectedObject

-(id)init:(int)x Y:(int)yy Width:(int)wid Height:(int)h {
    _x = x;
    _y = yy;
    _width = wid;
    _height = h;
    _count = 1;
    return self;
}

-(BOOL) compare:(cv::Rect &) result {
    if(abs(_x - result.x < 10) && abs(_y - result.y < 10) && abs(_width - result.width) < 20 && abs(_height - result.height < 20)) {
        self.count ++;
        return YES;
    } else {
        return NO;
    }
}

-(BOOL) obCompare:(DetectedObject*) result {
    if(abs(_x - result.x < 10) && abs(_y - result.y < 10) && abs(_width - result.width) < 20 && abs(_height - result.height < 20)) {
        return YES;
    } else {
        return NO;
    }
}

@end
