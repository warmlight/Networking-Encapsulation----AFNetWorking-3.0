#封装AFNetWorking 3.0

　　对AFNetWorking 3.0进行了封装，提供了一些常用方法，简化了使用。  
　　下载地址：[git](https://github.com/warmlight/Networking-Encapsulation----AFNetWorking-3.0)

##使用 How to use
　　将工程中的HttpUtils文件夹移入自己的项目。具体参数解释在注释中都有。

###get
```objective-c
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"123" , @"id", nil];
    [Http getUrl:@"getMethod.php" parametersDic:dic success:^(NSDictionary *requestDic) {
        NSLog(@"部分URL get %@\n%@", requestDic,requestDic[@"name"]);
    } failure:^(NSError *errorInfo) {
        
    }];
```

###post
```objective-c
    [Http postUrl:@"http://localhost:82/postMethod.php?id=123" parametersDic:nil success:^(NSDictionary *requestDic) {
        NSLog(@"%@", requestDic[@"name"]);
    } failure:^(NSError *errorInfo) {
        NSLog(@"failure :%@", errorInfo);
    }];
```

###download
```objective-c
    [Http downLoadUrl:@"http://localhost:82/uploads/7096.wav" parametersDic:nil downLoadProgress:^(int64_t bytesRead, int64_t totalBytesRead) {
        NSLog(@"%lld",  bytesRead);
    } success:^(NSURL *filePath, NSURLResponse *response) {
        NSLog(@"download success %@", filePath);
    } failure:^(NSError *errorInfo) {
	    NSLog(@"failure :%@", errorInfo);
    }];
```

###upload
#####images
```objective-c
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *filePath = [docDir stringByAppendingPathComponent:@"80.jpg"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSMutableArray *imgArr = [[NSMutableArray alloc] init];
    [imgArr addObject:data];
    [imgArr addObject:data];
    [imgArr addObject:data];
    
    [Http postImagesData:imgArr uploadUrl:@"uploadMultipleImage.php" name:@"image[]" parametersDic:nil uploadProgress:^(int64_t bytesRead, int64_t totalBytesRead) {
        NSLog(@"%lld",  bytesRead);
    } success:^(NSDictionary *requestObj) {
        NSLog(@"upload images success ：%@", requestObj);
    } failure:^(NSError *errorInfo) {
        NSLog(@"failure :%@", errorInfo);
    }];
```
####voice
```objective-c
    [Http postVoiceData:voiceArr uploadUrl:@"uploadMultipleFile.php" name:@"file[]" mimeType:@"audio/x-wav" suffix:@"wav" parametersDic:nil uploadProgress:^(int64_t bytesRead, int64_t totalBytesRead) {
        NSLog(@"%lld",  bytesRead);
    } success:^(NSDictionary *requestObj) {
        NSLog(@"upload music success ：%@", requestObj);
    } failure:^(NSError *errorInfo) {
        NSLog(@"failure :%@", errorInfo);
    }];
```
####file(通过文件的data上传 Through the file data)
```objective-c
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *filePath = [docDir stringByAppendingPathComponent:@"80.jpg"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSMutableArray *filesDataArr = [NSMutableArray array];
    [filesDataArr addObject:data];
    [filesDataArr addObject:data];
    [filesDataArr addObject:data];
    
    [Http postFilesData:filesDataArr uploadUrl:@"uploadMultipleFile.php" name:@"file[]" suffix:nil parametersDic:nil uploadProgress:^(int64_t bytesRead, int64_t totalBytesRead) {
        NSLog(@"%lld",  bytesRead);
    } success:^(NSDictionary *requestObj) {
        NSLog(@"upload files success ：%@", requestObj);
    } failure:^(NSError *errorInfo) {
        NSLog(@"failure :%@", errorInfo);    
    }];
```

####file(通过文件在本地的路径上传 Through the file's loacl path)
```objective-c
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *filePath = [docDir stringByAppendingPathComponent:@"80.jpg"];
    NSMutableArray *filesPathArr = [NSMutableArray array];
    [filesPathArr addObject:filePath];
    [filesPathArr addObject:filePath];
    [filesPathArr addObject:filePath];
    
    [Http postWithFilesPaths:filesPathArr uploadUrl:@"uploadMultipleFile.php" name:@"file[]" suffix:@"png" parametersDic:nil uploadProgress:^(int64_t bytesRead, int64_t totalBytesRead) {
        NSLog(@"%lld",  bytesRead);
    } success:^(NSDictionary *requestObj) {
        NSLog(@"upload files success ：%@", requestObj);
    } failure:^(NSError *errorInfo) {
        NSLog(@"failure :%@", errorInfo);    
    }];
```

##定制sessionManager
　　通过定制sessionManager能够自定义请求头，设置请求格式以及返回格式等等。  
　　以上所有方法都提供了接受自定义的sessionManager的请求方法。

```objective-c
    UrlSessionManager *manager = [UrlSessionManager sharedManager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"value" forHTTPHeaderField:@"headerField"];
    [Http getUrl:@"http://yourUrl" parametersDic:nil sessionManager:manager success:^(NSDictionary *requestDic) {
        NSLog(@"%@", requestDic);        
    } failure:^(NSError *errorInfo) {
        
    }];
```
