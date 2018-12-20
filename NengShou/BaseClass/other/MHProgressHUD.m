//
//  MHProgressHUD.m
//  HZMHIOS
//
//  Created by MCEJ on 2017/12/29.
//  Copyright © 2017年 MCEJ. All rights reserved.
//

#import "MHProgressHUD.h"

@implementation MHProgressHUD

+(instancetype)shareinstance{
    
    static MHProgressHUD *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MHProgressHUD alloc] init];
    });
    return instance;
}

+(void)show:(NSString *)msg inView:(UIView *)view mode:(YJProgressMode *)myMode{
    [self show:msg inView:view mode:myMode customImgView:nil];
}

+(void)show:(NSString *)msg inView:(UIView *)view mode:(YJProgressMode *)myMode customImgView:(UIImageView *)customImgView{
    //如果已有弹框，先消失
    if ([MHProgressHUD shareinstance].hud != nil) {
        [[MHProgressHUD shareinstance].hud hideAnimated:YES];
        [MHProgressHUD shareinstance].hud = nil;
    }
    
    //4\4s屏幕避免键盘存在时遮挡
    if ([UIScreen mainScreen].bounds.size.height == 480) {
        [view endEditing:YES];
    }
    
    [MHProgressHUD shareinstance].hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    //这里设置是否显示遮罩层
    //[MHProgressHUD shareinstance].hud.dimBackground = YES;    //是否显示透明背景
    
    //是否设置黑色背景，这两句配合使用
    [MHProgressHUD shareinstance].hud.bezelView.color = [UIColor blackColor];
    [MHProgressHUD shareinstance].hud.contentColor = [UIColor whiteColor];
    
    [[MHProgressHUD shareinstance].hud setMargin:10];
    [[MHProgressHUD shareinstance].hud setRemoveFromSuperViewOnHide:YES];
    [MHProgressHUD shareinstance].hud.detailsLabel.text = msg;
    
    [MHProgressHUD shareinstance].hud.detailsLabel.font = [UIFont systemFontOfSize:14];
    switch ((NSInteger)myMode) {
        case YJProgressModeOnlyText:
            [MHProgressHUD shareinstance].hud.mode = MBProgressHUDModeText;
            break;
            
        case YJProgressModeLoading:
            [MHProgressHUD shareinstance].hud.mode = MBProgressHUDModeIndeterminate;
            break;
            
        case YJProgressModeCircle:{
            [MHProgressHUD shareinstance].hud.mode = MBProgressHUDModeCustomView;
            UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading"]];
            CABasicAnimation *animation= [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
            animation.toValue = [NSNumber numberWithFloat:M_PI*2];
            animation.duration = 1.0;
            animation.repeatCount = 100;
            [img.layer addAnimation:animation forKey:nil];
            [MHProgressHUD shareinstance].hud.customView = img;
            
            
            break;
        }
        case YJProgressModeCustomerImage:
            [MHProgressHUD shareinstance].hud.mode = MBProgressHUDModeCustomView;
            [MHProgressHUD shareinstance].hud.customView = customImgView;
            break;
            
        case YJProgressModeCustomAnimation:
            //这里设置动画的背景色
            [MHProgressHUD shareinstance].hud.bezelView.color = [UIColor yellowColor];
            
            
            [MHProgressHUD shareinstance].hud.mode = MBProgressHUDModeCustomView;
            [MHProgressHUD shareinstance].hud.customView = customImgView;
            
            break;
            
        case YJProgressModeSuccess:
            [MHProgressHUD shareinstance].hud.mode = MBProgressHUDModeCustomView;
            [MHProgressHUD shareinstance].hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"success"]];
            break;
            
        default:
            break;
    }
    
    
    
}


+(void)hide{
    if ([MHProgressHUD shareinstance].hud != nil) {
        [[MHProgressHUD shareinstance].hud hideAnimated:YES];
    }
}


+(void)showMessage:(NSString *)msg inView:(UIView *)view{
    [self show:msg inView:view mode:YJProgressModeOnlyText];
    [[MHProgressHUD shareinstance].hud hideAnimated:YES afterDelay:1.0];
}



+(void)showMessage:(NSString *)msg inView:(UIView *)view afterDelayTime:(NSInteger)delay{
    [self show:msg inView:view mode:YJProgressModeOnlyText];
    [[MHProgressHUD shareinstance].hud hideAnimated:YES afterDelay:delay];
}

+(void)showSuccess:(NSString *)msg inview:(UIView *)view{
    [self show:msg inView:view mode:YJProgressModeSuccess];
    [[MHProgressHUD shareinstance].hud hideAnimated:YES afterDelay:1.0];
    
}

+(void)showMsgWithImage:(NSString *)msg imageName:(NSString *)imageName inview:(UIView *)view{
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [self show:msg inView:view mode:YJProgressModeCustomerImage customImgView:img];
    [[MHProgressHUD shareinstance].hud hideAnimated:YES afterDelay:1.0];
}


+(void)showProgress:(NSString *)msg inView:(UIView *)view{
    [self show:msg inView:view mode:YJProgressModeLoading];
}

+(MBProgressHUD *)showProgressCircle:(NSString *)msg inView:(UIView *)view{
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.detailsLabel.text = msg;
        return hud;
    
    
}

+(void)showProgressCircleNoValue:(NSString *)msg inView:(UIView *)view{
    [self show:msg inView:view mode:YJProgressModeCircle];
    
}


+(void)showMsgWithoutView:(NSString *)msg{
    UIWindow *view = [UIApplication sharedApplication].keyWindow;
//    UIWindow *view = [[UIApplication sharedApplication].windows lastObject];
    [self show:msg inView:view mode:YJProgressModeOnlyText];
    [[MHProgressHUD shareinstance].hud hideAnimated:YES afterDelay:1.5];
    
}

+(void)showCustomAnimation:(NSString *)msg withImgArry:(NSArray *)imgArry inview:(UIView *)view{
    
    UIImageView *showImageView = [[UIImageView alloc] init];
    showImageView.animationImages = imgArry;
    [showImageView setAnimationRepeatCount:0];
    [showImageView setAnimationDuration:(imgArry.count + 1) * 0.075];
    [showImageView startAnimating];
    
    [self show:msg inView:view mode:YJProgressModeCustomAnimation customImgView:showImageView];
    
    
}

@end

