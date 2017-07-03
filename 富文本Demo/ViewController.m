//
//  ViewController.m
//  富文本Demo
//
//  Created by caiyao's Mac on 15/11/9.
//  Copyright © 2015年 core's Mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.userInteractionEnabled = YES;
    
    CTDisplayView *view = [[CTDisplayView alloc] initWithFrame:CGRectMake(0, 20, 320, 320)];
    [self.view addSubview:view];
    
    CTFrameParserConfig *config = [[CTFrameParserConfig alloc] init];
    config.textColor = [UIColor blackColor];
    config.width = view.width;
    
    CoreTextData *data = [CTFrameParser loadFile:config];
    view.data = data;
    view.height = data.height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
