//
//  HToolView.h
//  HMenu
//
//  Created by ZZH   github userName:HLoveMe on 16/6/1.
//  Copyright © 2016年 HMenu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HStringExchange.h"
@class HToolView;
@class HLayout;
@protocol HToolViewDelegate<NSObject>
@optional
-(void)toolView:(HToolView *)toolView touchIndexContent:(id<HStringExchange>)indexCon;
@required
-(CGRect)toolViewAdjust:(HToolView *)toolView oldRect:(CGRect)rect;
@end
@interface HToolView : UIView
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

@property(nonatomic,strong)HLayout *layout;
@property(nonatomic,assign)CGPoint targetCenter;
@property(nonatomic,weak)id<HToolViewDelegate> delegate;
@end
