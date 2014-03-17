//
//  MouthDetection.m
//  SmartCamera
//
//  Created by gubrian on 3/10/14.
//  Copyright (c) 2014 gubrian. All rights reserved.
//

#import "MouthDetection.h"

@implementation MouthDetection

-(id) init{
    self = [super init];
    NSString* cascadePath = [[NSBundle mainBundle]
                             pathForResource:@"haarcascade_mcs_mouth"
                             ofType:@"xml"];
    [super buildDetector:cascadePath];
    return self;
}

@end
