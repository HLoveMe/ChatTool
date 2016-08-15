//
//  ZZCell.h
//  HMenu
//
//  Created by HMenu on 16/5/18.
//  Copyright © 2016年 HMenu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "ZZModel.h"
#import "ZZModelFrame.h"

#import "ZMQButton.h"

@interface ZZCell : UITableViewCell

@property(nonatomic,retain) UIImageView *iconView;//头像

@property(nonatomic,retain) UILabel *timeLabel;//时间和用户名

@property(nonatomic,retain) ZMQButton *zmqButton;



@property(nonatomic,retain) ZZModel *zzModel;
@property(nonatomic,retain) ZZModelFrame *zzModelframe;







@end
