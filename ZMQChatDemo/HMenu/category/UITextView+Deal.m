//
//  UITextView+Deal.m
//  HMenu
//
//  Created by ZZH   github userName:HLoveMe on 16/6/1.
//  Copyright © 2016年 HMenu. All rights reserved.
//

#import "UITextView+Deal.h"

@implementation UITextView (Deal)
-(id)contentFromSelf{
    if (self.text) {
        return self.text;
    }else{
        return self.attributedText;
    }
}
@end
