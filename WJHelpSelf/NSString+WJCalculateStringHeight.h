//
//  NSString+WJCalculateStringHeight.h
//  FudanUnion
//
//  Created by vijay on 2017/5/28.
//  Copyright © 2017年 skma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WJCalculateStringHeight)


/**
 计算文本高度

 @param size size description
 @param font font description
 @param lineSpacing lineSpacing description
 @return return value description   
 */
- (CGSize)boundingRectWithSize:(CGSize)size font:(UIFont*)font  lineSpacing:(CGFloat)lineSpacing;

/**
 *  计算最大行数文字高度,可以处理计算带行间距的
 */
- (CGFloat)boundingRectWithSize:(CGSize)size font:(UIFont*)font  lineSpacing:(CGFloat)lineSpacing maxLines:(NSInteger)maxLines;

/**
 *  计算是否超过一行   用于给Label 赋值attribute text的时候 超过一行设置lineSpace
 */
- (BOOL)isMoreThanOneLineWithSize:(CGSize)size font:(UIFont *)font lineSpaceing:(CGFloat)lineSpacing;

+ (CGFloat)heightWithString:(NSString *)string labelWidth:(CGFloat )width;

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

/*
 -设置富文本(行间距0.8倍的字体,字间距0.0)
 -@param1 字符串
 -@param2 字体大小 
 
 @return return value description
 */
+ (NSAttributedString *)stringWithFitString:(NSString *)string withFont:(CGFloat )font;

/*
 -设置富文本(行间距0.8倍的字体,字间距0.0)
 -@param1 字符串
 -@param2 段落距离
 -@param3 字体大小
 @return return value description
 */
+ (NSAttributedString *)stringWithFitString:(NSString *)string withParagraph:(CGFloat)para withFont:(CGFloat )font;

/**
 过滤 .mp3 ,MP4

 @param mediu mediu description
 @return return value description
 */
+ (NSString *)deleteSuffix:(NSString *)mediu;

/**
 限制字符串个数

 @param string 字符串
 @param count 限制个数
 @return 处理后的字符串
 */
+ (NSString *)limitString:(NSString *)string count:(NSInteger)count;

/*
 -判断emael
 
 @return return value description
 */
- (BOOL)isEmailAddress;


/**
 验证手机号

 @return return value description
 */
- (BOOL)isIphoneNumber;

@end
