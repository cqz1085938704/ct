//
//  CoreTextData.m
//  富文本Demo
//
//  Created by caiyao's Mac on 15/11/9.
//  Copyright © 2015年 core's Mac. All rights reserved.
//

#import "CoreTextData.h"

@implementation CoreTextData

- (void)setCtFrame:(CTFrameRef)ctFrame
{
    if (_ctFrame != ctFrame)
    {
        if (_ctFrame != nil)
        {
            CFRelease(_ctFrame);
        }
        CFRetain(ctFrame);
        _ctFrame = ctFrame;
    }
}

-(void)dealloc
{
    if (_ctFrame != nil)
    {
        CFRelease(_ctFrame);
        _ctFrame = nil;
    }
}

@end
