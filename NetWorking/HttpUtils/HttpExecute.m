//
//  HttpExecute.m
//  NetWorking
//
//  Created by yiban on 16/5/12.
//  Copyright © 2016年 yiban. All rights reserved.
//
#import "HttpExecute.h"

@implementation HttpExecute

static NSString *BaseUrl = nil;

+ (void)updateBaseUrl:(NSString *)baseUrl {
    BaseUrl = baseUrl;
}


+ (NSString *)fetchBaseeUrl {
    return BaseUrl;
}

- (void)uploadMutipleWithUrl:(NSString *)url fileDatas:(NSMutableArray *)fileDatas filePaths:(NSMutableArray *)filePaths name:(NSString *)name mimeType:(NSString *)type suffix:(NSString *)suffix parametersDic:(NSDictionary *)parametersDic sessionManager:(UrlSessionManager *)sessionManager uploadProgress:(loadProgress)progress success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    if (!url) {
        
        DLogInfo(@"url为空");
        return;
    }
    
    if (filePaths != nil && fileDatas == nil) {
        
        fileDatas = [NSMutableArray array];
        for (int i = 0; i < filePaths.count; i ++) {
            NSData *data = [NSData dataWithContentsOfFile:filePaths[i]];
            [fileDatas addObject:data];
        }
    }
    
    UrlSessionManager *manager = [UrlSessionManager sharedManager];
    if (sessionManager != nil && [sessionManager isKindOfClass:[UrlSessionManager class]]) {
        manager = sessionManager;
    }
    
    if (fileDatas && fileDatas.count > 0) {
        
        NSString *urlWithoutQuery = [self prepareUrlWithoutQueryRequestWithUrlStr:url];
        
        [manager POST:urlWithoutQuery parameters:parametersDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            NSString *mimeType = type;
            if (mimeType == nil || [mimeType stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0) {
                mimeType = @"image/png";
            }
            
            NSString *suf = suffix;
            if (suf == nil) {
                suf = @"";
            }
            
            for (int i = 0; i < fileDatas.count; i ++) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                NSString *fileName = [NSString stringWithFormat:@"%@%d", str, i];
                //根据mimetype截取文件后缀
                NSString *fileWithSuffix = fileName;
                if (suffix.length > 0) {
                    fileWithSuffix = [fileName stringByAppendingPathExtension:suf];
                }
                
                // 上传图片，以文件流的格式
                [formData appendPartWithFileData:fileDatas[i] name:name fileName:fileWithSuffix mimeType:mimeType];
            }
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
            if (progress) {
                progress (uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
            }
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [self stopActivityIndicator];
            
            if (success) {
                success(responseObject);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [self stopActivityIndicator];
            
            if (failure) {
                failure(error);
                DLogInfo(@"上传多个文件错误： %@", error);
            }
        }];
    }
}


- (void)requestWithUrl:(NSString *)url withDic:(NSDictionary *)parameters requestType:(RequestType)requestType sessionManager:(UrlSessionManager *)sessionManager success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    if (!url) {
        
        DLogInfo(@"url为空");
        return;
    }
    
    UrlSessionManager *manager = [UrlSessionManager sharedManager];
    if (sessionManager != nil && [sessionManager isKindOfClass:[UrlSessionManager class]]) {
        manager = sessionManager;
    }
    
    NSString *urlWithoutQuery = [self prepareUrlWithoutQueryRequestWithUrlStr:url];
    
    if (requestType == RequestTypeGet) {
        
        [manager GET:urlWithoutQuery parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [self stopActivityIndicator];
            
            if (success) {
                
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    success(responseObject);
                }
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [self stopActivityIndicator];
            
            if (failure) {
                DLogInfo(@"get请求错误: %@", error.userInfo);
                failure(error);
            }
        }];
        
    } else if (requestType == RequestTypePost) {
        
        [manager POST:urlWithoutQuery parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [self stopActivityIndicator];
            
            if (success) {
                
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    success(responseObject);
                }
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [self stopActivityIndicator];
            
            if (failure) {
                DLogInfo(@"post请求错误: %@", error.userInfo);
                failure(error);
            }
        }];
        
    } else if (requestType == RequestTypePut) {
        
        [manager PUT:urlWithoutQuery parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [self stopActivityIndicator];
            
            if (success) {
                
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    success(responseObject);
                }
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [self stopActivityIndicator];
            
            if (failure) {
                DLogInfo(@"put请求错误: %@", error.userInfo);
                failure(error);
            }
        }];
        
    } else if (requestType == RequestTypeDelete) {
        
        [manager DELETE:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [self stopActivityIndicator];
            
            if (success) {
                
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    success(responseObject);
                }
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [self stopActivityIndicator];
            
            if (failure) {
                DLogInfo(@"delete请求错误: %@", error.userInfo);
                failure(error);
            }
            
        }];
    }
}


