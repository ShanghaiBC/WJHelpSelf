//
//  WJShowView.m
//  WJUIButtonMove
//
//  Created by Yuan Wang on 2017/4/25.
//  Copyright © 2017年 Yuan Wang. All rights reserved.
//

#import "WJShowView.h"
#import "UIView+WJSetOriginExtension.h"

@interface WJShowView()
{
    CGPoint _ButtonPoint;
    CGPoint startPoint;
    
    NSInteger beginPos;
    NSInteger endPos;
    
}
@property(strong,nonatomic)NSArray      <NSString *>*list_arr;  //titles数组
@property(assign,nonatomic)int                       margin;    //间隙
@property(assign,nonatomic)int                       column;    //列数

@end
@implementation WJShowView

- (void)showMargin:(int)margin column:(int)column titleArray:(NSArray<NSString *>*)listArr{
    
    _margin = margin;
    _column = column;
    _list_arr = listArr;
    _button_Arr = [NSMutableArray array];
    for (int i = 0; i < listArr.count; i++) {
        UIButton * cell_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.cell_btn = cell_btn;
        cell_btn.tag = i;
        cell_btn.titleLabel.font = [UIFont systemFontOfSize:17];
        cell_btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        cell_btn.layer.cornerRadius = 10;
        cell_btn.layer.borderWidth = 0.5;
        cell_btn.layer.masksToBounds = YES;
        cell_btn.layer.borderColor = [UIColor redColor].CGColor;
        cell_btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [cell_btn setTitle:listArr[i] forState:UIControlStateNormal];
        [cell_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cell_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [cell_btn setBackgroundColor:[UIColor blueColor]];
        cell_btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        //行号
        NSUInteger row = i/column;
        //列号
        NSUInteger col = i%column;
        CGFloat btnW = (self.wj_width - margin * (column+1))/column;
        CGFloat btnH = BTN_HEIGHT;
        CGFloat btnX = margin + col*(margin + btnW);
        CGFloat btnY = margin  + row*(margin + btnH);
        cell_btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [_button_Arr addObject:cell_btn];
       
    }
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    [self settingButtonFrame];
}

//设置frame
- (void)settingButtonFrame{
    NSLog(@"-------->%ld",self.button_Arr.count);
    for (int i = 0; i < _button_Arr.count; i++) {
        //行号
        NSUInteger row = i/_column;
        //列号
        NSUInteger col = i%_column;
        CGFloat btnW = (self.wj_width - _margin * (_column+1))/_column;
        CGFloat btnH = BTN_HEIGHT;
        CGFloat btnX = _margin + col*(_margin + btnW);
        CGFloat btnY = _margin  + row*(_margin + btnH);
        UIButton *btn = _button_Arr[i];
        btn.tag = i;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [btn addTarget:self action:@selector(spitlotBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognizerAction:)];
        [btn addGestureRecognizer:longGesture];
        [self addSubview:_button_Arr[i]];
    }
}


- (void)longPressGestureRecognizerAction:(UILongPressGestureRecognizer *)sender
{
    UIButton *btn = (UIButton *)sender.view;
    
    //判断手势的状态
    //手势开始
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        //手势相对于其父View上的坐标
        startPoint = [sender locationInView:sender.view];
        beginPos = btn.tag;
        _ButtonPoint = btn.center;
        [UIView animateWithDuration:0.1 animations:^{
            btn.transform = CGAffineTransformMakeScale(1.1, 1.1);
            btn.alpha = 0.7;
            
        }];
        //手势变化
    } else if (sender.state == UIGestureRecognizerStateChanged){
        
        //手势相对于其父View上的坐标
        CGPoint newPoint = [sender locationInView:sender.view];
        //校正手势在其父控件上的坐标点
        CGFloat deltaX = newPoint.x - startPoint.x;
        CGFloat deltaY = newPoint.y - startPoint.y;
        
        //校正center
        btn.center = CGPointMake(btn.center.x + deltaX, btn.center.y + deltaY);
        NSInteger fromIndex = btn.tag;
        
        NSInteger toIndex = [self judgeMoveByButtonPoint:btn.center moveButton:btn];
        
        if (toIndex < 0) {
            return;
        } else {
            btn.tag = toIndex;
            // 向后移动
            if (fromIndex - toIndex < 0) {
                for (NSInteger i = fromIndex; i < toIndex; i ++) {
                    UIButton *nextBtn = _button_Arr[i+1];
                    // 改变按钮中心点的位置
                    CGPoint temp = nextBtn.center;
                    [UIView animateWithDuration:0.5 animations:^{
                        nextBtn.center = _ButtonPoint;
                    }];
                    _ButtonPoint = temp;
                    // 交换tag值
                    nextBtn.tag = i;
                    
                }
                [self sortArray];
            } else if (fromIndex - toIndex > 0) {
                // 向前移动
                for (NSInteger i = fromIndex; i > toIndex; i --) {
                    UIButton *beforBtn = _button_Arr[i - 1];
                    CGPoint temp = beforBtn.center;
                    [UIView animateWithDuration:0.5 animations:^{
                        beforBtn.center = _ButtonPoint;
                    }];
                    _ButtonPoint = temp;
                    beforBtn.tag = i;
                }
                [self sortArray];
            }
            
            
        }
        
    }
    
    
    else {
        [UIView animateWithDuration:0.2 animations:^{
            btn.transform = CGAffineTransformIdentity;
            btn.alpha = 1.0f;
            btn.center = _ButtonPoint;
        }];
    }
}

- (void)sortArray
{
    // 对已改变按钮的数组进行排序
    [_button_Arr sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        UIButton *temp1 = (UIButton *)obj1;
        UIButton *temp2 = (UIButton *)obj2;
        return temp1.tag > temp2.tag;    //将tag值大的按钮向后移
    }];
    
}

- (NSInteger)judgeMoveByButtonPoint:(CGPoint)point moveButton:(UIButton *)btn
{
    /**
     * 判断移动按钮的中心点是否包含了所在按钮的中心点如果是将i返回
     */
    for (NSInteger i = 0; i < _button_Arr.count; i++) {
        UIButton *button = _button_Arr[i];
        if (!btn || button != btn) {
            if (CGRectContainsPoint(button.frame, point)) {
                return i;
            }
        }
    }
    return -1;
}




- (void)spitlotBtnClick:(UIButton *)sender{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    btn.layer.cornerRadius = 10;
    btn.layer.borderWidth = 0.5;
    btn.layer.masksToBounds = YES;
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitle:@"666" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn setBackgroundColor:[UIColor blueColor]];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_button_Arr addObject:btn];
    NSLog(@"%@",self.button_Arr.description);
    [self setNeedsLayout];
}

@end
