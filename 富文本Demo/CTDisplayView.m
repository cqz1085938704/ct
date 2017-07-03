//
//  CTDisplayView.m
//  富文本Demo
//
//  Created by caiyao's Mac on 15/11/9.
//  Copyright © 2015年 core's Mac. All rights reserved.
//

#import "CTDisplayView.h"
#import "CoreTextUtil.h"

@implementation CTDisplayView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesHandle:)];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:tapGes];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)tapGesHandle:(UITapGestureRecognizer *)tapGes
{
    [CoreTextUtil touchLinkInView:self atPoint:[tapGes locationInView:self] data:self.data];
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
