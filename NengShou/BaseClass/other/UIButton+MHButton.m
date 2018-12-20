//
//  UIButton+MHButton.m
//  HZMHIOS
//
//  Created by MCEJ on 2017/12/29.
//  Copyright © 2017年 MCEJ. All rights reserved.
//

#import "UIButton+MHButton.h"
#import<objc/runtime.h>

@implementation UIButton (MHButton)

-(void)setBlock:(void(^)(UIButton*))block
{
    objc_setAssociatedObject(self,@selector(block), block,OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget: self action:@selector(click:)forControlEvents:UIControlEventTouchUpInside];
}

-(void(^)(UIButton*))block
{
    return objc_getAssociatedObject(self,@selector(block));
}

-(void)addTarget:(void(^)(UIButton*))block
{
    self.block= block;
    [self addTarget: self action:@selector(click:)forControlEvents:UIControlEventTouchUpInside];
}

-(void)click:(UIButton*)btn
{
    if(self.block) {
        self.block(btn);
    }
}


+ (UIButton *)footerButton:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(15,5,mz_width-30,40);
    button.backgroundColor= mz_color(20, 150, 239);
    [button setTitle:title forState:UIControlStateNormal];
    button.layer.cornerRadius = 5;
    return button;
}

+ (UIButton *)footerButtonWithY:(float)y title:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(15,y,mz_width-30,40);
    button.backgroundColor= mz_color(20, 150, 239);
    [button setTitle:title forState:UIControlStateNormal];
    button.layer.cornerRadius = 5;
    return button;
}

@end
