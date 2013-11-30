//
//  LoginResp.m
//  EarnMoney
//
//  Created by chinatsp on 13-9-28.
//  Copyright (c) 2013年 chinatsp. All rights reserved.
//

#import "LoginResp.h"

@implementation LoginResp

- (void)fillFromeDictionary:(NSDictionary *)dic {
    
    if (ISNULL(dic))
        return;
    [super fillFromeDictionary:dic];
    
    
    if (self.PARAMS)
    {
        self.USER_ID = [self.PARAMS objectForKey:@"USER_ID"];
        self.USER_NAME = [self.PARAMS objectForKey:@"USER_NAME"];
        self.PASSWORD = [self.PARAMS objectForKey:@"PASSWORD"];
        self.TOKEN = [self.PARAMS objectForKey:@"TOKEN"];

    }

}

@end
