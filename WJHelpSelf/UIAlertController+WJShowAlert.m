//
//  UIAlertController+WJShowAlert.m
//  WJDemo
//
//  Created by Yuan Wang on 2018/1/30.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import "UIAlertController+WJShowAlert.h"

@implementation UIAlertController (WJShowAlert)

+ (UIAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message actions:(NSArray *)actions preferredStyle:(UIAlertControllerStyle)preferredStyle actionHandler:(void(^)(NSInteger))handler;{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    
    for (int i = 0; i < actions.count; i ++) {
        
        WJAlertAction *action = [WJAlertAction actionWithTitle:actions[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            WJAlertAction *jj_action = (WJAlertAction *)action;
            
            if (handler) {
                
                handler(jj_action.alertTag);
                
            }
            
        }];
        action.alertTag = i;
        [alertVC addAction:action];
    }
    
    return alertVC;
    
}

@end
