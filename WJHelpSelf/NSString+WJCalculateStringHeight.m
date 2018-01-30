//
//  NSString+WJCalculateStringHeight.m
//  FudanUnion
//
//  Created by vijay on 2017/5/28.
//  Copyright © 2017年 skma. All rights reserved.
//

#import "NSString+WJCalculateStringHeight.h"

@implementation NSString (WJCalculateStringHeight)

/**
 * 计算文字高度，可以处理计算带行间距的
 */
- (CGSize)boundingRectWithSize:(CGSize)size font:(UIFont*)font  lineSpacing:(CGFloat)lineSpacing
{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    [attributeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.length)];
    [attributeString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, self.length)];
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect = [attributeString boundingRectWithSize:size options:options context:nil];
    
    //    NSLog(@"size:%@", NSStringFromCGSize(rect.size));
    
    //文本的高度减去字体高度小于等于行间距，判断为当前只有1行
    if ((rect.size.height - font.lineHeight) <= paragraphStyle.lineSpacing) {
        if ([self containChinese:self]) {  //如果包含中文
            rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height-paragraphStyle.lineSpacing);
        }
    }
    
    
    return rect.size;
}
//判断如果包含中文
- (BOOL)containChinese:(NSString *)str {
    for(int i=0; i< [str length];i++){ int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    }
    return NO;
}

/**
 *  计算最大行数文字高度,可以处理计算带行间距的
 */
- (CGFloat)boundingRectWithSize:(CGSize)size font:(UIFont*)font  lineSpacing:(CGFloat)lineSpacing maxLines:(NSInteger)maxLines{
    
    if (maxLines <= 0) {
        return 0;
    }
    
    CGFloat maxHeight = font.lineHeight * maxLines + lineSpacing * (maxLines - 1);
    
    CGSize orginalSize = [self boundingRectWithSize:size font:font lineSpacing:lineSpacing];
    
    if ( orginalSize.height >= maxHeight ) {
        return maxHeight;
    }else{
        return orginalSize.height;
    }
}
/**
 *  计算是否超过一行   用于给Label 赋值attribute text的时候 超过一行设置lineSpace
 */
- (BOOL)isMoreThanOneLineWithSize:(CGSize)size font:(UIFont *)font lineSpaceing:(CGFloat)lineSpacing{
    
    if ( [self boundingRectWithSize:size font:font lineSpacing:lineSpacing].height > font.lineHeight  ) {
        return YES;
    }else{
        return NO;
    }
}




+ (CGFloat)heightWithString:(NSString *)string labelWidth:(CGFloat )width{
    
     CGRect rect = [string boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    
    return rect.size.height;
}



- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

+ (NSAttributedString *)stringWithFitString:(NSString *)string withFont:(CGFloat )font{
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = 0.2*font; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font], NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.0f
                          };
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:string attributes:dic];
    return  attributeStr;
}

+ (NSAttributedString *)stringWithFitString:(NSString *)string withParagraph:(CGFloat)para withFont:(CGFloat )font{
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = 0.2*font; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.paragraphSpacing = para;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font], NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.0f
                          };
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:string attributes:dic];
    return  attributeStr;
}

//邮箱
- (BOOL)isEmailAddress{
    NSString *emailRegex = @"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self isValidateByRegex:emailRegex];
}

#pragma mark - 正则相关
- (BOOL)isValidateByRegex:(NSString *)regex{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:self];
}


- (BOOL)isIphoneNumber{
    
//    mobileNum = [mobileNum stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (self.length != 11)
        
    {
        return NO;
        
    }else{
        
        /**
         
         * 移动号段正则表达式
         
         */
        
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        
        /**
         
         * 联通号段正则表达式
         
         */
        
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        
        /**
         
         * 电信号段正则表达式
         
         */
        
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        
        BOOL isMatch1 = [pred1 evaluateWithObject:self];
        
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        
        BOOL isMatch2 = [pred2 evaluateWithObject:self];
        
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        
        BOOL isMatch3 = [pred3 evaluateWithObject:self];
        
        
        
        if (isMatch1 || isMatch2 || isMatch3) {
            
            return YES;
            
        }else{
            
            return NO;
            
        }
        
    }
}

+ (NSString *)deleteSuffix:(NSString *)mediu{
    
    NSString *string;
    if ([mediu hasSuffix:@".mp3"]||[mediu hasSuffix:@".Mp3"]||[mediu hasSuffix:@".mP3"]||[mediu hasSuffix:@".MP3"]||[mediu hasSuffix:@".mp4"]||[mediu hasSuffix:@".MP4"]||[mediu hasSuffix:@".Mp4"]||[mediu hasSuffix:@".mP4"]) {
        
        NSMutableString *mulStr = [[NSMutableString alloc]initWithString:mediu];
        NSInteger len = mulStr.length;
        if (len>4) {
            [mulStr deleteCharactersInRange:NSMakeRange(len-4, 4)];
            string = mulStr.copy;
        }else{
            string = @"";
        }
    }else{
        string = mediu;
    }
    return string;
}

+ (NSString *)limitString:(NSString *)string count:(NSInteger)count{
    
    if (string.length <= count) {
        return string;
    }else{
        
       NSString *subString = [string substringWithRange:NSMakeRange(0, count)];
       return subString;
    }
}

@end
