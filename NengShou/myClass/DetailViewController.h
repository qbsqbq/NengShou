//
//  DetailViewController.h
//  NengShou
//
//  Created by MCEJ on 2018/12/18.
//  Copyright © 2018年 MCEJ. All rights reserved.
//

#import "BaseViewController.h"

@interface DetailViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *queryBtn;

@property (nonatomic,assign)int type;

@end
