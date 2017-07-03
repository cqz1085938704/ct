//
//  UIView+Frame.m
//  富文本Demo
//
//  Created by caiyao's Mac on 15/11/9.
//  Copyright © 2015年 core's Mac. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

-(CGFloat)x
{
    return self.frame.origin.x;
}

-(void)setX:(CGFloat)x
{
    self.frame = CGRectMake(x, self.y, self.width, self.height);
}

-(CGFloat)y
{
    return self.frame.origin.y;
}

-(void)setY:(CGFloat)y
{
    self.frame = CGRectMake(self.x, y, self.width, self.height);
}

-(CGFloat)width
{
    return self.frame.size.width;
}

-(void)setWidth:(CGFloat)width
{
    self.frame = CGRectMake(self.x, self.y, width, self.height);
}

-(CGFloat)height
{
    return self.frame.size.height;
}

-(void)setHeight:(CGFloat)height
{
    self.frame = CGRectMake(self.x, self.y, self.width, height);
}

@end
