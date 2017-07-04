//
//  CoreTextUtil.m
//  富文本Demo
//
//  Created by caiyao's Mac on 2017/7/3.
//  Copyright © 2017年 core's Mac. All rights reserved.
//

#import "CoreTextUtil.h"
#import "UIView+Frame.h"

@implementation CoreTextUtil

+(CoreTextLinkData *)touchLinkInView:(UIView *)view
                             atPoint:(CGPoint)point
                                data:(CoreTextData *)data
{
    CTFrameRef tf = data.ctFrame;
    CFArrayRef lines = CTFrameGetLines(tf);
    if (!lines) return nil;
    CFIndex count = CFArrayGetCount(lines);
    //CoreTextLinkData *foundLink = nil;
    
    CGPoint origions[count];
    CTFrameGetLineOrigins(tf, CFRangeMake(0, 0), origions);
    
    CGAffineTransform transform = CGAffineTransformMakeTranslation(0, view.height);
    transform = CGAffineTransformScale(transform, 1, -1);
    
    CoreTextLinkData *result = nil;
    for (int i = 0; i < count; i ++)
    {
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        
        CGPoint lineOrigin = origions[i];
        
        CGRect flippedRect = [self getLineBounds:line origion:lineOrigin];
        CGRect rect = CGRectApplyAffineTransform(flippedRect, transform);
        if (CGRectContainsPoint(rect, point))
        {
            CGPoint relativePoint = CGPointMake(point.x-CGRectGetMinX(rect),
                                                point.y-CGRectGetMinY(rect));
            CFIndex idx = CTLineGetStringIndexForPosition(line, relativePoint);
            
            for (CoreTextLinkData *linkD in data.linkArray)
            {
                if (NSLocationInRange(idx, linkD.range))
                {
                    NSLog(@"link taped");
                    result = linkD;
                    break;
                }
            }
            
            break;
        }
    }
    
    return result;
}

+(CGRect)getLineBounds:(CTLineRef)line
               origion:(CGPoint)origin
{
    CGFloat ascent = 0.0f;
    CGFloat descent = 0.0f;
    CGFloat leading = 0.0f;
    CGFloat width = (CGFloat)CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    CGFloat height = ascent + descent;
    return CGRectMake(origin.x, origin.y - descent, width, height);
}
@end
