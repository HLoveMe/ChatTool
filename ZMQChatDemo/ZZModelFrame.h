//
//  ZZModelFrame.h
//  HMenu
//
//  Created by HMenu on 16/5/18.
//  Copyright © 2016年 HMenu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZZModel.h"

@interface ZZModelFrame : NSObject

@property(nonatomic,retain)ZZModel *zzModel;

@property(nonatomic,assign)CGRect iconFrame;//头像

@property(nonatomic,assign)CGRect timeFrame;//用户名和时间

@property(nonatomic,assign)CGRect messageFrame;//聊天的内容

@property(nonatomic,assign)CGFloat height;// cell 高度


@end
