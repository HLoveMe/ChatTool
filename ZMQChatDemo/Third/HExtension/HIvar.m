//
//  HIvar.m
//  我的模型字典
//
//  Created by ZZH   github userName:HLoveMe on 16/3/24.
//  Copyright © 2016年 Space. All rights reserved.
//

#import "HIvar.h"
@implementation HIvar
-(instancetype)initWithIvar:(Ivar)ivar{
    if (self=[super init]) {
        self.ivar=ivar;
    }
    return self;
}

-(void)setIvar:(Ivar)ivar{
    _ivar=ivar;
    NSString *name=[NSString stringWithUTF8String:ivar_getName(ivar)];
    if (![name containsString:@"_"]) {
        self.propertyName=name;
    }else{
        self.propertyName=[name substringFromIndex:1];
    }
    self.isFoundation = YES;
    NSString *type=[NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
    if ([type containsString:@"@"]) {
       type= [type substringFromIndex:2];
       type= [type substringToIndex:type.length-1];
       if ([NSClassFromString(type) isSubclassOfClass:NSClassFromString(@"HKeyValueModel")]) {
            self.isFoundation = NO;
        }
    }
    self.type=type;
   
}
-(NSString *)description{
    NSMutableString *content = [NSMutableString stringWithFormat:@"PropertyName:%@    isFoundation:%d   type:%@",self.propertyName,self.isFoundation,self.type];
    return content;
}

@end
