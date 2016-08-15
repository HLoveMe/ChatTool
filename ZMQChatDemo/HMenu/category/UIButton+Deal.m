//
//  UIButton+Deal.m
//  HMenu
//
//  Created by ZZH   github userName:HLoveMe on 16/6/1.
//  Copyright © 2016年 HMenu. All rights reserved.
//

#import "UIButton+Deal.h"

@implementation UIButton (Deal)
-(id)contentFromSelf{
    NSString *text = self.titleLabel.text;
    UIImage *image = self.currentImage;
    UIImage *backImage = self.currentBackgroundImage;
    NSMutableDictionary *content = [NSMutableDictionary dictionary];
    if (text) {
        content[@"text"] = text;
    }
    if (image) {
        content[@"image"] = image;
    }
    if (backImage) {
        content[@"backImage"] = backImage;
    }
    return content;
}

@end
