//
//  ViewController.m
//  WJUIButtonMove
//
//  Created by Yuan Wang on 2017/4/25.
//  Copyright © 2017年 Yuan Wang. All rights reserved.
//

#import "ViewController.h"
#import "WJShowView.h"

#define WJKSIZE self.view.frame

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WJShowView *show_v = [[WJShowView alloc]initWithFrame:CGRectMake(0, 40,self.view.frame.size.width,WJKSIZE.size.height*0.3 )];
//    show_v.margin = 20;
//    show_v.column  = 4;
//    show_v.list_arr =  @[@"么么哒",@"嚒嚒哒",@"嘎嘎哒",@"呵呵哒",@"撸啊撸",@"啦啦啦",@"哈哈哈"];
   
    [show_v showMargin:10 column:4 titleArray:@[@"么么哒",@"嚒嚒哒",@"嘎嘎哒",@"呵呵哒",@"撸啊撸",@"啦啦啦",@"哈哈哈"]];
    
    
    show_v.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:show_v];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