- (void)downLoadUrl:(NSString *)url parametersDic:(NSDictionary *)parameters sessionManager:(UrlSessionManager *)sessionManager downLoadProgress:(loadProgress)progress success:(void (^)(NSURL *filePath, NSURLResponse *response))success failure:(FailureBlock)failure {
    
    if (!url) {
        
        DLogInfo(@"url为空");
        return;
    }
    
    NSString *urlWithoutQuery = [self prepareUrlWithoutQueryRequestWithUrlStr:url];
    
    NSString *fullUrl = [self generateUrlWithUrlStr:urlWithoutQuery withDic:parameters];
    
    NSURL *requestUrl = [NSURL URLWithString:fullUrl];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];
    
    UrlSessionManager *manager = [UrlSessionManager sharedManager];
    
    if (sessionManager != nil && [sessionManager isKindOfClass:[UrlSessionManager class]]) {
        manager = sessionManager;
    }
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (progress) {
            progress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
        }
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        [self stopActivityIndicator];
        
        if (error) {
            if (failure) {
                DLogInfo(@"下载错误: %@", error.userInfo);
                failure(error);
            }
        } else {
            if (success) {
                success(filePath, response);
            }
        }
        
    }];
    
    [downloadTask resume];
}


- (NSString *)prepareUrlWithoutQueryRequestWithUrlStr:(NSString *)urlStr {
    //状态栏转起来
    [self networkType:^(NSInteger type) {
        if (type > 0) {
            NSLog(@"start animating");
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        }
    }];
    //过滤空格
    urlStr = [urlStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    //如果不是完整链接就拼接上baseurl
    NSString *urlWithoutQuery = [self urlWithoutQuery:urlStr];
    //有中文转编码
    return [self transformChinese:urlWithoutQuery];
}


- (NSString *)urlWithoutQuery:(NSString *)url {
    //完整链接
    if ([url containsString:@"://"]) {
        return url;
    }
    //部分url 拼接上baseurl
    else {
        return [BaseUrl stringByAppendingString:url];
    }
}


- (void)stopActivityIndicator {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"stop animating");
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    });
}


//网络连接
- (void)networkType:(void (^)(AFNetworkReachabilityStatus type))networkType {
    //创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //监测到网络改变
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                DLogInfo(@"未知网络状态");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                DLogInfo(@"无网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                DLogInfo(@"蜂窝数据网");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                DLogInfo(@"WiFi网络");
                break;
                
            default:
                break;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (networkType) {
                networkType(status);
            }
        });
    }];
    
    //激活网络状态监测
    [manager startMonitoring];
}


//拼接参数为url
- (NSString *)generateUrlWithUrlStr:(NSString *)urlStr withDic:(NSDictionary *)parametersDic {
    
    if (!parametersDic || parametersDic.count <= 0) {
        return urlStr;
    }
    NSMutableArray *parameters = [NSMutableArray array];
    //拼接参数
    [parametersDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        //key
        NSString *finalKey = [key stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        //value
        NSString *finalValue = [obj stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        NSString *parameter =[NSString stringWithFormat:@"%@=%@", finalKey, finalValue];
        
        [parameters addObject:parameter];
    }];
    
    NSString *queryString = [parameters componentsJoinedByString:@"&"];
    queryString = queryString ? [NSString stringWithFormat:@"?%@", queryString] : @"";
    NSString *baseUrl = [NSString stringWithFormat:@"%@%@", urlStr, queryString];
    
    return [self transformChinese:baseUrl];
}


//处理url包含中文的问题
- (NSString *)transformChinese:(NSString *)urlString {
    
    if (!urlString) {
        
        DLogInfo(@"url为空");
        return nil;
    }
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[\\u4e00-\\u9fa5]" options:NSRegularExpressionCaseInsensitive error:nil];
    if ([regex numberOfMatchesInString:urlString options:0 range:NSMakeRange(0, [urlString length])] > 0) {
        urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
    
    return urlString;
}
@end
