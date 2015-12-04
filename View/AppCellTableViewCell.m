//
//  AppCellTableViewCell.m
//  AALimitFree
//
//  Created by MS on 15-9-16.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import "AppCellTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation AppCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
    //此函数相当于初始化从xib中加载出来的cell
    _star.contentMode = UIViewContentModeLeft;
    _star.clipsToBounds  = YES;
}

//custom 习惯，惯例，风俗，海关，顾客   adj.定制的。定做的。
- (void)customWithModel:(AppModel *)am
{
    [_iconView sd_setImageWithURL:[NSURL URLWithString:am.iconUrl] placeholderImage:[UIImage imageNamed:@"appproduct_appdefault"]];
    NSLog(@"-------%@",am.iconUrl);
    _name.text = am.name;
    _price.text = [NSString stringWithFormat:@"%.1f",am.lastPrice.floatValue];
    _other.text = [NSString stringWithFormat:@"收藏：%@  分享：%@   下载%@",am.favorites,am.shares,am.downloads];
    
    CGRect frame = _star.frame;
    //65对应xib中星星label的宽度
    frame.size.width = 65/5*am.starOverall.floatValue;
    
    NSLog(@"time = %@",am.expireDatetime);
    
    _time.text = [self subTimeWithStr:am.expireDatetime];
    
}

- (NSString *)subTimeWithStr:(NSString *)dateStr
{
    //时间戳 （作用是转化成NSString和NSDate）
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    
    df.dateFormat = @"yyyy-MM-dd HH:mm:ss.0";
    
    //将符合格式的字符串转换成NSDate对象
    NSDate *date = [df dateFromString:dateStr];
    
    int second = [date timeIntervalSinceNow];
    
    return [NSString stringWithFormat:@"%02d:%02d:%02d",second/3600,second%3600/60,second%60];
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
