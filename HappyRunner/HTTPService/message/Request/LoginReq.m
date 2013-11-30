//
//  LoginReq.m
//  EarnMoney
//
//  Created by chinatsp on 13-9-27.
//  Copyright (c) 2013年 chinatsp. All rights reserved.
//

#import "LoginReq.h"

@implementation LoginReq

- (id)init
{
    if (self = [super init]) {
        
        self.SERVICE = @"userLogin";
    }
    
    return self;
}

- (NSDictionary *)dictionary
{
    if (self.PASSWORD) {
        self.PASSWORD = [self.PASSWORD md5String];
    }
    
    NSMutableDictionary * ret = [[NSMutableDictionary alloc] init] ;
    
    [ret addEntriesFromDictionary:[self dictionaryWithValuesForKeys:[NSArray arrayWithObjects:@"USER_NAME",@"PASSWORD", nil]]];
    
    self.ROW_PARAMS = ret;
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:[super dictionary]];
    
    [dic setObject:self.ROW_PARAMS forKey:@"ROW:PARAMS"];
    
    return dic ;
    
}

- (Class) responseMsgClass {
    
    
    return LoginResp.class;
}


@end
