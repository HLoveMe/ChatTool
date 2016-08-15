//
//  ZZModel.m
//  HMenu
//
//  Created by HMenu on 16/5/18.
//  Copyright © 2016年 HMenu. All rights reserved.
//

#import "ZZModel.h"

@implementation ZZModel

//重写setter
- (void)setUser_id:(NSString *)user_id{
    
    
//    [NSString getTimeStamp];
//    [NSURL getTimeStamp];
//    [ZZModel getTimeStamp];
    
    
    _user_id = [user_id copy];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    
    if ([_user_id isEqualToString:[defaults objectForKey:@"user_id"]]) {
        
        _ismySelf = YES;
        
    }else{
        
        _ismySelf = NO;
    }
}


@end
