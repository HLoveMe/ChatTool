//
//  HLayout.h
//  HMenu
//
//  Created by ZZH   github userName:HLoveMe on 16/6/2.
//  Copyright © 2016年 HMenu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HLayout : NSObject
/**
 *  左右箭头指示宽度 35
 */
@property(nonatomic,assign)CGFloat upDownWitdh;
//default 54
/**
 *  选项卡最小宽度
 */
@property(nonatomic,assign)CGFloat minWidth;

/**
 *  工具条的高度
 *
 *  @return default  35
 */
@property(nonatomic,assign)CGFloat toolHeight;

/**
 *  工具条与控制视图的距离 默认 10
 */
@property(nonatomic,assign)CGFloat toolPadding;
/**
 *  defaukt 14
 */
@property(nonatomic,assign)CGFloat fontSize;
/**
 *  工具条离上左下右最小的距离 default {70,15,0,15}
 */
@property(nonatomic,assign) UIEdgeInsets insert;
/**
 *  分割线的宽度  default:0.5px
 */
@property(nonatomic,assign)CGFloat separatorLine;

-(instancetype)updataSelf;
-(instancetype)updataSelfFromHead;
-(instancetype)updataSelfUp;

-(instancetype)updataSelfDown;
//size(起点x,width)
@property(nonatomic,readonly)NSMutableArray<NSValue *> *widths;
@property(nonatomic,readonly)CGFloat width;
@property(nonatomic,readonly)NSRange currentRange;
@property(nonatomic,assign,readonly)BOOL hasUp;
@property(nonatomic,assign,readonly)BOOL hasDown;
@end
