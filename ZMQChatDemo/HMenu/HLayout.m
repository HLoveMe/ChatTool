//
//  HLayout.m
//  HMenu
//
//  Created by ZZH   github userName:HLoveMe on 16/6/2.
//  Copyright © 2016年 HMenu. All rights reserved.
//
#define HScreenWidth   [UIScreen mainScreen].bounds.size.width
#import "HLayout.h"
#import "HStringExchange.h"
typedef  struct _Status{
    NSRange range;
    BOOL hasUp;
    BOOL hasDown;
}Status;
@interface HLayout(){
    NSMutableArray<NSValue *> *widths;
    NSRange range;
    NSMutableArray<NSValue *> *BeforeRanges;
    int beginIndex;
    BOOL hasUp;
    BOOL hasDown;
}
/**
 *  
 */
@property(nonatomic,strong)NSMutableArray<NSString *>*funDesc;
@end
@implementation HLayout
- (instancetype)init
{
    self = [super init];
    if (self) {
        _fontSize = 14;
        _insert = UIEdgeInsetsMake(70, 15, 0, 15);
        _minWidth=54;
        _upDownWitdh=35;
        _toolHeight=35;
        _toolPadding=12;
        _separatorLine=.5;
        hasUp=NO;
        hasDown=NO;
        widths = [NSMutableArray array];
        range = NSMakeRange(0, 0);
        beginIndex=0;
        BeforeRanges = [NSMutableArray array];
    }
    return self;
}

-(void)setFunDesc:(NSMutableArray *)funDesc{
    _funDesc = funDesc;
    [self updataSelf];
}
-(void)setFontSize:(CGFloat)fontSize{
    _fontSize=fontSize;
    [self updataSelf];
}
-(void)setInsert:(UIEdgeInsets)insert{
    _insert = insert;
    [self updataSelf];
}
-(NSMutableArray<NSValue *> *)widths{
    return widths;
}
-(CGFloat)width{
    NSValue *value = self.widths.lastObject;
    CGSize size = [value CGSizeValue];
    return size.width+size.height;
}
-(NSRange)currentRange{
    return range;
}
-(BOOL)hasDown{
    return hasDown;
}
-(BOOL)hasUp{
    return hasUp;
}

-(instancetype)updataSelf{
    [self initData];
    if (self.funDesc.count==0) {return self;}
    CGFloat width=0;
    int temp=0;
    for (int i=beginIndex; i<self.funDesc.count; i++) {
        temp=i;
        if (temp!=0&&temp==range.location+range.length){
            hasUp=YES;
            width+=_separatorLine+self.upDownWitdh;
            CGSize size = CGSizeMake(0, self.upDownWitdh);
            NSValue *value = [NSValue value:&size withObjCType:@encode(CGSize)];
            [widths addObject:value];
        }
        NSString *content = [(id<HStringExchange>)self.funDesc[i] toString];
        CGFloat wid = [self sizeWithContent:content];
        wid=wid>_minWidth?wid:_minWidth;
        width+=wid+_separatorLine;
        if (width>(HScreenWidth-_minWidth)) {
            hasDown=YES;
            CGSize size = CGSizeMake(width-wid-_separatorLine, self.upDownWitdh);
            NSValue *value = [NSValue value:&size withObjCType:@encode(CGSize)];
            [widths addObject:value];
            //加入下
            break;
        }else{
            CGSize size = CGSizeMake(width-wid-_separatorLine, wid);
            NSValue *value = [NSValue value:&size withObjCType:@encode(CGSize)];
            [widths addObject:value];
        }
        
    }
    range.location = beginIndex;
    range.length = self.widths.count-self.hasUp-self.hasDown;
    beginIndex=(int)(range.location+range.length);
    width--;
    return self;
}

-(instancetype)updataSelfFromHead{
    [self initData];
    range=NSMakeRange(0, 0);
    beginIndex=0;
    [self updataSelf];
    return self;
}
-(instancetype)updataSelfUp{
    [self initData];
    Status beforeStaus;
    NSValue *value = BeforeRanges.lastObject;
    [value getValue:&beforeStaus];
    [BeforeRanges removeLastObject];
    CGFloat width=0;
    if (beforeStaus.hasUp) {
        hasUp=YES;
        width+=_separatorLine+self.upDownWitdh;
        CGSize size = CGSizeMake(0, self.upDownWitdh);
        NSValue *value = [NSValue value:&size withObjCType:@encode(CGSize)];
        [widths addObject:value];
    }
    CGFloat wid =0;
    for (int i=0; i<beforeStaus.range.length; i++) {
        NSString *content = [(id<HStringExchange>)self.funDesc[i + beforeStaus.range.location] toString];
        wid = [self sizeWithContent:content];
        wid=wid>_minWidth?wid:_minWidth;
        CGSize size = CGSizeMake(width, wid);
        NSValue *value = [NSValue value:&size withObjCType:@encode(CGSize)];
        [widths addObject:value];
         width+=wid+_separatorLine;
    }
    if (beforeStaus.hasDown) {
        hasDown=YES;
        CGSize size = CGSizeMake(width, self.upDownWitdh);
        NSValue *value = [NSValue value:&size withObjCType:@encode(CGSize)];
        [widths addObject:value];
    }
    range=beforeStaus.range;
    beginIndex=(int)(range.location+range.length);
    return self;
}
-(instancetype)updataSelfDown{
    Status before;
    before.range=range;
    before.hasUp = hasUp;
    before.hasDown = hasDown;
    NSValue *value = [[NSValue alloc]initWithBytes:&before objCType:@encode(Status)];
    [BeforeRanges addObject:value];
    [self initData];
    [self updataSelf];
    return self;
}
-(void)initData{
    [widths removeAllObjects];
    hasUp=0;
    hasDown=0;
}
-(CGFloat)sizeWithContent:(NSString *)content{
    return  [content boundingRectWithSize:CGSizeMake(1000, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:self.fontSize]} context:nil].size.width+18;
}

@end
