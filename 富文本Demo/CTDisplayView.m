//
//  CTDisplayView.m
//  富文本Demo
//
//  Created by caiyao's Mac on 15/11/9.
//  Copyright © 2015年 core's Mac. All rights reserved.
//

#import "CTDisplayView.h"
#import "CoreTextUtil.h"
#import "CTFrameParser.h"

#define WIN_SIZE [UIScreen mainScreen].bounds.size

@interface CTDisplayView ()

@property (nonatomic, strong)CoreTextLinkData *currentSelectedLink;

@end

@implementation CTDisplayView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)showTouchFeedback:(BOOL)show withLink:(CoreTextLinkData *)link
{
    if (show)
    {
        [self.data.mString addAttribute:NSBackgroundColorAttributeName value:[UIColor lightGrayColor] range:link.range];
    }
    else
    {
        [self.data.mString removeAttribute:NSBackgroundColorAttributeName range:link.range];
    }
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self.data.mString);
    
    CGSize restrictSize = CGSizeMake(WIN_SIZE.width, CGFLOAT_MAX);
    CGSize coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(frameSetter, CFRangeMake(0, 0), nil, restrictSize, nil);
    CGFloat textHeight = coreTextSize.height;
    
    CTFrameParserConfig *config = [[CTFrameParserConfig alloc] init];
    config.width = WIN_SIZE.width;
    
    CTFrameRef frame = [CTFrameParser createFrameWithFrameSetter:frameSetter config:config height:textHeight];
    self.data.ctFrame = frame;
    [self setNeedsDisplay];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CoreTextLinkData *link = [CoreTextUtil touchLinkInView:self atPoint:[[touches anyObject] locationInView:self] data:self.data];
    if (!link)
    {
        return;
    }
    
    self.currentSelectedLink = link;
    [self showTouchFeedback:YES withLink:link];
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self showTouchFeedback:NO withLink:self.currentSelectedLink];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self showTouchFeedback:NO withLink:self.currentSelectedLink];
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1, -1);
    
    if (self.data)
    {
        CTFrameDraw(self.data.ctFrame, context);
    }
}

@end
