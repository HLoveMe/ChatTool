//
//  HMenuController.m
//  HMenu
//
//  Created by ZZH   github userName:HLoveMe on 16/5/31.
//  Copyright © 2016年 HMenu. All rights reserved.
//

#import "HMenuController.h"
#import "HToolView.h"
#import "HLayout.h"

#define HScreenWidth   [UIScreen mainScreen].bounds.size.width
@interface HMenuController()<HToolViewDelegate>{
    NSUInteger funCount;
    NSMutableArray *funDesc;
    UIView *target;
    HLayout *_layout;
}
@property(nonatomic,strong)HToolView *tools;

@end
@implementation HMenuController
-(UIView *)tools{
    if (_tools==nil) {
        _tools= [[HToolView alloc]init];
        _tools.delegate=self;
        _tools.backgroundColor = [UIColor clearColor];
    }
    return _tools;
}
-(instancetype)init{
    BOOL flag = NO;
    NSAssert(flag, @"使用initMenuControllerWithLayout初始化");
    return nil;
}
+(instancetype)menuControllerByDefaultLayout{
    HMenuController*menu = [[HMenuController alloc]initMenuControllerWithLayout:[[HLayout alloc]init]];
    menu->_layout=[[HLayout alloc]init];
    menu->funCount=1;
    menu->funDesc = [NSMutableArray array];
    menu.backColor = [UIColor blackColor];
    menu.textColor = [UIColor whiteColor];
    menu.tools.layout=menu->_layout;
    return menu;
}
-(instancetype)initMenuControllerWithLayout:(HLayout *)layout{
    if (self = [super init]) {
        _layout=layout;
        funCount=1;
        funDesc = [NSMutableArray array];
        self.backColor = [UIColor blackColor];
        self.textColor = [UIColor whiteColor];
        self.tools.layout=layout;
    }
    return self;
}
+(instancetype)menuController{
    return [[HMenuController alloc]init];
}
-(void)setTextColor:(UIColor *)textColor{
    _textColor=textColor;
    self.tools.textColor=textColor;
}
-(void)setBackColor:(UIColor *)backColor{
    _backColor = backColor;
    self.tools.backColor = backColor;
}

-(void)showMenuToolWithTarget:(UIView*)view{
    if ([self.dataSource respondsToSelector:@selector(menuController:withTarget:)]) {
        [_layout setValue:[self.dataSource menuController:self withTarget:view] forKey:@"funDesc"];
    }else{
        NSAssert(NO, @"实现dataSource 代理方法");
    }
    UIApplication *application = [UIApplication sharedApplication];
    target=view;
    CGRect targetRect = [view convertRect:view.bounds toView:application.keyWindow];
    CGRect rect = CGRectMake(targetRect.origin.x, targetRect.origin.y-_layout.toolHeight-_layout.toolPadding, targetRect.size.width, _layout.toolHeight);
    self.tools.frame=rect;
    self.tools.targetCenter =  CGPointMake(rect.origin.x+rect.size.width/2, 0);
    [self.tools.layout updataSelfFromHead];
    [application.keyWindow addSubview:self.tools];
}
#pragma -mark
-(void)toolView:(HToolView *)toolView touchIndexContent:(id<HStringExchange>)indexCon{
    if ([self.delegate respondsToSelector:@selector(menuController:didSelectedIndex:content:)]) {
        [self.delegate menuController:self didSelectedIndex:indexCon content:[target contentFromSelf]];
    }
}
-(CGRect)toolViewAdjust:(HToolView *)toolView oldRect:(CGRect)rect{
    rect.origin.x = target.center.x - rect.size.width/2;
    
    if (rect.origin.x+rect.size.width>(HScreenWidth-_layout.insert.right)){
        CGFloat temp = (rect.origin.x+rect.size.width)-(HScreenWidth-_layout.insert.right);
        rect.origin.x-=temp;
    }
    if (rect.origin.x<20) {
        rect.origin.x=20;
    }
    if(rect.origin.y<=_layout.insert.top){
        rect.origin.y = _layout.insert.top;
    }
    return rect;
}
@end
