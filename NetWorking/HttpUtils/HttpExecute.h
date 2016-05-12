//
//  HttpExecute.h
//  NetWorking
//
//  Created by yiban on 16/5/12.
//  Copyright © 2016年 yiban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UrlSessionManager.h"

#ifdef __OPTIMIZE__
# define DLogInfo(...) {}
#else
# define DLogInfo(fmt, ...)  NSLog((@"\n---------------------------------------------------\n[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#endif

typedef NS_ENUM(NSInteger, RequestType) {
    RequestTypeGet,
    RequestTypePost,
    RequestTypePut,
    RequestTypeDelete,
};

/*!
 *  成功的回调
 *
 *  @param requestObj 接口返回的数据字典
 */
typedef void (^SuccessBlock)(NSDictionary * requestDic);

/*!
 *  失败的回调
 *
 *  @param errorInfo 失败的错误信息
 */
typedef void (^FailureBlock)(NSError *errorInfo);

/*!
 *  进度的回调
 *
 *  @param bytesRead      已经上传/下载的数据大小
 *  @param totalBytesRead 总共的数据大小
 */
typedef void (^loadProgress)(int64_t bytesRead, int64_t totalBytesRead);



@interface HttpExecute : NSObject
/*!
 *  得到当前的BaseUrl
 *
 */
+ (NSString *)fetchBaseeUrl;

/*!
 *  设置BaseUrl，只用设置一次可全局使用，当需要改动时再调用进行设置
 *
 */
+ (void)updateBaseUrl:(NSString *)baseUrl;

/*!
 *  获取当前网络连接类型 网络变化时会回调该函数
 *
 *  @param networkType 连接类型，-1：未知， 0：无网络，1：蜂窝网，2：wifi
 */
- (void)networkType:(void (^)(AFNetworkReachabilityStatus type))networkType;

/*!
 *  上传方法的具体实现
 *
 */
- (void)uploadMutipleWithUrl:(NSString *)url fileDatas:(NSMutableArray *)fileDatas filePaths:(NSMutableArray *)filePaths name:(NSString *)name mimeType:(NSString *)type suffix:(NSString *)suffix parametersDic:(NSDictionary *)parametersDic sessionManager:(UrlSessionManager *)sessionManager uploadProgress:(loadProgress)progress success:(SuccessBlock)success failure:(FailureBlock)failure;

/*!
 *  get/post/put/delete方法的具体实现
 *
 */
- (void)requestWithUrl:(NSString *)url withDic:(NSDictionary *)parameters requestType:(RequestType)requestType sessionManager:(UrlSessionManager *)sessionManager success:(SuccessBlock)success failure:(FailureBlock)failure;

/*!
 *  下载方法的具体实现
 *
 */
- (void)downLoadUrl:(NSString *)url parametersDic:(NSDictionary *)parameters sessionManager:(UrlSessionManager *)sessionManager downLoadProgress:(loadProgress)progress success:(void (^)(NSURL *filePath, NSURLResponse *response))success failure:(FailureBlock)failure;
@end
