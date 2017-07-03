//
//  CTFrameParserConfig.h
//  富文本Demo
//
//  Created by caiyao's Mac on 15/11/9.
//  Copyright © 2015年 core's Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@interface CTFrameParserConfig : NSObject

@property (nonatomic, assign)CGFloat width;
@property (nonatomic, assign)CGFloat fontSize;
@property (nonatomic, assign)CGFloat lineSpace;
@property (nonatomic, strong)UIColor *textColor;

@end
