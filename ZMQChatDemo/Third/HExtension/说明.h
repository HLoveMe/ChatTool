//
//  Header.h
//  我的模型字典
//
//  Created by ZZH   github userName:HLoveMe on 16/3/24.
//  Copyright © 2016年 Space. All rights reserved.
//
HIvar是对属性的包装
HArhiever 是用于序列化和反序列化
HKeyValueModel 字典转模型的基类


1：需要解析的类继承 HKeyValueModel 就可以直接解析
2：选择实现对应方法 特殊处理一些属性
 /**   字典和属性名字不匹配
    1:类中的属性名为   @“ID”
    2:字典的key名为    @“id”
    该方法返回  @{@“ID”:@"id"，...}
  */
-(NSDictionary *)PropertyNameForKey{return  nil;}
 /**
  1:类有一个数组属性 对应网络数据的数组
  2：网络数组中的字典  可以转为类  Model
  该方法返回@{@“数组名”:[Model class]}
  */
-(NSDictionary *)classInArray{return nil;}



3：已经实现了NSCoding协议 可直接序列化
                        转换
    dictionary                       model


 1   NSnumber         >>        NSnumber  NSString NSMutableString(int  double
                                                                  float  long)

 2  NSString
   NSMutableString   >>        NSURL  NSNumber NSMutableString (int  double
                                                             float  long)

 3  NSArray           >>        NSArray<Model *>*

 4  NSDictionary     >>         Model