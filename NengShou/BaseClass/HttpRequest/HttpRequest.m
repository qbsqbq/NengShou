//
//  HttpRequest.m
//  HZMHIOS
//
//  Created by MCEJ on 2017/12/29.
//  Copyright © 2017年 MCEJ. All rights reserved.
//

#import "HttpRequest.h"
#import <AFNetworking.h>

@implementation HttpRequest
/**
 *  创建网络请求类的单例
 */
static HttpRequest *httpRequest = nil;
+ (HttpRequest *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (httpRequest == nil) {
            httpRequest = [[self alloc] init];
        }
    });
    return httpRequest;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (httpRequest == nil) {
            httpRequest = [super allocWithZone:zone];
        }
    });
    return httpRequest;
}
- (instancetype)copyWithZone:(NSZone *)zone
{
    return httpRequest;
}
/**
 *  封装AFN的GET请求
 *
 *  @param url       网络请求地址
 *  @param params    参数(可以是字典或者nil)
 *  @param success   成功后执行success block
 *  @param failure   失败后执行failure block
 */
- (void)GET:(NSString *)url params:(id)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    url = [NSString stringWithFormat:@"%@%@",HZMH_IP, url];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [self manager];
    //发送网络请求(请求方式为GET)
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MHProgressHUD hide];
        NSLog(@"url == %@",url);
        NSLog(@"params == %@",params);
        NSLog(@"responseObject == \n%@",responseObject);
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MHProgressHUD hide];
        NSLog(@"url == %@",url);
        NSLog(@"params == %@",params);
        NSLog(@"error == \n%@",error);
//        failure(error);
        [MHProgressHUD showMsgWithoutView:@"请求失败!"];
        if (failure) {
            failure(error);
        }
    }];
    
}
/**
 *  封装AFN的POST请求
 *
 *  @param url       网络请求地址
 *  @param params    参数(可以是字典或者nil)
 *  @param success   成功后执行success block
 *  @param failure   失败后执行failure block
 */
- (void)POST:(NSString *)url params:(id)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    url = [NSString stringWithFormat:@"%@%@",HZMH_IP, url];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [self manager];
    //发送网络请求(请求方式为POST)
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MHProgressHUD hide];
        NSLog(@"url == %@",url);
        NSLog(@"params == %@",params);
        NSLog(@"responseObject == \n%@",responseObject);
        if (success) {
            NSError * error =nil;
            if (error !=nil) {
                [MHProgressHUD showMsgWithoutView:@"数据解析失败,请稍后尝试!"];
                return ;
            }
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MHProgressHUD hide];
        NSLog(@"url == %@",url);
        NSLog(@"params == %@",params);
        NSLog(@"error == \n%@",error);
        [MHProgressHUD showMsgWithoutView:@"请求失败!"];
        if (failure) {
            failure(error);
        }
    }];
}

/**
 *  封装AFN的POST请求,上传图片
 *
 *  @param url       网络请求地址
 *  @param fileArr   参数(数组)
 *  @param success   成功后执行success block
 *  @param failure   失败后执行failure block
 */
- (void)fileUploadUrl:(NSString *)url fileType:(NSString *)type fileArr:(NSArray *)fileArr success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    url = [NSString stringWithFormat:@"%@%@",HZMH_IP, url];
    AFHTTPSessionManager *manager = [self manager];
    //发送网络请求(请求方式为POST)
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i < fileArr.count; i ++) {
            NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
            formatter.dateFormat=@"yyyyMMddHHmmss";
            NSString *str=[formatter stringFromDate:[NSDate date]];
            NSString *fileName=[NSString stringWithFormat:@"%@.jpg",str];
            UIImage *image = fileArr[i];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.28);
            [formData appendPartWithFileData:imageData name:type fileName:fileName mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //打印上传进度
        CGFloat progress = 100.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
        NSLog(@"%.2lf%%", progress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MHProgressHUD hide];
        NSLog(@"url == %@",url);
        NSLog(@"fileArr == %@",fileArr);
        NSLog(@"responseObject == \n%@",responseObject);
        if (success) {
            NSError * error =nil;
            if (error !=nil) {
                [MHProgressHUD showMsgWithoutView:@"数据解析失败,请稍后尝试!"];
                return ;
            }
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MHProgressHUD hide];
        NSLog(@"url == %@",url);
        NSLog(@"fileArr == %@",fileArr);
        NSLog(@"error == \n%@",error);
        [MHProgressHUD showMsgWithoutView:@"请求失败!"];
        if (failure) {
            failure(error);
        }
    }];
}

- (AFHTTPSessionManager *)manager
{
    //创建网络请求管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/javascript", @"text/html", @"text/plain", nil];
    //设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    manager.securityPolicy=[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    
    return manager;
}

@end
