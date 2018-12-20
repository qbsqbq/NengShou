//
//  UIButton+MHButton.h
//  HZMHIOS
//
//  Created by MCEJ on 2017/12/29.
//  Copyright © 2017年 MCEJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (MHButton)

@property(nonatomic ,copy)void(^block)(UIButton*);

-(void)addTarget:(void(^)(UIButton *button))block;

+ (UIButton *)footerButton:(NSString *)title;

+ (UIButton *)footerButtonWithY:(float)y title:(NSString *)title;

@end
