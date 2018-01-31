//
//  UIView+WJSetOriginExtension.m
//  WJBS
//
//  Created by vijay on 2017/4/2.
//  Copyright © 2017年 vijay. All rights reserved.
//

#import "UIView+WJSetOriginExtension.h"

@implementation UIView (WJSetOriginExtension)
+ (instancetype)viewFromXib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
- (void)setWj_x:(CGFloat)wj_x{
    CGRect frame = self.frame;
    frame.origin.x = wj_x;
    self.frame = frame;
}
- (CGFloat)wj_x{
    
    return self.frame.origin.x;

}

- (void)setWj_y:(CGFloat)wj_y{
    
    CGRect frame = self.frame;
    frame.origin.y = wj_y;
    self.frame = frame;
    
}

-(CGFloat)wj_y{
    
    return self.frame.origin.y;
}

-(void)setWj_width:(CGFloat)wj_width{
    
    CGRect frame = self.frame;
    frame.size.width = wj_width;
    self.frame = frame;
}
- (CGFloat)wj_width{
    
    return self.frame.size.width;
}

- (void)setWj_height:(CGFloat)wj_height{
    
    CGRect frame = self.frame;
    frame.size.height = wj_height;
    self.frame = frame;

}

- (CGFloat)wj_height{
    
    return self.frame.size.height;
}

- (void)setWj_centerX:(CGFloat)wj_centerX{
    
    CGPoint center = self.center;
    center.x = wj_centerX;
    self.center = center;

}

- (CGFloat)wj_centerX{
    
    return self.center.x;
}

- (void)setWj_centerY:(CGFloat)wj_centerY{
    
    CGPoint center = self.center;
    center.y = wj_centerY;
    self.center = center;
}

- (CGFloat)wj_centerY{
    
    return self.center.y;
}

- (void)setWj_rightX:(CGFloat)wj_rightX{
    
    self.wj_x = self.wj_rightX - self.wj_width;
}

- (void)setWj_bottnomY:(CGFloat)wj_bottnomY{
    
    self.wj_y = self.wj_bottnomY - self.wj_height;
}

- (CGFloat)wj_rightX{
    
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)wj_bottnomY{
    
    return  CGRectGetMaxY(self.frame);
}


@end
