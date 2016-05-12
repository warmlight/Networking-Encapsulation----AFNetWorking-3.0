//
//  Http.m
//  NetWorking
//
//  Created by yiban on 16/3/28.
//  Copyright © 2016年 yiban. All rights reserved.
//

#import "Http.h"
#import "AFNetworking.h"

@implementation Http

- (void)setBaseUrl:(NSString *)baseUrl {
    
    [HttpExecute updateBaseUrl:baseUrl];
}

- (NSString *)baseUrl {
    
    return [HttpExecute fetchBaseeUrl];
}


+ (void)getUrl:(NSString *)url parametersDic:(NSDictionary *)parameters success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    [[HttpExecute alloc] requestWithUrl:url withDic:parameters requestType:RequestTypeGet sessionManager:nil
                         success:^(NSDictionary *requestDic) {
                             success(requestDic);
                             
                         } failure:^(NSError *errorInfo) {
                             failure(errorInfo);
                         }];
}


+ (void)getUrl:(NSString *)url parametersDic:(NSDictionary *)parameters sessionManager:(UrlSessionManager *)sessionManager success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    [[HttpExecute alloc] requestWithUrl:url withDic:parameters requestType:RequestTypeGet sessionManager:sessionManager
     
                         success:^(NSDictionary *requestDic) {
                             success(requestDic);
                             
                         } failure:^(NSError *errorInfo) {
                             failure(errorInfo);
                         }];
}


+ (void)postUrl:(NSString *)url parametersDic:(NSDictionary *)parameters success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    [[HttpExecute alloc] requestWithUrl:url withDic:parameters requestType:RequestTypePost sessionManager:nil
                         success:^(NSDictionary *requestDic) {
                             success(requestDic);
                             
                         } failure:^(NSError *errorInfo) {
                             failure(errorInfo);
                         }];
}


+ (void)postUrl:(NSString *)url parametersDic:(NSDictionary *)parameters sessionManager:(UrlSessionManager *)sessionManager success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    [[HttpExecute alloc] requestWithUrl:url withDic:parameters requestType:RequestTypePost sessionManager:sessionManager
     
                         success:^(NSDictionary *requestDic) {
                             success(requestDic);
                             
                         } failure:^(NSError *errorInfo) {
                             failure(errorInfo);
                         }];
}


+ (void)putUrl:(NSString *)url parametersDic:(NSDictionary *)parameters success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    [[HttpExecute alloc] requestWithUrl:url withDic:parameters requestType:RequestTypePut sessionManager:nil
     
                         success:^(NSDictionary *requestDic) {
                             success(requestDic);
                             
                         } failure:^(NSError *errorInfo) {
                             failure(errorInfo);
                         }];
}


+ (void)putUrl:(NSString *)url parametersDic:(NSDictionary *)parameters sessionManager:(UrlSessionManager *)sessionManager success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    [[HttpExecute alloc] requestWithUrl:url withDic:parameters requestType:RequestTypePut sessionManager:sessionManager
     
                         success:^(NSDictionary *requestDic) {
                             success(requestDic);
                             
                         } failure:^(NSError *errorInfo) {
                             failure(errorInfo);
                         }];
}


+ (void)deleteUrl:(NSString *)url parametersDic:(NSDictionary *)parameters success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    [[HttpExecute alloc] requestWithUrl:url withDic:parameters requestType:RequestTypeDelete sessionManager:nil
     
                         success:^(NSDictionary *requestDic) {
                             success(requestDic);
                             
                         } failure:^(NSError *errorInfo) {
                             failure(errorInfo);
                         }];
}


+ (void)deleteUrl:(NSString *)url parametersDic:(NSDictionary *)parameters sessionManager:(UrlSessionManager *)sessionManager success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    [[HttpExecute alloc] requestWithUrl:url withDic:parameters requestType:RequestTypeDelete sessionManager:sessionManager
     
                         success:^(NSDictionary *requestDic) {
                             success(requestDic);
                             
                         } failure:^(NSError *errorInfo) {
                             failure(errorInfo);
                         }];
}


