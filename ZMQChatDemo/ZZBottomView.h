//
//  ZZBottomView.h
//  HMenu
//
//  Created by HMenu on 16/5/20.
//  Copyright © 2016年 HMenu. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 底部输入框视图
 */

@class ZZBottomView;

@protocol ZZBottomViewDelegate <NSObject>

@optional//可选

-(void)bottomView:(ZZBottomView *)bottomView send:(UIButton *)sendButton;

-(void)bottomView:(ZZBottomView *)bottomView willInput:(UITextView *)text transfrom:(CGAffineTransform)transfrom;

-(CGRect)bottomView:(ZZBottomView *)bottomView textChange:(UITextView *)text;

- (CGRect)bottomView:(ZZBottomView *)bottomView textChangeMax:(UITextView *)text;

@end


@interface ZZBottomView : UIView

@property(nonatomic,strong)UITextView *textView;

@property(nonatomic,strong)UIButton *sendButton;

@property(nonatomic,weak)id<ZZBottomViewDelegate> delegate;

@end
