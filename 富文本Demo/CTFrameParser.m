//
//  CTFrameParser.m
//  富文本Demo
//
//  Created by caiyao's Mac on 15/11/9.
//  Copyright © 2015年 core's Mac. All rights reserved.
//

#import "CTFrameParser.h"

@implementation CTFrameParser

+ (NSDictionary *)attributesWithConfig:(CTFrameParserConfig *)config
{
    CGFloat fontSize = config.fontSize;
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
    CGFloat lineSpacing = config.lineSpace;
    const CFIndex kNumberOfSettings = 3;
    CTParagraphStyleSetting theSettings[kNumberOfSettings] = {
    
        {kCTParagraphStyleSpecifierLineSpacingAdjustment, sizeof(CGFloat), &lineSpacing},
        {kCTParagraphStyleSpecifierMaximumLineSpacing, sizeof(CGFloat), &lineSpacing},
        {kCTParagraphStyleSpecifierMinimumLineSpacing, sizeof(CGFloat), &lineSpacing}
        
    };
    
    CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, kNumberOfSettings);
    
    UIColor *textColor = config.textColor;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:1];
    dict[(id)kCTForegroundColorAttributeName] = (id)textColor;
    dict[(id)kCTFontAttributeName] = (__bridge id)fontRef;
    dict[(id)kCTParagraphStyleAttributeName] = (__bridge id)theParagraphRef;
    
    CFRelease(theParagraphRef);
    CFRelease(fontRef);
    return dict;
}

+(CoreTextData *)loadFile:(CTFrameParserConfig *)config
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"template" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSArray *contentsArr = dic[@"contents"];
    
    NSMutableArray *linkArr = [NSMutableArray array];
    NSMutableAttributedString *mas = [[NSMutableAttributedString alloc] init];
    for (NSDictionary *infoDic in contentsArr)
    {
        if ([infoDic[@"type"] isEqualToString:@"txt"])
        {
            NSAttributedString *as = [[NSAttributedString alloc] initWithString:infoDic[@"title"] attributes:@{NSForegroundColorAttributeName:config.textColor, NSFontAttributeName:[UIFont systemFontOfSize:config.fontSize]}];
            [mas appendAttributedString:as];
        }
        else if ([infoDic[@"type"] isEqualToString:@"link"])
        {
            CoreTextLinkData *linkData = [[CoreTextLinkData alloc] init];
            linkData.title = infoDic[@"title"];
            linkData.link = infoDic[@"url"];
            linkData.range = NSMakeRange(mas.length, [infoDic[@"title"] length]);
            [linkArr addObject:linkData];
            
            NSAttributedString *as = [[NSAttributedString alloc] initWithString:infoDic[@"title"] attributes:@{NSForegroundColorAttributeName:config.linkColor, NSFontAttributeName:[UIFont systemFontOfSize:config.fontSize]}];
            [mas appendAttributedString:as];
        }
        else
        {
            NSLog(@"unsupported type");
        }
    }
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)mas);
    
    CGSize restrictSize = CGSizeMake(config.width, CGFLOAT_MAX);
    CGSize coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(frameSetter, CFRangeMake(0, 0), nil, restrictSize, nil);
    CGFloat textHeight = coreTextSize.height;
    
    CTFrameRef frame = [self createFrameWithFrameSetter:frameSetter config:config height:textHeight];
    
    CoreTextData *d = [[CoreTextData alloc] init];
    d.ctFrame = frame;
    d.height = textHeight;
    d.linkArray = linkArr;
    d.mString = mas;
    
    CFRelease(frame);
    CFRelease(frameSetter);
    
    return d;
}

+(CoreTextData *)parseContent:(NSString *)content
                       config:(CTFrameParserConfig *)config
{
    NSDictionary *attributes = [self attributesWithConfig:config];
    NSMutableAttributedString *contentString = [[NSMutableAttributedString alloc] initWithString:content attributes:attributes];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)contentString);
    
    CGSize restrictSize = CGSizeMake(config.width, CGFLOAT_MAX);
    CGSize coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(frameSetter, CFRangeMake(0, 0), nil, restrictSize, nil);
    CGFloat textHeight = coreTextSize.height;
    
    CTFrameRef frame = [self createFrameWithFrameSetter:frameSetter config:config height:textHeight];
    
    CoreTextData *data = [[CoreTextData alloc] init];
    data.ctFrame = frame;
    data.height = textHeight;

    CFRelease(frame);
    CFRelease(frameSetter);
    return data;
}

+ (CTFrameRef)createFrameWithFrameSetter:(CTFramesetterRef)frameSetter
                                  config:(CTFrameParserConfig *)config
                                  height:(CGFloat)height
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, config.width, height));
    
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    CFRelease(path);
    return frame;
}
@end
