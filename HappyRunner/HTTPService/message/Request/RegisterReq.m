//
//  RegisterReq.m
//  HappyRunner
//
//  Created by chinatsp on 13-11-8.
//  Copyright (c) 2013年 chinatsp. All rights reserved.
//

#import "RegisterReq.h"

@implementation RegisterReq

- (id)init
{
    if (self = [super init]) {
        self.TOKEN = @"";
        self.EMAIL = @"123@126.COM";
        self.MOBILE_TELEPHONE = @"";
        self.GENDER  = @"M";
        self.VIRTUAL_CHARACTERS = @"";
        self.SERVICE = @"userRegister";
    }
    
    return self;
}


- (NSDictionary *)dictionary
{
    if (self.PASSWORD) {
        self.PASSWORD = [self.PASSWORD md5String];
    }
    
    NSMutableDictionary * ret = [[NSMutableDictionary alloc] init] ;

    [ret addEntriesFromDictionary:[self dictionaryWithValuesForKeys:[NSArray arrayWithObjects:@"USER_NAME",@"PASSWORD",@"NICK_NAME",@"TOKEN",@"EMAIL",@"MOBILE_TELEPHONE",@"GENDER",@"VIRTUAL_CHARACTERS", nil]]];

    self.ROW_PARAMS = ret;
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:[super dictionary]];
    
    [dic setObject:self.ROW_PARAMS forKey:@"ROW:PARAMS"];

    return dic ;
    
}

- (Class) responseMsgClass {
    
    return RegisterResp.class;
}


@end
