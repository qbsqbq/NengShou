//
//  UITextField+MZTextField.m
//  HZMHIOS
//
//  Created by MCEJ on 2018/7/30.
//  Copyright © 2018年 MCEJ. All rights reserved.
//

#import "UITextField+MZTextField.h"
#import<objc/runtime.h>

@implementation UITextField (MZTextField)

static char tfActionTag;

- (void)addAction:(TextFieldBlock)block
{
    objc_setAssociatedObject(self, &tfActionTag, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(action:) forControlEvents:UIControlEventEditingChanged];
}

- (void)addAction:(TextFieldBlock)block forControlEvents:(UIControlEvents)controlEvents
{
    objc_setAssociatedObject(self, &tfActionTag, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(action:) forControlEvents:controlEvents];
}

- (void)action:(id)sender
{
    TextFieldBlock blockAction = (TextFieldBlock)objc_getAssociatedObject(self, &tfActionTag);
    if (blockAction)
    {
        blockAction(self);
    }
}


- (void)resignFirstResponderWhenEndEditing
{
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self keyboardAddViewButton];
}

- (void)resignFirstResponderNoDeleteBtn
{
    [self keyboardAddViewButton];
}

- (void)keyboardAddViewButton
{
    UIView *dismissView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mz_width, keyboardInputViewH)];
    dismissView.backgroundColor = mz_upkeyboardViewColor;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(mz_width-50, 0, 40, keyboardInputViewH)];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    button.titleLabel.font = mz_font(15);
    [button setTitleColor:mz_upkeyboardDoneColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dismissButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [dismissView addSubview:button];
    self.inputAccessoryView = dismissView;
}

- (void)dismissButtonAction
{
    [self resignFirstResponder];
}

@end
