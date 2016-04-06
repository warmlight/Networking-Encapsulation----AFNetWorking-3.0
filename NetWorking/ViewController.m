//
//  ViewController.m
//  NetWorking
//
//  Created by yiban on 16/3/28.
//  Copyright © 2016年 yiban. All rights reserved.
//
#import "ViewController.h"
#import "Http.h"

#define BaseUrl @"http://localhost:82/"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置baseUrl
    [Http updateBaseUrl:BaseUrl];
    
    NSLog(@"baseurl = %@", [Http baseUrl]);
    
//    //各个方法的调用
//    [self get];
//    [self post];
//    [self download];
//    [self uploadImage];
//    [self uploadVoice];
//    [self uploadFile];
//    [self uploadWithPath];
}


- (void)get {
    [Http getUrl:@"http://localhost:82/getMethod.php?id=123" parametersDic: nil success:^(NSDictionary *requestDic) {
        NSLog(@"完整get %@\n%@", requestDic,requestDic[@"name"]);
    } failure:^(NSError *errorInfo) {

    }];
    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"123" , @"id", nil];
    [Http getUrl:@"getMethod.php" parametersDic:dic success:^(NSDictionary *requestDic) {
        NSLog(@"部分URL get %@\n%@", requestDic,requestDic[@"name"]);
    } failure:^(NSError *errorInfo) {
        
    }];
}


- (void)post {
    [Http postUrl:@"http://localhost:82/postMethod.php?id=123" parametersDic:nil success:^(NSDictionary *requestDic) {
        NSLog(@"完整post %@\n%@", requestDic,requestDic[@"name"]);
    } failure:^(NSError *errorInfo) {
        
    }];
    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"123" , @"id", nil];
    [Http postUrl:@"postMethod.php" parametersDic:dic success:^(NSDictionary *requestDic) {
        NSLog(@"部分URL post %@\n%@", requestDic,requestDic[@"name"]);
    } failure:^(NSError *errorInfo) {
        
    }];
}


- (void)download {
    
    [Http downLoadUrl:@"http://localhost:82/uploads/7096.wav" parametersDic:nil downLoadProgress:^(int64_t bytesRead, int64_t totalBytesRead) {
        NSLog(@"%lld",  bytesRead);
    } success:^(NSURL *filePath, NSURLResponse *response) {
        NSLog(@"download成功 %@", filePath);
    } failure:^(NSError *errorInfo) {

    }];
    
}

- (void)uploadImage {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *filePath = [docDir stringByAppendingPathComponent:@"80.png"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:data];
    [arr addObject:data];
    [arr addObject:data];

    
    [Http postImagesData:arr uploadUrl:@"uploadMultipleImage.php" name:@"image[]" parametersDic:nil uploadProgress:^(int64_t bytesRead, int64_t totalBytesRead) {
        NSLog(@"%lld",  bytesRead);
    } success:^(NSDictionary *requestObj) {
        NSLog(@"上传图片成功 ：%@", requestObj);
    } failure:^(NSError *errorInfo) {
        NSLog(@"fail :%@", errorInfo);
    }];
}


- (void)uploadFile {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *filePath = [docDir stringByAppendingPathComponent:@"80.png"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSMutableArray *filesDataArr = [NSMutableArray array];
    [filesDataArr addObject:data];
    [filesDataArr addObject:data];
    [filesDataArr addObject:data];
    
    [Http postFilesData:filesDataArr uploadUrl:@"uploadMultipleFile.php" name:@"file[]" suffix:nil parametersDic:nil uploadProgress:^(int64_t bytesRead, int64_t totalBytesRead) {
        NSLog(@"%lld",  bytesRead/totalBytesRead);
    } success:^(NSDictionary *requestObj) {
        NSLog(@"上传文件成功 ：%@", requestObj);
    } failure:^(NSError *errorInfo) {
        //
    }];
    
}


- (void)uploadVoice {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *filePath = [docDir stringByAppendingPathComponent:@"7096.wav"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:data];
    [arr addObject:data];
    [arr addObject:data];
    
    [Http postVoiceData:arr uploadUrl:@"uploadMultipleFile.php" name:@"file[]" mimeType:@"audio/x-wav" suffix:@"wav" parametersDic:nil uploadProgress:^(int64_t bytesRead, int64_t totalBytesRead) {
        NSLog(@"%lld",  bytesRead);
    } success:^(NSDictionary *requestObj) {
        NSLog(@"上传音乐成功 ：%@", requestObj);
    } failure:^(NSError *errorInfo) {
        
    }];
}


- (void)uploadWithPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *filePath = [docDir stringByAppendingPathComponent:@"80.png"];
    NSMutableArray *filesPathArr = [NSMutableArray array];
    [filesPathArr addObject:filePath];
    [filesPathArr addObject:filePath];
    [filesPathArr addObject:filePath];
    
    [Http postWithFilesPaths:filesPathArr uploadUrl:@"uploadMultipleFile.php" name:@"file[]" suffix:@"png" parametersDic:nil uploadProgress:^(int64_t bytesRead, int64_t totalBytesRead) {
        NSLog(@"%lld",  bytesRead/totalBytesRead);
    } success:^(NSDictionary *requestObj) {
        NSLog(@"上传文件成功 ：%@", requestObj);
    } failure:^(NSError *errorInfo) {
        //
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)get:(id)sender {
    //各个方法的调用
    [self get];
}

- (IBAction)post:(id)sender {
    [self post];

}

- (IBAction)download:(id)sender {
    [self download];

}

- (IBAction)uploadimg:(id)sender {
    [self uploadImage];

}

- (IBAction)uploadvoice:(id)sender {
    [self uploadVoice];

}

- (IBAction)uploadfie:(id)sender {
    [self uploadFile];

}

- (IBAction)uploadpath:(id)sender {
    [self uploadWithPath];

}
@end
