//
//  UIAlertController+WJShowAlert.h
//  WJDemo
//
//  Created by Yuan Wang on 2018/1/30.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (WJShowAlert)

/**
 展示一个弹窗
 
 @param title 标题
 @param message 内容
 @param actions 按钮的标题
 @param handler handler description
 @return return value description
 */
+ (UIAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message actions:(NSArray *)actions preferredStyle:(UIAlertControllerStyle)preferredStyle actionHandler:(void(^)(NSInteger))handler;

@end
