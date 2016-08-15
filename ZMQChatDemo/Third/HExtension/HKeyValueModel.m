//
//  HKeyValueModel.m
//  我的模型字典
//
//  Created by ZZH   github userName:HLoveMe on 16/3/24.
//  Copyright © 2016年 Space. All rights reserved.
//

#import "HKeyValueModel.h"
#import "HIvar.h"
@implementation HKeyValueModel
-(NSDictionary *)PropertyNameForKey{return  nil;}
-(NSDictionary *)classInArray{return nil;}
-(NSDictionary *)classForProperty{return nil;}
+(id)modelWithDictionary:(NSDictionary *)dictionary{
    id obj=[[self alloc]init];
    [self enumerateIvarsWithBlock:^(HIvar *ivar, BOOL *stop) {
        /**dictionary--->property*/
        /**得到切换后属性名*/
        NSString *key=ivar.propertyName;
        if ([obj respondsToSelector:@selector(PropertyNameForKey)]) {
            NSDictionary *dic=[obj PropertyNameForKey];
            NSString *oneKey=dic[ivar.propertyName];
            key=oneKey?oneKey:key;
        }
        NSObject *value=dictionary[key];
        if (value) {
            value=[obj valueFromValue:value toClassIvar:ivar];
            [obj setValue:value forKey:ivar.propertyName];
        }
    }];
    
    return obj;
}
+(id)modelFromDictionaryData:(NSData *)data{
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    return [self modelWithDictionary:dic];
}
+(NSMutableArray*)modelsFromArrayData:(NSData *)data{
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    return [self modelsWithArray:array];
}
+(NSMutableArray *)modelsWithArray:(NSArray *)array{
    NSMutableArray *dataArray=[NSMutableArray array];
    for (int i=0; i<array.count; i++) {
        if ([array[i] isKindOfClass:[NSDictionary class]]){
            id model=[self modelWithDictionary:array[i]];
            [dataArray addObject:model];
        }
    }
    return dataArray;
}
-(NSDictionary *)dictionary{
    __weak typeof(self) this = self;
    __block NSMutableDictionary *content = [NSMutableDictionary dictionary];
    __block NSMutableArray<NSString *> *propertys = [NSMutableArray array];
    [self.class enumerateIvarsWithBlock:^(HIvar *ivar, BOOL *stop) {
        if (ivar.isFoundation) {  //系统提供的类
            if (![ivar.propertyName isEqualToString:@"isa"]) {
                id value  = [this valueForKey:ivar.propertyName];
                if (value) {
                    if ([value isKindOfClass:[NSArray class]]) {
                        NSArray *array = value;
                        if (array.count==0) {
                            content[ivar.propertyName] = value;
                        }else{
                            content[ivar.propertyName]=[NSArray arrayByArray:array];
                        }
                    }else if([value isKindOfClass:[NSDictionary class]]){
                        if ([(NSDictionary *)value allKeys].count ==0) {
                            content[ivar.propertyName] = value;
                        }else{
                            content[ivar.propertyName] = [NSDictionary dictionaryByDictionary:value];
                        }
                        
                    }else{
                        [propertys addObject:ivar.propertyName];
                    }
                }
            }
        }else{//是继承 HKeyValueModel 的类对象
            HKeyValueModel *model = [this valueForKey:ivar.propertyName];
            if (model) {
                NSDictionary * dic = [model dictionary];
                content[ivar.propertyName] = dic;
            }
        }
    }];
    [content addEntriesFromDictionary:[self dictionaryWithValuesForKeys:propertys]];
    return  content;
}

+(void)GETdealDataByGetWithUrl:(NSString *)str   handle:(id (^)(NSDictionary *jsonDic,NSError *error))handle completeInMainThread:(void(^)(NSMutableArray * modelArray)) complete{
    NSURL *url=[NSURL URLWithString:str];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
         /**子线程*/
        if (!error) {
            NSDictionary *jsonDic=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            id  result = handle(jsonDic,nil);
            if (!complete) return ;
            if ([result isKindOfClass:[NSArray class]]) {
                NSMutableArray *models=[self modelsWithArray:(NSArray *)result];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    complete(models);
                });
            }else{
                id model=[self modelWithDictionary:result];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    complete([NSMutableArray arrayWithObject:model]);
                });
            }
        }else{
            handle(nil,error);
        }
    }];
    [task resume];
}
+(void)POSTdealDataByGetWithUrl:(NSString *)str  argumentDic:(NSDictionary *)argumentDic handle:(id (^)(NSDictionary *jsonDic,NSError *error))handle completeInMainThread:(void(^)(NSMutableArray *modelArray))complete{

    /**拼接请求提*/
    NSMutableString *body=[NSMutableString string];
    [argumentDic enumerateKeysAndObjectsUsingBlock:^(NSString * key,NSString *obj, BOOL * _Nonnull stop) {
        NSString *string;
        int num = (int)[argumentDic.allKeys  indexOfObject:key];
        if (num == argumentDic.allKeys.count-1) {
            string=[NSString stringWithFormat:@"%@=%@",key,obj];
        }else{
            string=[NSString stringWithFormat:@"%@=%@&",key,obj];
        }
        [body appendString:string];
    }];
     /**设置请求参数*/
    NSString *result = [body stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet controlCharacterSet]];
    NSData *data=[result dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url=[NSURL URLWithString:str];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setTimeoutInterval:20];
    [request setHTTPBody:data];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        /**子线程*/
        if (!error) {
            NSDictionary *jsonDic=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            id  result = handle(jsonDic,nil);
            if (!complete) return ;
            if ([result isKindOfClass:[NSArray class]]) {
                NSMutableArray *models=[self modelsWithArray:(NSArray *)result];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    complete(models);
                });
                
            }else{
                id model=[self modelWithDictionary:result];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    complete([NSMutableArray arrayWithObject:model]);
                });
            }
        }else{
            handle(nil,error);
        }
    }];
    [task resume];


}

