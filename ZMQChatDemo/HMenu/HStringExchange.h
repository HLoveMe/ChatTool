//
//  HStringExchange.h
//  HMenu
//
//  Created by ZZH   github userName:HLoveMe on 16/6/6.
//  Copyright © 2016年 HMenu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HStringExchange<NSObject>
/**
 *  对于展示的工具按钮 只需要有对于的文本就可以显示
 *  在给工具条传递显示对象时，对象只需要实现HStringExchange 就可以显示 NSString默认实现该方法
 *  @return 标题文本
 */
-(NSString*)toString;
@end
