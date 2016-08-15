//
//  HToolView.m
//  HMenu
//
//  Created by ZZH   github userName:HLoveMe on 16/6/1.
//  Copyright © 2016年 HMenu. All rights reserved.
//

#import "HToolView.h"
#import "HLayout.h"
@interface HToolView(){
    NSMutableArray<UIButton *> *subViews;
    CAShapeLayer *shape;
}
@end
@implementation HToolView
- (instancetype)init
{
    self = [super init];
    if (self) {
        subViews = [NSMutableArray array];
        self.layer.cornerRadius=8;
        self.layer.masksToBounds=1;
        self.backColor = [UIColor blackColor];
        self.textColor = [UIColor whiteColor];
        shape = [[CAShapeLayer alloc]init];
    }
    return self;
}
-(void)setBackColor:(UIColor *)backColor{
    _backColor=backColor;
    [self setNeedsLayout];
}
-(void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    [self setNeedsLayout];
}
-(void)loadSubView{
    if (_layout.hasUp) {
        UIButton *one = [[UIButton alloc]init];
        one.tag = -1;
        [self addSubview:one];
        [subViews addObject:one];
        [one addTarget:self action:@selector(upLoadClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    for (int i=0; i<_layout.currentRange.length; i++) {
        
        UIButton *one = [[UIButton alloc]init];
        [self addSubview:one];
        [subViews addObject:one];
        [one addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (_layout.hasDown) {
        UIButton *one = [[UIButton alloc]init];
        one.tag = 1;
        [self addSubview:one];
        [subViews addObject:one];
        [one addTarget:self action:@selector(upLoadClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self loadSubView];
    
    [self.layout.widths enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = subViews[idx];
        CGSize size = [obj CGSizeValue];
        button.frame = CGRectMake(size.width, 0, size.height, self.frame.size.height);
        
        button.titleLabel.font = [UIFont systemFontOfSize:self.layout.fontSize];
        button.backgroundColor =self.backColor;
        [button setTitleColor:self.textColor forState:UIControlStateNormal];
        if (idx==0&&self.layout.hasUp) {
            [button setTitle:@"<" forState:UIControlStateNormal];
        }else if(idx==self.layout.widths.count-1&&self.layout.hasDown){
            [button setTitle:@">" forState:UIControlStateNormal];
        }else{
            int index = (int)(idx+self.layout.currentRange.location-self.layout.hasUp);
            NSMutableArray *array = [self.layout valueForKey:@"funDesc"];
            [button setTitle:[(id<HStringExchange>)array[index] toString] forState:UIControlStateNormal];
        }
    }];
    CGRect rect = self.frame;
    rect.size.width = self.layout.width;
    self.frame=rect;

    if ([self.delegate respondsToSelector:@selector(toolViewAdjust:oldRect:)]) {
        CGRect rect = [self.delegate toolViewAdjust:self oldRect:self.frame];
        self.frame=rect;
    }
    
    shape.fillColor = self.backColor.CGColor;
    CGFloat tempWidth=10;
    CGFloat y = CGRectGetMaxY(self.frame)-1;
    CGFloat x = self.targetCenter.x-tempWidth;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(x, y)];
    [path addLineToPoint:CGPointMake(x+2*tempWidth, y)];
    [path addLineToPoint:CGPointMake(x+tempWidth, y+tempWidth)];
    [path addLineToPoint:CGPointMake(x, y)];
    shape.path = path.CGPath;
    [[UIApplication sharedApplication].keyWindow.layer addSublayer:shape];
}


-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    BOOL isSelf = [super pointInside:point withEvent:event];
    if (!isSelf) {
        [self removeFromSuperview];
    }
    return isSelf;
}
-(void)clearData{
    [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [shape removeFromSuperlayer];
    [subViews removeAllObjects];
}
-(void)removeFromSuperview{
    [super removeFromSuperview];
    [self clearData];
}

#pragma -mark 按钮响应
-(void)upLoadClick:(UIButton*)clickButton{
    
    if (clickButton.tag==-1) {
        //上
        [self.layout updataSelfUp];
        [self clearData];
        [self setNeedsLayout];
    }
    if(clickButton.tag==1){
        //下
        [self.layout updataSelfDown];
        [self clearData];
        [self setNeedsLayout];
    }

}
-(void)buttonClick:(UIButton*)button{
    if ([self.delegate respondsToSelector:@selector(toolView:touchIndexContent:)]) {
        NSMutableArray *array = [self.layout valueForKey:@"funDesc"];
        int index= (int)(self.layout.currentRange.location+[subViews indexOfObject:button]-self.layout.hasUp);
        [self.delegate toolView:self touchIndexContent:array[index]];
        [self removeFromSuperview];
    }
}
@end
