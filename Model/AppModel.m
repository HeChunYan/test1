//
//  AppModel.m
//  AALimitFree
//
//  Created by MS on 15-9-16.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import "AppModel.h"

@implementation AppModel

+ (instancetype)modelWithDic:(NSDictionary *)dic
{
    AppModel *am = [[AppModel alloc] init];
    [am setValuesForKeysWithDictionary:dic];
    return am;
}

//避免因为找不到某个key而崩溃所写的方法
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


@end
