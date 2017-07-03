//
//  CTFrameParserConfig.m
//  富文本Demo
//
//  Created by caiyao's Mac on 15/11/9.
//  Copyright © 2015年 core's Mac. All rights reserved.
//

#import "CTFrameParserConfig.h"

@implementation CTFrameParserConfig

-(instancetype)init
{
    if (self = [super init])
    {
        _width = 200.0f;
        _fontSize = 16.0f;
        _lineSpace = 8.0f;
        _textColor = [UIColor colorWithRed:108/255.0 green:108/255.0 blue:108/255.0 alpha:1];
    }
    return self;
}

@end
