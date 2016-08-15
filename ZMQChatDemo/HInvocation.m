//
//  HInvocation.m
//  ZMQChatDemo
//
//  Created by 朱子豪 on 16/6/7.
//  Copyright © 2016年 智立教育. All rights reserved.
//

#import "HInvocation.h"

@implementation HInvocation
-(NSString*)toString{
    return self.title;
}
+(instancetype)invocation:(NSString*)title target:(id)target sel:(SEL)aSel{
    HInvocation *one = [[HInvocation alloc]init];
    one.title=title;
    one.target=target;
    one.aSel = aSel;
    return one;
}
@end
