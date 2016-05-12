//
//  Http.h
//  NetWorking
//
//  Created by yiban on 16/3/28.
//  Copyright © 2016年 yiban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlSessionManager.h"
#import "HttpExecute.h"

@interface Http : NSObject

/*!
 *  设置BaseUrl，只用设置一次可全局使用，当需要改动时再调用进行设置
 */
@property(strong, nonatomic) NSString *baseUrl;

/*!
 *  get请求
 *
 *  @param url        请求的url,可以是完整的url,也可以是url用来跟BaseUrl拼接的部分
 *  @param parameters 请求参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)getUrl:(NSString *)url parametersDic:(NSDictionary *)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

/*!
 *  post请求
 *
 *  @param url        请求的url,可以是完整的url,也可以是url用来跟BaseUrl拼接的部分
 *  @param parameters 请求参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调

 */
+ (void)postUrl:(NSString *)url parametersDic:(NSDictionary *)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

/*!
 *  put请求
 *
 *  @param url        请求的url,可以是完整的url,也可以是url用来跟BaseUrl拼接的部分
 *  @param parameters 请求参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)putUrl:(NSString *)url parametersDic:(NSDictionary *)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

/*!
 *  delete请求
 *
 *  @param url        请求的url,可以是完整的url,也可以是url用来跟BaseUrl拼接的部分
 *  @param parameters 请求参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)deleteUrl:(NSString *)url parametersDic:(NSDictionary *)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

/*!
 *  下载请求
 *
 *  @param url        下载的url,可以是完整的url,也可以是url用来跟BaseUrl拼接的部分
 *  @param parameters 请求参数
 *  @param progress   下载进度的回调
 *  @param success    下载请求成功的回调, filePath是下载文件在本地的存储地址
 *  @param failure    下载请求失败的回调
 */
+ (void)downLoadUrl:(NSString *)url parametersDic:(NSDictionary *)parameters downLoadProgress:(loadProgress)progress success:(void (^)(NSURL *filePath, NSURLResponse *response))success failure:(FailureBlock)failure;

/*!
 *  上传图片
 *
 *  @param imagesData    上传的图片数组，元素为图片的data
 *  @param url           上传的url,可以是完整的url,也可以是url用来跟BaseUrl拼接的部分
 *  @param name          上传参数名（与后端约定）
 *  @param parameters    上传参数
 *  @param progress      上传进度的回调
 *  @param success       上传请求成功的回调
 *  @param failure       上传请求失败的回调
 */
+ (void)postImagesData:(NSMutableArray *)imagesData uploadUrl:(NSString *)url name:(NSString *)name parametersDic:(NSDictionary *)parameters uploadProgress:(loadProgress)progress success:(SuccessBlock)success failure:(FailureBlock)failure;

/*!
 *  上传文件
 *
 *  @param imagesData    上传的文件数组，元素为文件的data
 *  @param url           上传的url,可以是完整的url,也可以是url用来跟BaseUrl拼接的部分
 *  @param name          上传参数名（与后端约定）
 *  @param suffix        上传文件扩展名，不赋值默认为空
 *  @param parameters    上传参数
 *  @param progress      上传进度的回调
 *  @param success       上传请求成功的回调
 *  @param failure       上传请求失败的回调
 */
+ (void)postFilesData:(NSMutableArray *)imagesData uploadUrl:(NSString *)url name:(NSString *)name suffix:(NSString *)suffix parametersDic:(NSDictionary *)parametersDic uploadProgress:(loadProgress)progress success:(SuccessBlock)success failure:(FailureBlock)failure;

/*!
 *  上传音频文件
 *
 *  @param VoicesData    上传的音频文件数组，元素为文件的data
 *  @param url           上传的url,可以是完整的url,也可以是url用来跟BaseUrl拼接的部分
 *  @param name          上传参数名（与后端约定）
 *  @param mimeType      mimeType, 不赋值默认为audio/ogg
 *  @param suffix        音频文件扩展名，不赋值默认为spx
 *  @param parameters    上传参数
 *  @param progress      上传进度的回调
 *  @param success       上传请求成功的回调
 *  @param failure       上传请求失败的回调
 */
