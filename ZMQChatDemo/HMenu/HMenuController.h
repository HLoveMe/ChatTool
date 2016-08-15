//
//  HMenuController.h
//  HMenu
//
//  Created by ZZH   github userName:HLoveMe on 16/5/31.
//  Copyright © 2016年 HMenu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HStringExchange.h"
#import "HLayout.h"
#import "Deal_Header.h"

@class HMenuController;
@protocol HMenuDataSource<NSObject>
@required
/**
 *  得到工具栏对于的标题信息
 *
 *  @param menu
 *  @param view
 *
 *  @return 实现了HStringExchange协议的对象  NSString 默认已经实现
 */
-(NSMutableArray<id<HStringExchange>> *)menuController:(HMenuController *)menu withTarget:(UIView *)view;
@end

@protocol HMenuDelegate<NSObject>
@optional
//点击默认选项按钮返回
/**
 *  点击按钮回调
 *
 *  @param menu         menu
 *  @param indexContent menController:withtarget 得到的对象
 *  @param content      你可能想从点击视图中 得到的信息 NSString/UIImage/NSDictionary
 */
-(void)menuController:(HMenuController *)menu didSelectedIndex:(id<HStringExchange>)indexContent content:(id)content;
@end

@interface HMenuController : NSObject
@property(nonatomic,weak)id<HMenuDelegate> delegate;
@property(nonatomic,weak)id<HMenuDataSource> dataSource;
/**
 *  工具条的背景颜色
 *
 *  @return 默认为黑色
 */
@property(nonatomic,strong)UIColor *backColor;
/**
 *  工具条文字颜色
 *
 *  @return 默认为白色
 */
@property(nonatomic,strong)UIColor *textColor;
/**
 *  进行布局时需要HLayout，请使用menuControllerByDefaultLayout,initMenuControllerWithLayout:初始化
 *
 *  @param layout
 *
 *  @return 
 */
+(instancetype)menuControllerByDefaultLayout;
-(instancetype)initMenuControllerWithLayout:(HLayout *)layout;
/**
 *  显示工具栏
 *
 *  @param view 指示的View对象
 */
-(void)showMenuToolWithTarget:(UIView*)view;
@end
