//
//  ZZCell.m
//  HMenu
//
//  Created by HMenu on 16/5/18.
//  Copyright © 2016年 HMenu. All rights reserved.
//

#import "ZZCell.h"

@implementation ZZCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        [self _createSubview];
    }
    
    return self;
}


- (void)_createSubview{
    
    self.iconView = [[UIImageView alloc]init];
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.font = [UIFont systemFontOfSize:12.0];
    
    self.zmqButton = [[ZMQButton alloc] initWithFrame: self.zzModelframe.messageFrame];
    self.zmqButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.zmqButton.titleLabel.numberOfLines = 0;
    
    
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.zmqButton];
    
}


- (void)setZzModelframe:(ZZModelFrame *)zzModelframe{

    _zzModelframe = zzModelframe;
    _zzModel = zzModelframe.zzModel;
    
    [self setNeedsLayout];

}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    //更新frame
    self.iconView.frame = self.zzModelframe.iconFrame;
    self.timeLabel.frame = self.zzModelframe.timeFrame;
    self.zmqButton.frame = self.zzModelframe.messageFrame;
    
    //赋值
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.zzModel.head_img_url] placeholderImage:nil];
    
    NSString * timeString = [self changeTime:self.zzModel.create_time];
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@  %@",self.zzModel.user_name,timeString];
    
    
    [self.zmqButton setTitle:self.zzModel.content forState:UIControlStateNormal];
    
    
    UIImage *image;
    
    UIEdgeInsets messageButtonInsets;
    
    if (self.zzModel.ismySelf) {
    
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        
        [self.zmqButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        image = [UIImage imageNamed:@"chat_me"];
        
        messageButtonInsets = UIEdgeInsetsMake(20, 13, 20, 20);
        
    }else{
        
        self.timeLabel.textAlignment = NSTextAlignmentLeft;
        
        [self.zmqButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
   
        image = [UIImage imageNamed:@"chat_firend"];
        
        messageButtonInsets = UIEdgeInsetsMake(20, 20, 20, 13);
        
    }
    
    
    UIImage *backImage = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
    
    self.zmqButton.contentEdgeInsets = messageButtonInsets;
    
    [self.zmqButton setBackgroundImage:backImage forState:UIControlStateNormal];
    
    [self.zmqButton setBackgroundImage:backImage forState:UIControlStateHighlighted];
    
}

#pragma mark -- 时间转换
- (NSString *)changeTime:( NSString *)timeString{
    
    //    2015-10-22 05:30:00 ->
    
    NSDateFormatter *dateForMatter = [[NSDateFormatter alloc] init];

    [dateForMatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateForMatter setTimeZone:[NSTimeZone timeZoneWithName:@"en_US"]];
    
    NSDate *date = [dateForMatter dateFromString:timeString];
    
    NSDate *currentDate = [NSDate date];
    
    NSInteger time = [currentDate timeIntervalSinceDate:date];

    if (time < 60) {
        
        return @"刚刚";
    
    }else if (time < 60 * 60){
    
        return [NSString stringWithFormat:@"%ld分钟前",time/60];
    
    }else if (time < 60 * 60 * 24){
    
        NSTimeInterval secondsPerDay = 24 * 60 * 60;
        NSDate *today = [[NSDate alloc] init];
        NSDate *yesterday;
        
        yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    
        NSString * yesterdayString = [[yesterday description] substringToIndex:10];
        
        NSString * dateString = [[date description] substringToIndex:10];
        
        if ([dateString isEqualToString:yesterdayString]){
        
            return @"昨天";
        
        }else{
            
            return [NSString stringWithFormat:@"%ld小时前",time/(60*60)];
        }
    
    }else if(time < 60 * 60 * 24 * 7){
     
        return [NSString stringWithFormat:@"%ld天前",time/(60*60 * 24)];
   
    }else{

        return [timeString substringToIndex:10];
    }
}


@end