+ (void)downLoadUrl:(NSString *)url parametersDic:(NSDictionary *)parameters downLoadProgress:(loadProgress)progress success:(void (^)(NSURL *filePath, NSURLResponse *response))success failure:(FailureBlock)failure {
    
    [[HttpExecute alloc] downLoadUrl:url parametersDic:parameters sessionManager:nil downLoadProgress:^(int64_t bytesRead, int64_t totalBytesRead) {
        
        if (progress) {
            progress(bytesRead, totalBytesRead);
        }
        
    } success:^(NSURL *filePath, NSURLResponse *response) {
        
        if (success) {
            success(filePath, response);
        }
    } failure:^(NSError *errorInfo) {
        
        if (failure) {
            failure(errorInfo);
        }
    }];
}


+ (void)downLoadUrl:(NSString *)url parametersDic:(NSDictionary *)parameters sessionManager:(UrlSessionManager *)sessionManager downLoadProgress:(loadProgress)progress success:(void (^)(NSURL *filePath, NSURLResponse *response))success failure:(FailureBlock)failure {
    
    [[HttpExecute alloc] downLoadUrl:url parametersDic:parameters sessionManager:sessionManager downLoadProgress:^(int64_t bytesRead, int64_t totalBytesRead) {
        
        if (progress) {
            progress(bytesRead, totalBytesRead);
        }
        
    } success:^(NSURL *filePath, NSURLResponse *response) {
       
        if (success) {
            success(filePath, response);
        }
    } failure:^(NSError *errorInfo) {
        
        if (failure) {
            failure(errorInfo);
        }
    }];
}


+ (void)postImagesData:(NSMutableArray *)imagesData uploadUrl:(NSString *)url name:(NSString *)name parametersDic:(NSDictionary *)parameters uploadProgress:(loadProgress)progress success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    [[HttpExecute alloc] uploadMutipleWithUrl:url fileDatas:imagesData filePaths:nil name:name mimeType:@"image/jpeg" suffix:@"jpg" parametersDic:parameters sessionManager:nil uploadProgress:^(int64_t bytesRead, int64_t totalBytesRead) {
        
        if (progress) {
            progress(bytesRead, totalBytesRead);
        }
        
    } success:^(NSDictionary *requestDic) {
        
        if (success) {
            success(requestDic);
        }
        
    } failure:^(NSError *errorInfo) {
        
        if (failure) {
            failure(errorInfo);
        }
    }];
}


