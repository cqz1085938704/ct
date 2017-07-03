//
//  CoreTextLinkData.h
//  富文本Demo
//
//  Created by caiyao's Mac on 2017/7/3.
//  Copyright © 2017年 core's Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreTextData.h"

@interface CoreTextLinkData : NSObject

@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *link;
@property (nonatomic, assign)NSRange range;

@end
