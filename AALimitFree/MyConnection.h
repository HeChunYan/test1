//
//  MyConnection.h
//  AALimitFree
//
//  Created by MS on 15-9-16.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class MyConnection;

//委托方第一步，声明协议
@protocol MyConnectionDelegate <NSObject>

//给代理方返回一个自己类型的数据的自己
//必须让代理调用这两个方法
- (void)myConnectionDidFinish:(MyConnection *)mc;
- (void)myConnectionDidFail:(MyConnection *)mc withError:(NSError *)error;

@end


@interface MyConnection : NSObject<NSURLConnectionDataDelegate>

//strong只能用于ARC,retain两者都可以
@property (nonatomic, retain) NSMutableData *downloadData;
@property (nonatomic, copy) NSString *urlStr;
//tag相当于一个属性，可以用来表示是哪次下载
@property (nonatomic, assign) NSInteger tag;


//委托方第二步，delegate指针
//申明一个委托方指针,指向代理方，即让它做事的人
@property (nonatomic, assign) id<MyConnectionDelegate> delegate;


//instancetype 指当前对象类型  即:MyConnection*  id是任意类型
- (id)initWithUrlStr:(NSString *)urlStr;
- (void)start;


@end





