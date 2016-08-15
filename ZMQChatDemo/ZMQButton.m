//
//  ZMQButton.m
//  HMenu
//
//  Created by HMenu on 16/5/26.
//  Copyright © 2016年 HMenu. All rights reserved.
//
#import "ZMQButton.h"
#import "HMenuController.h"
@implementation ZMQButton

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
    
        [self setup];
    }

    return self;
}

- (void)setup{
    //长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressButton:)];
    longPress.minimumPressDuration = 0.8;
    
    [self addGestureRecognizer:longPress];
    
}

- (void)longPressButton:(UILongPressGestureRecognizer*)longP{
    if (longP.state==UIGestureRecognizerStateBegan) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"longPressButton" object:self];
    }
    
}

@end
