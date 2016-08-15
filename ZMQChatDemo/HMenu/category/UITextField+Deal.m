//
//  UITextField+Deal.m
//  HMenu
//
//  Created by ZZH   github userName:HLoveMe on 16/6/1.
//  Copyright © 2016年 HMenu. All rights reserved.
//

#import "UITextField+Deal.h"

@implementation UITextField (Deal)
-(id)contentFromSelf{
    if (self.text) {
        return self.text;
    }else{
        return self.attributedText;
    }
}
@end
