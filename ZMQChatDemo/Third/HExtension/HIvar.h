//
//  HIvar.h
//  我的模型字典
//
//  Created by ZZH   github userName:HLoveMe on 16/3/24.
//  Copyright © 2016年 Space. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <objc/runtime.h>
@interface HIvar : NSObject
@property(nonatomic,assign)Ivar ivar;
 /**去掉下划线的属性名*/
@property(nonatomic,copy)NSString *propertyName;
 /**属性的类型*/
@property(nonatomic,copy)NSString *type;
 /**是否为Foundation的提供的类*/
@property(nonatomic,assign)BOOL isFoundation;

-(instancetype)initWithIvar:(Ivar)ivar;
@end
