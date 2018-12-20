//
//  HttpRequest.h
//  HZMHIOS
//
//  Created by MCEJ on 2017/12/29.
//  Copyright © 2017年 MCEJ. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AFNetworking;

@interface HttpRequest : NSObject

+ (HttpRequest *)sharedInstance;

//GET 请求
- (void)GET:(NSString *)url params:(id)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

//POST 请求
- (void)POST:(NSString *)url params:(id)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

//上传图片
- (void)fileUploadUrl:(NSString *)url fileType:(NSString *)type fileArr:(NSArray *)fileArr success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
