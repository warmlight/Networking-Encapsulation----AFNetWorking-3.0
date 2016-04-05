//
//  Http.m
//  NetWorking
//
//  Created by yiban on 16/3/28.
//  Copyright © 2016年 yiban. All rights reserved.
//

#import "Http.h"
#import "AFNetworking.h"

#ifdef DEBUG
#define YBLog(s, ... ) NSLog( @"[%@ in line %d] ===============>%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define YBLog(s, ... )
#endif

typedef NS_ENUM(NSInteger, RequestType) {
    RequestTypeGet,
    RequestTypePost,
    RequestTypePut,
    RequestTypeDelete,
};

static NSString *BaseUrl = nil;

@implementation Http

+ (void)updateBaseUrl:(NSString *)baseUrl {
    BaseUrl = baseUrl;
}


+ (NSString *)baseUrl {
    return BaseUrl;
}


+ (void)getUrl:(NSString *)url parametersDic:(NSDictionary *)parameters success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    [[self alloc] requestWithUrl:url withDic:parameters requestType:RequestTypeGet
     
                         success:^(NSDictionary *requestDic) {
                             success(requestDic);
                             
                         } failure:^(NSError *errorInfo) {
                             failure(errorInfo);
                         }];
}


+ (void)postUrl:(NSString *)url parametersDic:(NSDictionary *)parameters success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    [[self alloc] requestWithUrl:url withDic:parameters requestType:RequestTypePost
     
                         success:^(NSDictionary *requestDic) {
                             success(requestDic);
                             
                         } failure:^(NSError *errorInfo) {
                             failure(errorInfo);
                         }];
}


+ (void)putUrl:(NSString *)url parametersDic:(NSDictionary *)parameters success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    [[self alloc] requestWithUrl:url withDic:parameters requestType:RequestTypePut
     
                         success:^(NSDictionary *requestDic) {
                             success(requestDic);
                             
                         } failure:^(NSError *errorInfo) {
                             failure(errorInfo);
                         }];
}


+ (void)deleteUrl:(NSString *)url parametersDic:(NSDictionary *)parameters success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    [[self alloc] requestWithUrl:url withDic:parameters requestType:RequestTypeDelete
     
                         success:^(NSDictionary *requestDic) {
                             success(requestDic);
                             
                         } failure:^(NSError *errorInfo) {
                             failure(errorInfo);
                         }];
}


