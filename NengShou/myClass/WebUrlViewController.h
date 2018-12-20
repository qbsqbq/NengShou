//
//  WebUrlViewController.h
//  NengShou
//
//  Created by MCEJ on 2018/12/20.
//  Copyright © 2018年 MCEJ. All rights reserved.
//

#import "BaseViewController.h"

@interface WebUrlViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic,copy)NSString *url;

@end
