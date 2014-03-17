//
//  DetectedObject.h
//  SmartCamera
//
//  Created by gubrian on 3/10/14.
//  Copyright (c) 2014 gubrian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetectedObject : NSObject

@property int x;
@property int y;
@property int width;
@property int height;
@property int count;

-(id)init:(int)x Y:(int)yy Width:(int)wid Height:(int)h;

-(BOOL) compare:(cv::Rect &) result;

-(BOOL) obCompare:(DetectedObject*) result;
@end
