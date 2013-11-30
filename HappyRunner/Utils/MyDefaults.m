//
//  MyDefaults.m
//  HappyRunner
//
//  Created by chinatsp on 13-11-21.
//  Copyright (c) 2013年 chinatsp. All rights reserved.
//

#import "MyDefaults.h"

@implementation MyDefaults

+ (void)setToken:(NSString *)token
{
    if (!token) {
        return;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"Token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getToken
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"Token"];
}

@end
