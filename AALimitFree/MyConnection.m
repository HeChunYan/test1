//
//  MyConnection.m
//  AALimitFree
//
//  Created by MS on 15-9-16.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import "MyConnection.h"

@implementation MyConnection

- (id)initWithUrlStr:(NSString *)urlStr
{
    if (self = [super init]) {
        
//        [self setUrlStr:urlStr];
        //点语法就是调用函数
        self.urlStr = urlStr;
        NSLog(@"urlStr = %@",urlStr);
    }
    return self;
}

- (void)start
{
    _downloadData = [[NSMutableData alloc] init];
    
    NSURL *url = [NSURL URLWithString:_urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:15];//最长请求时间15秒，cachePolicy ＝ 0:默认的缓存策略
    
    //创建了一个Connection，在下载中Connection不会消失，他的代理也不会消失，即使代理方已经没有指针再指向他了。当下载结束后都消失了
    [NSURLConnection connectionWithRequest:request delegate:self];
    //X6没有引入<UIKit/UIKit.h>，用不了UIApplication，用的话要自己引入
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
}
#pragma mark - NSURLConnection

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"000");
    _downloadData.length = 0;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_downloadData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //把二进制数据转换成字符串打印
//    NSLog(@"data = %@",[[NSString alloc] initWithData:_downloadData encoding:NSUTF8StringEncoding]);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    
    //委托方第三步：在需要的时候，让代理执行协议方法
    //即在传输完成或者失败的时候让代理方执行委托方的两个方法
    [self.delegate myConnectionDidFinish:self];
    
    
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"error");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    //委托方第三步：在需要的时候，让代理执行协议方法
    [self.delegate myConnectionDidFail:self withError:error];
}












@end