+ (void)postVoiceData:(NSMutableArray *)VoicesData uploadUrl:(NSString *)url name:(NSString *)name mimeType:(NSString *)mimeType suffix:(NSString *)suffix parametersDic:(NSDictionary *)parametersDic uploadProgress:(loadProgress)progress success:(SuccessBlock)success failure:(FailureBlock)failure;

/*!
 *  通过文件地址上传文件
 *
 *  @param filePaths     上传文件的地址数组，元素为上传文件的地址
 *  @param url           上传的url,可以是完整的url,也可以是url用来跟BaseUrl拼接的部分
 *  @param name          上传参数名（与后端约定）
 *  @param suffix        文件的扩展名,不赋值默认为空
 *  @param parameters    上传参数
 *  @param progress      上传进度的回调
 *  @param success       上传请求成功的回调
 *  @param failure       上传请求失败的回调
 */
+ (void)postWithFilesPaths:(NSMutableArray *)filePaths uploadUrl:(NSString *)url name:(NSString *)name suffix:(NSString *)suffix parametersDic:(NSDictionary *)parameters uploadProgress:(loadProgress)progress success:(SuccessBlock)success failure:(FailureBlock)failure;

#pragma mark - 可定制sessionManager
/*!
 *  可定制sessionManager的get请求
 *
 *  @param url            请求的url,可以是完整的url,也可以是url用来跟BaseUrl拼接的部分
 *  @param parameters     请求参数
 *  @param sessionManager 可以根据需求传入设置好的sessionManager,例如可以设置好请求头
 *  @param success        请求成功的回调
 *  @param failure        请求失败的回调
 */
+ (void)getUrl:(NSString *)url parametersDic:(NSDictionary *)parameters sessionManager:(UrlSessionManager *)sessionManager success:(SuccessBlock)success failure:(FailureBlock)failure;

/*!
 *  可定制sessionManager的post请求
 *
 *  @param url            请求的url,可以是完整的url,也可以是url用来跟BaseUrl拼接的部分
 *  @param parameters     请求参数
 *  @param sessionManager 可以根据需求传入设置好的sessionManager,例如可以设置好请求头
 *  @param success        请求成功的回调
 *  @param failure        请求失败的回调
 */
+ (void)postUrl:(NSString *)url parametersDic:(NSDictionary *)parameters sessionManager:(UrlSessionManager *)sessionManager success:(SuccessBlock)success failure:(FailureBlock)failure;

/*!
 *  可定制sessionManager的put请求
 *
 *  @param url            请求的url,可以是完整的url,也可以是url用来跟BaseUrl拼接的部分
 *  @param parameters     请求参数
 *  @param sessionManager 可以根据需求传入设置好的sessionManager,例如可以设置好请求头
 *  @param success        请求成功的回调
 *  @param failure        请求失败的回调
 */
+ (void)putUrl:(NSString *)url parametersDic:(NSDictionary *)parameters sessionManager:(UrlSessionManager *)sessionManager success:(SuccessBlock)success failure:(FailureBlock)failure;

/*!
 *  可定制sessionManager的delete请求
 *
 *  @param url            请求的url,可以是完整的url,也可以是url用来跟BaseUrl拼接的部分
 *  @param parameters     请求参数
 *  @param sessionManager 可以根据需求传入设置好的sessionManager,例如可以设置好请求头
 *  @param success        请求成功的回调
 *  @param failure        请求失败的回调
 */
+ (void)deleteUrl:(NSString *)url parametersDic:(NSDictionary *)parameters sessionManager:(UrlSessionManager *)sessionManager success:(SuccessBlock)success failure:(FailureBlock)failure;

/*!
 *  可定制sessionManager的下载请求
 *
 *  @param url            下载的url,可以是完整的url,也可以是url用来跟BaseUrl拼接的部分
 *  @param parameters     请求参数
 *  @param sessionManager 可以根据需求传入设置好的sessionManager,例如可以设置好请求头
 *  @param progress       下载进度的回调
 *  @param success        下载请求成功的回调, filePath是下载文件在本地的存储地址
 *  @param failure        下载请求失败的回调
 */
+ (void)downLoadUrl:(NSString *)url parametersDic:(NSDictionary *)parameters sessionManager:(UrlSessionManager *)sessionManager downLoadProgress:(loadProgress)progress success:(void (^)(NSURL *filePath, NSURLResponse *response))success failure:(FailureBlock)failure;

