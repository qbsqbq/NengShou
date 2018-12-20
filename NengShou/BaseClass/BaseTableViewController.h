//
//  BaseTableViewController.h
//  HZMHIOS
//
//  Created by MCEJ on 2018/7/19.
//  Copyright © 2018年 MCEJ. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseTableViewController : BaseViewController

@property(nonatomic,retain) UITableView *tableView;

//是否显示空数据页面  默认为显示
@property(nonatomic,assign) BOOL isShowEmptyData;
//空数据页面的title -- 可不传，默认为：暂无任何数据
@property(nonatomic,strong) NSString *noDataTitle;
//空数据页面的图片 -- 可不传，默认图片为：NoData
@property(nonatomic,strong) NSString *noDataImgName;
//显示副标题的时候，需要赋值副标题，否则不显示
@property(nonatomic,strong) NSString *noDataDetailTitle;
//按钮标题、图片 --不常用
@property(nonatomic,strong) NSString *btnTitle;
@property(nonatomic,strong) NSString *btnImgName;
-(void)buttonEvent;


@end
