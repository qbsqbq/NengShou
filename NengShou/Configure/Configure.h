//
//  Configure.h
//  HZMHIOS
//
//  Created by MCEJ on 2017/12/28.
//  Copyright © 2017年 MCEJ. All rights reserved.
//

#ifndef Configure_h
#define Configure_h

#import <AVOSCloud/AVOSCloud.h>
#import "UIButton+MHButton.h"
#import "UITextField+MZTextField.h"
#import "HttpRequest.h"
#import "MHProgressHUD.h"


#define HZMH_APPICONIMAGE [UIImage imageNamed:[[[[NSBundle mainBundle] infoDictionary] valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject]]
#define HZMH_APPNAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]


//高德地图apikey
#define AMAPAPIKEY @"b6aec21e99349b0de10d068ffc3d8bc8"

//微信分享apikey
#define WEIXINAPIKEY @"wxad265fb5ffccace8"


/**屏幕宽度*/
#define mz_width [[UIScreen mainScreen] bounds].size.width
/**屏幕高度*/
#define mz_height [[UIScreen mainScreen] bounds].size.height
//颜色
#define mz_color(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define mz_colora(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]


//移动蓝
#define mz_yiDongBlueColor mz_color(20, 150, 239)
//导航栏主色
#define mz_mainColor mz_color(249, 249, 249)
//#define mz_mainColor mz_yiDongBlueColor
#define mz_navTitleColor [UIColor blackColor]

#define mz_textColor mz_color(51, 71, 113)
//tableView背景色
#define mz_tableViewBackColor mz_color(235, 235, 241)
//键盘辅助视图颜色
#define mz_upkeyboardViewColor mz_yiDongBlueColor
#define mz_upkeyboardDoneColor [UIColor whiteColor]



#define MM_Width(R) (R)*(mz_width)/375.f
#define MM_Height(R) (R)*(mz_height)/667.f

#define WWBackGrayColor mz_color(51,51,51)
#define lineColor mz_color(226,226,226)
//灰色
#define WWDarkGrayColor mz_color(153,153,153)
#define MDarkGrayColor mz_color(237,249,240)
#define MWordGrayColor mz_color(142,142,144)
#define WWSelectedGrayColor mz_color(248,248,248)
#define WWPlaceholderColor mz_color(153,153,153)
#define WWWangGrayColor  mz_color(237, 238, 239)
#define WWThemeColor mz_color(31,143,243)
#define WWBlackColor mz_color(20, 150, 239)



//设置字体大小
#define mz_font(size) [UIFont systemFontOfSize:size]
//tableView 列表字体大小
#define mz_listTextFont [UIFont systemFontOfSize:15]




// iPhoneX
#define mz_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// iPhoneX 导航高度
#define iPhoneNavH (mz_iPhoneX ? 88 : 64)



//设置frame
#define mz_frame(x,y,w,h) CGRectMake(x, y, w, h)



//转字符串格式
#define mz_NSNString(string) [NSString stringWithFormat:@"%@",string]
#define mz_NSTstring(type, string) [NSString stringWithFormat:type,string]
#define mzprice(value) [NSString stringWithFormat:@"¥%.2f", [value floatValue]]

//字符串判空 为空返回 @"--"
#define mzstring(value) \
({\
    NSString *str=@"";\
    if ((!value) || [value isEqual:[NSNull null]])\
    {\
        str=@"--";\
    }else {\
        str=[NSString stringWithFormat:@"%@",value];\
    }\
    (str);\
})\

//字符串判空 为空返回 @""
#define mzempstr(value) \
({\
    NSString *str=@"";\
    if ([value isEqual:[NSNull null]])\
    {\
        str=@"";\
    }else {\
        str=[NSString stringWithFormat:@"%@",value];\
    }\
    (str);\
})\

//字符串判断是否相等
#define mzisequal(value1,value2) \
({\
    BOOL isequal=NO;\
    if ([mzempstr(value1) isEqualToString:mzempstr(value2)])\
    {\
        isequal=YES;\
    }else {\
        isequal=NO;\
    }\
    (isequal);\
})\


//设置image
#define mz_image(fileName) [UIImage imageNamed:fileName]

//tableView 头视图
#define mz_tableHeaderView [[UIView alloc] initWithFrame:mz_frame(0, 0, mz_width, 15)]

//带segment的tableView的frame
#define mz_segmentTableFrame mz_frame(0,0,mz_width,mz_height-iPhoneNavH)
#define mz_segmentTableCarFrame mz_frame(0,0,mz_width,mz_height-iPhoneNavH-50)
#define mz_tableTabbarFrame mz_frame(0,iPhoneNavH,mz_width,mz_height-iPhoneNavH-50)
#define mz_tableTopFrame mz_frame(0,-iPhoneNavH,mz_width,mz_height-50+iPhoneNavH)
#define mz_tableTopFrameNoBtn mz_frame(0,-iPhoneNavH,mz_width,mz_height+iPhoneNavH)

//请求tableView数据每一页的条数
#define mz_countNum 10

//键盘上附带的view的高度
#define keyboardInputViewH 40



///weakSelf
#define mzWeakSelf(type)  __weak typeof(type) weak##type = type;
#define mzStrongSelf(type)  __strong typeof(type) type = weak##type;

/**全局字体*/
#define CZHGlobelNormalFont(__VA_ARGS__) ([UIFont systemFontOfSize:CZH_ScaleFont(__VA_ARGS__)])

/**宽度比例*/
#define CZH_ScaleWidth(__VA_ARGS__)  ([UIScreen mainScreen].bounds.size.width/375)*(__VA_ARGS__)

/**高度比例*/
#define CZH_ScaleHeight(__VA_ARGS__)  ([UIScreen mainScreen].bounds.size.height/667)*(__VA_ARGS__)

/**字体比例*/
#define CZH_ScaleFont(__VA_ARGS__)  ([UIScreen mainScreen].bounds.size.width/375)*(__VA_ARGS__)

/**颜色*/
#define MZ16Color(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define MZAColor(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#define CZHThemeColor mz_color(20, 150, 239)




#endif /* Configure_h */

