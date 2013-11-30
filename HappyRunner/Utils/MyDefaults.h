//
//  MyDefaults.h
//  HappyRunner
//
//  Created by chinatsp on 13-11-21.
//  Copyright (c) 2013年 chinatsp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyDefaults : EAGLContext

+ (void)setToken:(NSString *)token;
+ (NSString *)getToken;

@end