/*!
 *  可定制sessionManager的上传图片
 *
 *  @param imagesData     上传的图片数组，元素为图片的data
 *  @param url            上传的url,可以是完整的url,也可以是url用来跟BaseUrl拼接的部分
 *  @param name           上传参数名（与后端约定）
 *  @param parameters     上传参数
 *  @param sessionManager 可以根据需求传入设置好的sessionManager,例如可以设置好请求头
 *  @param progress       上传进度的回调
 *  @param success        上传请求成功的回调
 *  @param failure        上传请求失败的回调
 */
+ (void)postImagesData:(NSMutableArray *)imagesData uploadUrl:(NSString *)url name:(NSString *)name parametersDic:(NSDictionary *)parameters sessionManager:(UrlSessionManager *)sessionManager uploadProgress:(loadProgress)progress success:(SuccessBlock)success failure:(FailureBlock)failure;

/*!
 *  可定制sessionManager的上传文件
 *
 *  @param imagesData     上传的文件数组，元素为文件的data
 *  @param url            上传的url,可以是完整的url,也可以是url用来跟BaseUrl拼接的部分
 *  @param name           上传参数名（与后端约定）
 *  @param suffix         上传文件扩展名，不赋值默认为空
 *  @param parameters     上传参数
 *  @param sessionManager 可以根据需求传入设置好的sessionManager,例如可以设置好请求头
 *  @param progress       上传进度的回调
 *  @param success        上传请求成功的回调
 *  @param failure        上传请求失败的回调
 */
+ (void)postFilesData:(NSMutableArray *)imagesData uploadUrl:(NSString *)url name:(NSString *)name suffix:(NSString *)suffix parametersDic:(NSDictionary *)parametersDic sessionManager:(UrlSessionManager *)sessionManager uploadProgress:(loadProgress)progress success:(SuccessBlock)success failure:(FailureBlock)failure;

/*!
 *  可定制sessionManager的上传音频文件
 *
 *  @param VoicesData     上传的音频文件数组，元素为文件的data
 *  @param url            上传的url,可以是完整的url,也可以是url用来跟BaseUrl拼接的部分
 *  @param name           上传参数名（与后端约定）
 *  @param mimeType       mimeType, 不赋值默认为audio/ogg
 *  @param suffix         音频文件扩展名，不赋值默认为spx
 *  @param parameters     上传参数
 *  @param sessionManager 可以根据需求传入设置好的sessionManager,例如可以设置好请求头
 *  @param progress       上传进度的回调
 *  @param success        上传请求成功的回调
 *  @param failure        上传请求失败的回调
 */
+ (void)postVoiceData:(NSMutableArray *)VoicesData uploadUrl:(NSString *)url name:(NSString *)name mimeType:(NSString *)mimeType suffix:(NSString *)suffix parametersDic:(NSDictionary *)parametersDic sessionManager:(UrlSessionManager *)sessionManager uploadProgress:(loadProgress)progress success:(SuccessBlock)success failure:(FailureBlock)failure;

/*!
 *  可定制sessionManager的通过文件地址上传文件
 *
 *  @param filePaths      上传文件的地址数组，元素为上传文件的地址
 *  @param url            上传的url,可以是完整的url,也可以是url用来跟BaseUrl拼接的部分
 *  @param name           上传参数名（与后端约定）
 *  @param suffix         文件的扩展名,不赋值默认为空
 *  @param parameters     上传参数
 *  @param sessionManager 可以根据需求传入设置好的sessionManager,例如可以设置好请求头
 *  @param progress       上传进度的回调
 *  @param success        上传请求成功的回调
 *  @param failure        上传请求失败的回调
 */
+ (void)postWithFilesPaths:(NSMutableArray *)filePaths uploadUrl:(NSString *)url name:(NSString *)name suffix:(NSString *)suffix parametersDic:(NSDictionary *)parameters sessionManager:(UrlSessionManager *)sessionManager uploadProgress:(loadProgress)progress success:(SuccessBlock)success failure:(FailureBlock)failure;

/*!
 *  获取当前网络连接类型 网络变化时会回调该函数
 *
 *  @param networkType 连接类型，-1：未知， 0：无网络，1：蜂窝网，2：wifi
 */
+ (void)networkType:(void (^)(AFNetworkReachabilityStatus type))networkType;
@end
