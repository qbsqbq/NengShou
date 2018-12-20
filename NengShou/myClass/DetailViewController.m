//
//  DetailViewController.m
//  NengShou
//
//  Created by MCEJ on 2018/12/18.
//  Copyright © 2018年 MCEJ. All rights reserved.
//

#import "DetailViewController.h"
#import <AFNetworking.h>

#define index 4

#define mobile_IP @"https://api.ioser.net/api/get_phone_info?"
#define idCard_IP @"http://www.jiahengfei.cn:33550/port/idcard?"
#define ipAddress_IP @"https://api.ioser.net/api/get_ip_info?"


#define access_token @"SaAXcvVdeIr4JwoCQykGyN66sqBEbVc7"

@interface DetailViewController () <NSURLConnectionDataDelegate,UITextFieldDelegate>
{
    //用来保存接收到的数据
    NSMutableString *_resltStr;
}
@property (nonatomic,strong)NSString *url;
@property (nonatomic,strong)NSString *textStr;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.title = @"便民查询";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _resltStr = [NSMutableString stringWithString:@""];
    
    mzWeakSelf(self);
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.delegate = self;
    [self.textField addAction:^(UITextField *textField) {
        weakself.textStr = textField.text;
    }];
    
    //查询
    [self.queryBtn addTarget:^(UIButton *button) {
        if (weakself.type == 10) {
            NSString *url = [NSString stringWithFormat:@"%@dispose=select&key=jiahengfei&v=%@",idCard_IP, weakself.textStr];
            [weakself pressedButton:url];
        }else{
            [weakself requestData];
        }
    }];
    
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)aTextfield
{
    [aTextfield resignFirstResponder];//关闭键盘
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)pressedButton:(NSString *)url
{
    //用GET方法发送请求
    NSLog(@"url==%@",url);
    NSURL *pUrl = [NSURL URLWithString:url];
    //NSURLRequest初始化方法第一个参数：请求访问路径，第二个参数：缓存协议，第三个参数：网络请求超时时间（秒）
    NSURLRequest *pRequest = [NSURLRequest requestWithURL:pUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    [NSURLConnection connectionWithRequest:pRequest delegate:self];
}

#pragma NSURLConnectionDataDelegate协议里的一些方法
//服务器开始响应时调用该方法
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //初始化
    _resltStr = [[NSMutableString alloc]init];
    [MHProgressHUD showProgress:@"加载中..." inView:self.view];
}

//服务器接收数据时调用该方法
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //将data通过UTF8的编码方式转换为字符串
    NSString *pstr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //放到存储结果的字符串中
    [_resltStr appendString:pstr];
    NSLog(@"返回数据====%@",_resltStr);
}

//数据接受失败时调用该方法
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [MHProgressHUD hide];
    NSLog(@"数据加载失败，原因：%@",error);
    [MHProgressHUD showMsgWithoutView:@"请输入正确的信息"];
}

//数据接收完毕后调用该方法
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [MHProgressHUD hide];
    //在返回的字符串里截取结果
    NSDictionary *dic = [self dictionaryWithJsonString:_resltStr];
    NSLog(@"dic====%@",dic);
    if (mzisequal(dic[@"code"], @"1")) {
        if (dic[@"data"]) {
            self.resultLabel.text = [NSString stringWithFormat:@"%@",dic[@"data"][@"region"]];
        }
    }
}


- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}



- (void)requestData
{
    NSString *url = @"";
    if (self.type == 9) {
        url = [NSString stringWithFormat:@"%@access_token=%@&phone=%@",mobile_IP, access_token, self.textStr];
    }else if (self.type == 10) {
        url = [NSString stringWithFormat:@"%@dispose=select&key=jiahengfei&v=%@",idCard_IP, self.textStr];
    }else if (self.type == 11) {
        url = [NSString stringWithFormat:@"%@access_token=%@&ip=%@",ipAddress_IP, access_token, self.textStr];
    }
    [MHProgressHUD showProgress:@"加载中..." inView:self.view];
    HttpRequest *httpRequest = [HttpRequest sharedInstance];
    [httpRequest GET:url params:nil success:^(id responseObject) {
        if (mzisequal(responseObject[@"code"], @"200")) {
            if (responseObject[@"data"]) {
                if (self.type == 9) {
                    self.resultLabel.text = [NSString stringWithFormat:@"%@ %@ %@",responseObject[@"data"][@"province"],responseObject[@"data"][@"city"],responseObject[@"data"][@"isp"]];
                }else if (self.type == 11) {
                    self.resultLabel.text = [NSString stringWithFormat:@"%@ %@ %@",responseObject[@"data"][@"continent"],responseObject[@"data"][@"country"],responseObject[@"data"][@"province"]];
                }
            }else{
                [MHProgressHUD showMsgWithoutView:@"暂无数据"];
            }
        }else if (mzisequal(responseObject[@"code"], @"1")) {
            if (responseObject[@"data"]) {
                self.resultLabel.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"region"]];
            }else{
                [MHProgressHUD showMsgWithoutView:@"暂无数据"];
            }
        }else{
            [MHProgressHUD showMsgWithoutView:responseObject[@"msg"]];
        }
    } failure:nil];
}







- (void)post
{
    //2、用POST方法获得
    
    //获取网络路径字符串（与Get请求的第一个区别点(不带参数,参数附件在body体里)）
    
    /*NSString *postStr =@"http://ws.webxml.com.cn/WebServices/MobileCodeWS.asmx/getMobileCodeInfo";
     
     //将字符串转化为URL
     
     NSURL *postUrl = [NSURL URLWithString:postStr];
     
     //创建请求（第二个区别：请求为NSMutableURLRequest）
     
     NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:postUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
     
     //将请求的参数做成一个字符串
     
     NSString *postMobileAndUserID = [NSString stringWithFormat:@"mobileCode=%@&userID=",self.textStr];
     
     //将该字符串转化成NSData
     
     NSData *postData = [postMobileAndUserID dataUsingEncoding:NSUTF8StringEncoding];
     
     //设置请求的参数和方法
     
     //第三个区别点(将参数作为Body体)
     
     [postRequest setHTTPBody:postData];
     
     //第四点(必须手动声明当前的请求方式为POST)
     
     [postRequest setHTTPMethod:@"POST"];
     
     //发送请求
     
     [NSURLConnection connectionWithRequest:postRequest delegate:self];
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
