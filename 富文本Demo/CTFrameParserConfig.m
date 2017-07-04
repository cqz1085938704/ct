//
//  CTFrameParserConfig.m
//  富文本Demo
//
//  Created by caiyao's Mac on 15/11/9.
//  Copyright © 2015年 core's Mac. All rights reserved.
//

#import "CTFrameParserConfig.h"

#define WIN_SIZE [UIScreen mainScreen].bounds.size

@implementation CTFrameParserConfig

-(instancetype)init
{
    if (self = [super init])
    {
        _width = WIN_SIZE.width;
        _fontSize = 16.0f;
        _lineSpace = 8.0f;
        _textColor = [UIColor blackColor];
        _linkColor = [UIColor blueColor];
    }
    return self;
}

@end
