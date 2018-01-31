//
//  WJShowView.h
//  WJUIButtonMove
//
//  Created by Yuan Wang on 2017/4/25.
//  Copyright © 2017年 Yuan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BTN_HEIGHT 40 //按钮的高度

@interface WJShowView : UIView
@property(weak,nonatomic)UIButton                *cell_btn;    //button
@property (strong ,nonatomic) NSMutableArray *button_Arr;      //button 数组
- (void)showMargin:(int)margin column:(int)column titleArray:(NSArray<NSString *>*)listArr;

@end
