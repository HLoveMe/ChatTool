//
//  ZZModel.h
//  HMenu
//
//  Created by HMenu on 16/5/18.
//  Copyright © 2016年 HMenu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HKeyValueModel.h"
@interface ZZModel : HKeyValueModel

@property(nonatomic,copy) NSString *content;

@property(nonatomic,copy) NSString *user_name;

@property(nonatomic,copy) NSString *create_time;

@property(nonatomic,copy) NSString *train_discuss_id;

@property(nonatomic,copy) NSString *head_img_url;

@property(nonatomic,copy) NSString *user_id;


@property(nonatomic,assign)BOOL ismySelf;

@end
