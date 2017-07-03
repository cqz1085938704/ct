//
//  CTFrameParser.h
//  富文本Demo
//
//  Created by caiyao's Mac on 15/11/9.
//  Copyright © 2015年 core's Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTFrameParserConfig.h"
#import "CoreTextData.h"
#import <CoreText/CoreText.h>
#import <CoreFoundation/CoreFoundation.h>
#import "CoreTextLinkData.h"

@interface CTFrameParser : NSObject

+ (CoreTextData *)loadFile:(CTFrameParserConfig *)config;
+ (CoreTextData *)parseContent:(NSString *)content config:(CTFrameParserConfig *)config;

@end
