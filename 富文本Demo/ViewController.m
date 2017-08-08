//
//  ViewController.m
//  富文本Demo
//
//  Created by caiyao's Mac on 15/11/9.
//  Copyright © 2015年 core's Mac. All rights reserved.
//

#import "ViewController.h"

#define WIN_SIZE [UIScreen mainScreen].bounds.size

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CTFrameParserConfig *config = [[CTFrameParserConfig alloc] init];
    config.textColor = [UIColor blackColor];
    config.width = WIN_SIZE.width;
    config.fontSize = 25;
    
    CoreTextData *data = [CTFrameParser loadFile:config];
    
    CTDisplayView *view = [[CTDisplayView alloc] initWithFrame:CGRectMake(0, 20, WIN_SIZE.width, WIN_SIZE.height - 20)];
    view.data = data;
    view.height = data.height;
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