+ (void)postImagesData:(NSMutableArray *)imagesData uploadUrl:(NSString *)url name:(NSString *)name parametersDic:(NSDictionary *)parameters sessionManager:(UrlSessionManager *)sessionManager uploadProgress:(loadProgress)progress success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    [[HttpExecute alloc] uploadMutipleWithUrl:url fileDatas:imagesData filePaths:nil name:name mimeType:@"image/jpeg" suffix:@"jpg" parametersDic:parameters sessionManager:sessionManager uploadProgress:^(int64_t bytesRead, int64_t totalBytesRead) {
        
        if (progress) {
            progress(bytesRead, totalBytesRead);
        }
        
    } success:^(NSDictionary *requestDic) {
        
        if (success) {
            success(requestDic);
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
    
    [[HttpExecute alloc] uploadMutipleWithUrl:url fileDatas:imagesData filePaths:nil name:name mimeType:@"application/octet-stream" suffix:suffix parametersDic:parametersDic sessionManager:nil uploadProgress:^(int64_t bytesRead, int64_t totalBytesRead) {
        
        if (progress) {
            progress(bytesRead, totalBytesRead);
        }
        
    } success:^(NSDictionary *requestDic) {
        
        if (success) {
            success(requestDic);
        }
        
    } failure:^(NSError *errorInfo) {
        
        if (failure) {
            failure(errorInfo);
        }
    }];
}


+ (void)postFilesData:(NSMutableArray *)imagesData uploadUrl:(NSString *)url name:(NSString *)name suffix:(NSString *)suffix parametersDic:(NSDictionary *)parametersDic sessionManager:(UrlSessionManager *)sessionManager uploadProgress:(loadProgress)progress success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    if(suffix == nil) {
        suffix = @"";
    }
    
    [[HttpExecute alloc] uploadMutipleWithUrl:url fileDatas:imagesData filePaths:nil name:name mimeType:@"application/octet-stream" suffix:suffix parametersDic:parametersDic sessionManager:sessionManager uploadProgress:^(int64_t bytesRead, int64_t totalBytesRead) {
        
        if (progress) {
            progress(bytesRead, totalBytesRead);
        }
        
    } success:^(NSDictionary *requestDic) {
        
        if (success) {
            success(requestDic);
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
    
    [[HttpExecute alloc] uploadMutipleWithUrl:url fileDatas:VoicesData filePaths:nil name:name mimeType:mimeType suffix:suffix parametersDic:parametersDic sessionManager:nil uploadProgress:^(int64_t bytesRead, int64_t totalBytesRead) {
        
        if (progress) {
            progress(bytesRead, totalBytesRead);
        }
        
    } success:^(NSDictionary *requestDic) {
        
        if (success) {
            success(requestDic);
        }
        
    } failure:^(NSError *errorInfo) {
        
        if (failure) {
            failure(errorInfo);
        }
    }];
}


+ (void)postVoiceData:(NSMutableArray *)VoicesData uploadUrl:(NSString *)url name:(NSString *)name mimeType:(NSString *)mimeType suffix:(NSString *)suffix parametersDic:(NSDictionary *)parametersDic sessionManager:(UrlSessionManager *)sessionManager uploadProgress:(loadProgress)progress success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    if (suffix == nil || [suffix stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0) {
        suffix = @"spx";
    }
    
    if (mimeType == nil || [mimeType stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0) {
        mimeType = @"audio/ogg";
    }
    
    [[HttpExecute alloc] uploadMutipleWithUrl:url fileDatas:VoicesData filePaths:nil name:name mimeType:mimeType suffix:suffix parametersDic:parametersDic sessionManager:sessionManager uploadProgress:^(int64_t bytesRead, int64_t totalBytesRead) {
        
        if (progress) {
            progress(bytesRead, totalBytesRead);
        }
        
    } success:^(NSDictionary *requestDic) {
        
        if (success) {
            success(requestDic);
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
    
    [[HttpExecute alloc] uploadMutipleWithUrl:url fileDatas:nil filePaths:filePaths name:name mimeType:@"application/octet-stream" suffix:suffix parametersDic:parameters sessionManager:nil uploadProgress:^(int64_t bytesRead, int64_t totalBytesRead) {
        
        if (progress) {
            progress(bytesRead, totalBytesRead);
        }
        
    } success:^(NSDictionary *requestDic) {
        
        if (success) {
            success(requestDic);
        }
        
    } failure:^(NSError *errorInfo) {
        
        if (failure) {
            failure(errorInfo);
        }
    }];
}


+ (void)postWithFilesPaths:(NSMutableArray *)filePaths uploadUrl:(NSString *)url name:(NSString *)name suffix:(NSString *)suffix parametersDic:(NSDictionary *)parameters sessionManager:(UrlSessionManager *)sessionManager uploadProgress:(loadProgress)progress success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    if (suffix == nil) {
        suffix = @"";
    }
    
    [[HttpExecute alloc] uploadMutipleWithUrl:url fileDatas:nil filePaths:filePaths name:name mimeType:@"application/octet-stream" suffix:suffix parametersDic:parameters sessionManager:sessionManager uploadProgress:^(int64_t bytesRead, int64_t totalBytesRead) {
        
        if (progress) {
            progress(bytesRead, totalBytesRead);
        }
        
    } success:^(NSDictionary *requestDic) {
        
        if (success) {
            success(requestDic);
        }
        
    } failure:^(NSError *errorInfo) {
        
        if (failure) {
            failure(errorInfo);
        }
    }];
}


+ (void)networkType:(void (^)(AFNetworkReachabilityStatus type))networkType {

    [[HttpExecute alloc] networkType:^(AFNetworkReachabilityStatus type) {
        if (networkType) {
            networkType(type);
        }
    }];
}
@end
