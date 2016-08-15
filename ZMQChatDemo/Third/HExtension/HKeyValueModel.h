//
//  HKeyValueModel.h
//  我的模型字典
//
//  Created by ZZH   github userName:HLoveMe on 16/3/24.
//  Copyright © 2016年 Space. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "HArhiever.h"
@protocol modelProtocol<NSObject>
@optional
//@{@"property":@"key"}
-(NSDictionary *)PropertyNameForKey;
//@{@"property":class}
-(NSDictionary <NSString *,Class >*)classInArray;
@end
@interface HKeyValueModel : HArhiever<modelProtocol>
/**
 *  字典转为模型
 *
 *  @param dictionary
 *
 *  @return
 */
+(id)modelWithDictionary:(NSDictionary *)dictionary;
/**
 *  字典数组转为模型数组
 *
 *  @param array
 *
 *  @return
 */
+(NSMutableArray *)modelsWithArray:(NSArray <NSDictionary *>*)array;
/**
 *  字典 NSData-----模型
 *
 *  @param data
 *
 *  @return
 */
+(id)modelFromDictionaryData:(NSData *)data;
/**
 *  数组 NSData-----模型
 *
 *  @param data
 *
 *  @return
 */
+(NSMutableArray*)modelsFromArrayData:(NSData *)data;
/**
 *  模型转字典
 *
 *  @return 
 */
-(NSDictionary *)dictionary;

/**
 *  处理一些简单GET的请求 网络返回数据位 JSON字典
 *  @param url      网络请求路径
 *  @param handle   得到网络数据 自己处理   Block返回对应的模型（字典）或者 （数组）
 *  @param complete 得到模型数据在这里处理
 */
+(void)GETdealDataByGetWithUrl:(NSString *)url   handle:(id/*Array或者Dic**/ (^)(NSDictionary *jsonDic,NSError *error))handle completeInMainThread:(void(^)(NSMutableArray *modelArray))complete;
/**
 *  处理一些简单POST的请求 网络返回数据  JSON字典
 *
 *  @param url         网络请求路径
 *  @param argumentDic 参数
 *  @param handle      得到网络数据 自己处理   Block返回对应的模型（字典）或者 （数组）
 *  @param complete    得到模型数据在这里处理
 */
+(void)POSTdealDataByGetWithUrl:(NSString *)url  argumentDic:(NSDictionary *)argumentDic handle:(id (^)(NSDictionary *jsonDic,NSError *error))handle completeInMainThread:(void(^)(NSMutableArray *modelArray))complete;
@end

@interface NSArray (KHeyValue)
/**
 *  把包含 HKeyValueModel的数组转为数组（json类型 只包含基本数据）
 */
+(NSArray *)arrayByArray:(NSArray *)source;
@end

@interface NSDictionary (HKeyValue)
/**
 *  把包含 HKeyValueModel的字典转为字典（json类型 只包含基本数据）
 */
+(NSDictionary *)dictionaryByDictionary:(NSDictionary *)source;
@end
