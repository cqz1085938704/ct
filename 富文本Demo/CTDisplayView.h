//
//  CTDisplayView.h
//  富文本Demo
//
//  Created by caiyao's Mac on 15/11/9.
//  Copyright © 2015年 core's Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import "CoreTextData.h"

@interface CTDisplayView : UIView

@property (nonatomic, strong)CoreTextData *data;

@end
