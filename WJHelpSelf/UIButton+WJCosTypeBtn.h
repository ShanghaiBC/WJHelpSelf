//
//  UIButton+WJCosTypeBtn.h
//  PrintSchoolProject
//
//  Created by Yuan Wang on 2017/9/21.
//  Copyright © 2017年 Yuan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    /// 图片在左，文字在右
    WJImagePositionStyleDefault,
    /// 图片在右，文字在左
    WJImagePositionStyleRight,
    /// 图片在上，文字在下
    WJImagePositionStyleTop,
    /// 图片在下，文字在上
    WJImagePositionStyleBottom,
} WJImagePositionStyle;

@interface UIButton (WJCosTypeBtn)

/**
 *  设置图片与文字样式
 *
 *  @param imagePositionStyle     图片位置样式
 *  @param spacing                图片与文字之间的间距
 */
- (void)WJ_imagePositionStyle:(WJImagePositionStyle)imagePositionStyle spacing:(CGFloat)spacing;

@end
