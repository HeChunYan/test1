//
//  AppModel.h
//  AALimitFree
//
//  Created by MS on 15-9-16.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppModel : NSObject

@property (nonatomic,copy) NSString *applicationId;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *iconUrl;
@property (nonatomic,copy) NSString *expireDatetime;
@property (nonatomic,copy) NSString *starOverall;
@property (nonatomic,copy) NSString *lastPrice;
@property (nonatomic,copy) NSString *categoryName;
@property (nonatomic,copy) NSString *downloads;
@property (nonatomic,copy) NSString *favorites;
@property (nonatomic,copy) NSString *shares;

+ (instancetype)modelWithDic:(NSDictionary *)dic;

@end
