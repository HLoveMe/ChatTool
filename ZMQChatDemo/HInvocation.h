//
//  HInvocation.h
//  ZMQChatDemo
//
//  Created by 朱子豪 on 16/6/7.
//  Copyright © 2016年 智立教育. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HStringExchange.h"
@interface HInvocation : NSObject<HStringExchange>
@property(nonatomic,copy)NSString *title;
@property(nonatomic,weak)id target;
@property(nonatomic,assign)SEL aSel;
+(instancetype)invocation:(NSString*)title target:(id)target sel:(SEL)aSel;
@end
