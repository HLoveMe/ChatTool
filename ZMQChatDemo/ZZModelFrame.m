//
//  ZZModelFrame.m
//  HMenu
//
//  Created by HMenu on 16/5/18.
//  Copyright © 2016年 HMenu. All rights reserved.
//

#import "ZZModelFrame.h"

//边距
#define  Margin 10

@implementation ZZModelFrame

- (void)setZzModel:(ZZModel *)zzModel{
    
    _zzModel = zzModel;
    
    //时间
    self.timeFrame = CGRectMake( 60 ,Margin, kScreenWidth - 120, 20);
    
    //头像
    CGRect icon;
    
    if (zzModel.ismySelf) {
        
        icon = CGRectMake(kScreenWidth - 50, Margin, 40, 40);
    
    }else{
        
        icon = CGRectMake(Margin, Margin, 40, 40);
    }
    
    self.iconFrame = icon;
    
    //聊天内容
    CGSize size = [zzModel.content boundingRectWithSize:CGSizeMake(kScreenWidth  - 140, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil].size;
    
    CGFloat leftRight = 20;
    CGFloat topBottom = 20;
    
    CGFloat messageX ;
    CGFloat messageY = CGRectGetMaxY(self.timeFrame);
    CGFloat messageW = size.width + topBottom + leftRight - 7;
    CGFloat messageH  = size.height + topBottom + leftRight - 7;
    
    if (zzModel.ismySelf) {
        
        messageX = kScreenWidth - messageW - 60;
        
    }else{
    
        messageX = CGRectGetMaxX(self.iconFrame) + 10;
    }
    
    self.messageFrame = CGRectMake(messageX, messageY, messageW, messageH);
    
    
    //cell 高度
    self.height = CGRectGetMaxY(self.messageFrame) + Margin;

}


@end
