//
//  ZZBottomView.m
//  HMenu
//
//  Created by HMenu on 16/5/20.
//  Copyright © 2016年 HMenu. All rights reserved.
//

#import "ZZBottomView.h"

//#import "NSString+Extension.h"


@interface ZZBottomView()<UITextViewDelegate>

//@property(nonatomic,assign)CGFloat textHeight;//文字高度

@property(nonatomic,assign)CGFloat singleHeight; //单行文字高度

@end

@implementation ZZBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    
    if (self) {
        
        [self _createSubView];
        
    }
    return self;
}


- (void)_createSubView{
    
    self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendButton.frame = CGRectMake(kScreenWidth - 60 , self.frame.size.height - 35 - (self.frame.size.height - 35)/2, 50, 35);
    self.sendButton.layer.cornerRadius = 5.0f;
    self.sendButton.layer.masksToBounds = YES;
    [self.sendButton setTitle:@"发送" forState:UIControlStateNormal];
    self.sendButton.enabled = NO; //默认不能响应事件
    self.sendButton.backgroundColor = ZMQColor(231, 231, 234);
    
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 4.5, kScreenWidth - 80, 35)];
    self.textView.font = [UIFont systemFontOfSize:14];
    self.textView.layer.cornerRadius = 5.0f;
    self.textView.layer.masksToBounds = YES;
    self.textView.layer.borderWidth = 0.8f;
    self.textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.textView.delegate = self;
    
    [self addSubview:self.sendButton];
    [self addSubview:self.textView];

    
    //发送按钮响应方法
    [self.sendButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //监听键盘的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}


-(void)buttonClick:(UIButton *)button{
    
    
    if ([self.delegate respondsToSelector:@selector(bottomView:send:)]) {
        
        [self.delegate bottomView:self send:self.sendButton];
    }
}


-(void)keyBoardChange:(NSNotification *)notification{
    
    CGRect rect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat changeWid = rect.origin.y - [UIScreen mainScreen].bounds.size.height;
    
    if ([self.delegate respondsToSelector:@selector(bottomView:willInput:transfrom:)]) {
        
        [self.delegate bottomView:self willInput:self.textView transfrom:CGAffineTransformMakeTranslation(0, changeWid)];
    }
    
}

#pragma mark -- UITextViewDelegate 代理方法
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ((textView.text.length + text.length - range.length) > 140) {
    
        //弹框提示（字数不能超过140）

        return NO;
    }
    
    //（单行）
    NSString *s = @"这个都是随便写了,呵呵哒！";
    self.singleHeight = [s sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14.0],NSFontAttributeName, nil]].height;
    
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    CGFloat textHeight = [comcatstr boundingRectWithSize:CGSizeMake(kScreenWidth  - 140, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil].size.height;

    if (textHeight  <= self.singleHeight * 4 ) {
        
        if ([self.delegate respondsToSelector:@selector(bottomView:textChange:)]) {
            
            CGRect newRect = [self.delegate bottomView:self textChange:self.textView];
            
            self.frame = newRect;
            
            CGRect textOldRect = self.textView.frame;
            
            CGRect textRect = CGRectMake(textOldRect.origin.x,textOldRect.origin.y,textOldRect.size.width, newRect.size.height-2*textOldRect.origin.y);
            
            self.textView.frame = textRect;
            
            self.sendButton.frame = CGRectMake(kScreenWidth - 60, CGRectGetMaxY(self.textView.frame) -35 , 50,35);
        }
        
    }else{
    
        if ([self.delegate respondsToSelector:@selector(bottomView:textChangeMax:)]) {
            
            CGRect newRect = [self.delegate bottomView:self textChangeMax:self.textView];
            
            self.frame = newRect;
            
            CGRect textOldRect = self.textView.frame;
            
            CGRect textRect = CGRectMake(textOldRect.origin.x,textOldRect.origin.y,textOldRect.size.width, newRect.size.height-2*textOldRect.origin.y);
            
            self.textView.frame = textRect;
            
            self.sendButton.frame = CGRectMake(kScreenWidth - 60, CGRectGetMaxY(self.textView.frame) -35 , 50,35);
        }

//        NSLog(@"---------textView的Frame不改变---------");
    }
    
    return YES;
}


- (void)textViewDidChange:(UITextView *)textView{
    
    if ([textView.text length] == 0) {
        
        self.sendButton.enabled = NO;
        self.sendButton.backgroundColor = ZMQColor(231, 231, 234);
        
    }else{
        
        self.sendButton.enabled = YES;
        self.sendButton.backgroundColor = ZMQColor(126, 211, 248);
    }
    
}

////////////////////////////////////////////////////////////////////////////////////////////////
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
