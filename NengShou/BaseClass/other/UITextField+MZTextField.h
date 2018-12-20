//
//  UITextField+MZTextField.h
//  HZMHIOS
//
//  Created by MCEJ on 2018/7/30.
//  Copyright © 2018年 MCEJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TextFieldBlock)(UITextField* textField);

@interface UITextField (MZTextField)

- (void)addAction:(TextFieldBlock)block;
- (void)addAction:(TextFieldBlock)block forControlEvents:(UIControlEvents)controlEvents;

//编辑时添加键盘回收的按钮视图
- (void)resignFirstResponderWhenEndEditing;

//编辑时没有删除按钮
- (void)resignFirstResponderNoDeleteBtn;

@end
