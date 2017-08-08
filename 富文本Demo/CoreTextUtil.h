//
//  CoreTextUtil.h
//  富文本Demo
//
//  Created by caiyao's Mac on 2017/7/3.
//  Copyright © 2017年 core's Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "CoreTextLinkData.h"

@interface CoreTextUtil : NSObject

+(CGRect)getRectInView:(UIView *)view
               atPoint:(CGPoint)point
                  data:(CoreTextData *)data;
+(CoreTextLinkData *)touchLinkInView:(UIView *)view
                             atPoint:(CGPoint)point
                                data:(CoreTextData *)data;

@end