/**dictionary值  转位HIvar类型 对应的值*/
-(NSObject *)valueFromValue:(NSObject *)value toClassIvar:(HIvar *)ivar  {
    NSObject *result;
    if([value isKindOfClass:[NSNumber class]]){
        /**NSNumber  ----->NSString */
        if ([ivar.type containsString:@"String"]) {
            result=[[NSMutableString alloc]initWithFormat:@"%@",value];
        }else{
            //i f d f b NSNumber-->
            result=value;
        }
    }else if ([value isKindOfClass:[NSString class]]){
        /**NSString NSMutableString  ------>NSURL  NSNumber NSMutableString*/
        if ([ivar.type containsString:NSStringFromClass([NSURL class])]) {
            result=[NSURL URLWithString:(NSString *)value];
        }else if([ivar.type containsString:@"String"]){
            result=[[NSMutableString alloc]initWithFormat:@"%@",value];
        }else{
            //d i f l B Number
            NSNumberFormatter *formatter=[[NSNumberFormatter alloc]init];
            NSString *str=(NSString *)value;
            result=[formatter numberFromString:str];
        }
    }else if ([value isKindOfClass:[NSArray class]]){
        /**模型数组*/
        if ([self respondsToSelector:@selector(classInArray)]) {
            Class clazz  =  self.classInArray[ivar.propertyName];
            if (clazz) result=[clazz modelsWithArray:(NSArray *)value];
        }
        if (!result) {
            result = value;
        }
    }else if([value isKindOfClass:[NSDictionary class]]){
        if(!ivar.isFoundation){
            if ([value isKindOfClass:[NSDictionary class]]) {
                result = [NSClassFromString(ivar.type) modelWithDictionary:(NSDictionary *)value];
            }
        }else{
            result = value;
        }
    }else{
           result = value;
    }
    return result;
}

+(void)enumerateIvarsWithBlock:(void(^)(HIvar *ivar,BOOL *stop))ivarBlock{
    [self enumerateClassWithBlock:^(__unsafe_unretained Class clazz, BOOL *stop) {
        unsigned int count;
        Ivar *ivars=class_copyIvarList(clazz, &count);
        for (int i=0; i<count; i++) {
            HIvar *ivar=[[HIvar alloc]initWithIvar:ivars[i]];
            ivarBlock(ivar,stop);
        }
    }];
}
+(void)enumerateClassWithBlock:(void(^)(Class clazz,BOOL *stop))classBlock{
    if (!classBlock) return;
    BOOL stop=NO;
    __unsafe_unretained Class currentClazz=[self class];
    while (!stop && currentClazz) {
        classBlock(currentClazz,&stop);
        currentClazz=class_getSuperclass(currentClazz);
    }
}
@end
@implementation NSArray (KHeyValue)
+(NSArray *)arrayByArray:(NSArray *)source{
    NSMutableArray *content = [NSMutableArray array];
    [source enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj isKindOfClass:[NSArray class]]){
            NSArray *temp = [NSArray arrayByArray:obj];
            [content addObject:temp];
        }else if([obj isKindOfClass:[NSDictionary class]]){
            NSDictionary *temp = [NSDictionary dictionaryByDictionary:obj];
            [content addObject:temp];
        }else if ([obj isKindOfClass:[HKeyValueModel class]]){
            NSDictionary *temp = [obj dictionary];
            [content addObject:temp];
        }else if([obj isKindOfClass:[NSURL class]]){
            [content addObject:[(NSURL *)obj absoluteString]];
        }else{
            [content addObject:obj];
        }
    }];
    return content;
}
@end
@implementation NSDictionary(KHeyValue)
+(NSDictionary *)dictionaryByDictionary:(NSDictionary *)source{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [source enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if([obj isKindOfClass:[NSArray class]]){
            NSArray *temp = [NSArray arrayByArray:obj];
            dic[key] = temp;
        }else if([obj isKindOfClass:[NSDictionary class]]){
            NSDictionary *temp = [NSDictionary dictionaryByDictionary:obj];
            dic[key]= temp;
        }else if ([obj isKindOfClass:[HKeyValueModel class]]){
            NSDictionary *temp = [obj dictionary];
            dic[key]= temp;
        }else if([obj isKindOfClass:[NSURL class]]){
            dic[key]=[(NSURL *)obj absoluteString];
        }else{
            dic[key]= obj;
        }
    }];
    return dic;
}
@end