+ (void)downLoadUrl:(NSString *)url parametersDic:(NSDictionary *)parameters downLoadProgress:(loadProgress)progress success:(void (^)(NSURL *filePath, NSURLResponse *response))success failure:(FailureBlock)failure {
    
    NSString *urlWithoutQuery = [[self alloc] prepareUrlWithoutQueryRequestWithUrlStr:url];
    
    NSString *fullUrl = [[self alloc] generateUrlWithUrlStr:urlWithoutQuery withDic:parameters];
    
    NSURL *requestUrl = [NSURL URLWithString:fullUrl];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (progress) {
            progress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
        }
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {

        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        [[self alloc] stopActivityIndicator];
        
        if (error) {
            if (failure) {
                YBLog(@"下载错误: %@", error.userInfo);
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


+ (void)postImagesData:(NSMutableArray *)imagesData uploadUrl:(NSString *)url name:(NSString *)name parametersDic:(NSDictionary *)parameters uploadProgress:(loadProgress)progress success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    [[self alloc] uploadMutipleWithUrl:url fileDatas:imagesData filePaths:nil name:name mimeType:@"image/jpeg" suffix:@"jpg" parametersDic:parameters uploadProgress:^(int64_t bytesRead, int64_t totalBytesRead) {
        
        if (progress) {
            progress(bytesRead, totalBytesRead);
        }
        
    } success:^(NSDictionary *requestObj) {
        
        if (success) {
            success(requestObj);
        }
        
    } failure:^(NSError *errorInfo) {
        
        if (failure) {
            failure(errorInfo);
        }
        
    }];
}


+ (void)postFilesData:(NSMutableArray *)imagesData uploadUrl:(NSString *)url name:(NSString *)name suffix:(NSString *)suffix parametersDic:(NSDictionary *)parametersDic uploadProgress:(loadProgress)progress success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    if(suffix == nil) {
        suffix = @"";
    }
    
    [[self alloc] uploadMutipleWithUrl:url fileDatas:imagesData filePaths:nil name:name mimeType:@"application/octet-stream" suffix:suffix parametersDic:parametersDic uploadProgress:^(int64_t bytesRead, int64_t totalBytesRead) {
        
        if (progress) {
            progress(bytesRead, totalBytesRead);
        }
        
    } success:^(NSDictionary *requestObj) {
        
        if (success) {
            success(requestObj);
        }
        
    } failure:^(NSError *errorInfo) {
        
        if (failure) {
            failure(errorInfo);
        }
        
    }];
}


+ (void)postVoiceData:(NSMutableArray *)VoicesData uploadUrl:(NSString *)url name:(NSString *)name mimeType:(NSString *)mimeType suffix:(NSString *)suffix parametersDic:(NSDictionary *)parametersDic uploadProgress:(loadProgress)progress success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    if (suffix == nil || [suffix stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0) {
        suffix = @"spx";
    }
    
    if (mimeType == nil || [mimeType stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0) {
        mimeType = @"audio/ogg";
    }
    
    [[self alloc] uploadMutipleWithUrl:url fileDatas:VoicesData filePaths:nil name:name mimeType:mimeType suffix:suffix parametersDic:parametersDic uploadProgress:^(int64_t bytesRead, int64_t totalBytesRead) {
        
        if (progress) {
            progress(bytesRead, totalBytesRead);
        }
        
    } success:^(NSDictionary *requestObj) {
        
        if (success) {
            success(requestObj);
        }
        
    } failure:^(NSError *errorInfo) {
        
        if (failure) {
            failure(errorInfo);
        }
        
    }];
}


+ (void)postWithFilesPaths:(NSMutableArray *)filePaths uploadUrl:(NSString *)url name:(NSString *)name suffix:(NSString *)suffix parametersDic:(NSDictionary *)parameters uploadProgress:(loadProgress)progress success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    if (suffix == nil) {
        suffix = @"";
    }
    
    [[self alloc] uploadMutipleWithUrl:url fileDatas:nil filePaths:filePaths name:name mimeType:@"application/octet-stream" suffix:suffix parametersDic:parameters uploadProgress:^(int64_t bytesRead, int64_t totalBytesRead) {
        
        if (progress) {
            progress(bytesRead, totalBytesRead);
        }
        
    } success:^(NSDictionary *requestObj) {
        
        if (success) {
            success(requestObj);
        }
        
    } failure:^(NSError *errorInfo) {
        
        if (failure) {
            failure(errorInfo);
        }
        
    }];

}


- (void)uploadMutipleWithUrl:(NSString *)url fileDatas:(NSMutableArray *)fileDatas filePaths:(NSMutableArray *)filePaths name:(NSString *)name mimeType:(NSString *)type suffix:(NSString *)suffix parametersDic:(NSDictionary *)parametersDic uploadProgress:(loadProgress)progress success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    if (filePaths != nil && fileDatas == nil) {
        
        fileDatas = [NSMutableArray array];
        for (int i = 0; i < filePaths.count; i ++) {
            NSData *data = [NSData dataWithContentsOfFile:filePaths[i]];
            [fileDatas addObject:data];
        }
        
    }
    
    if (fileDatas && fileDatas.count > 0) {
        
        NSString *urlWithoutQuery = [self prepareUrlWithoutQueryRequestWithUrlStr:url];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];        

        NSURLSessionDataTask *tast = [manager POST:urlWithoutQuery parameters:parametersDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
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
                YBLog(@"上传多个文件错误： %@", error);
            }
            
        }];
        
        [tast resume];
    }
}


- (void)requestWithUrl:(NSString *)url withDic:(NSDictionary *)parameters requestType:(RequestType)requestType success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    NSString *urlWithoutQuery = [self prepareUrlWithoutQueryRequestWithUrlStr:url];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
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
                YBLog(@"get请求错误: %@", error.userInfo);
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
                YBLog(@"post请求错误: %@", error.userInfo);
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
                YBLog(@"put请求错误: %@", error.userInfo);
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
                YBLog(@"delete请求错误: %@", error.userInfo);
                failure(error);
            }

        }];
    }
}


- (NSString *)prepareUrlWithoutQueryRequestWithUrlStr:(NSString *)urlStr {
    //状态栏转起来
    [self networkType:^(NSInteger type) {
        if (type > 0) {
            NSLog(@"start animating");
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        }
    }];
    //如果不是完整链接就拼接上baseurl
    NSString *urlWithoutQuery = [self urlWithoutQuery:urlStr];
    return [urlWithoutQuery stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
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
- (void)networkType:(void (^)(NSInteger type))networkType {
    //创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"status = %ld", status);
        //监测到网络改变
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                YBLog(@"未知网络状态");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                YBLog(@"无网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                YBLog(@"蜂窝数据网");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                YBLog(@"WiFi网络");
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
        
        NSString *parameter =[NSString stringWithFormat:@"%@=%@",finalKey,finalValue];
        
        [parameters addObject:parameter];
    }];
    
    NSString *queryString = [parameters componentsJoinedByString:@"&"];
    queryString = queryString ? [NSString stringWithFormat:@"?%@",queryString] : @"";
    NSString *baseUrl = [NSString stringWithFormat:@"%@%@",urlStr,queryString];
    //处理url包含中文的问题
    return [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end
