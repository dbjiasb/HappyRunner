//
//  InviteFriendsReq.m
//  HappyRunner
//
//  Created by chinatsp on 13-12-5.
//  Copyright (c) 2013年 chinatsp. All rights reserved.
//

#import "InviteFriendsReq.h"

@implementation InviteFriendsReq

- (id)init
{
    if (self = [super init]) {
        
        self.TOKEN = [MyDefaults getToken];
        self.USER_ID = [MyDefaults getUserID];
        
        self.SERVICE = @"inviteFriends";
    }
    
    return self;
}

- (NSDictionary *)dictionary
{
    
    NSMutableDictionary * ret = [[NSMutableDictionary alloc] init] ;
    
    [ret addEntriesFromDictionary:[self dictionaryWithValuesForKeys:[NSArray arrayWithObjects:@"INVITE_FRIEND_IDS",@"USER_ID", nil]]];
    
    self.ROW_PARAMS = ret;
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:[super dictionary]];
    
    [dic setObject:self.ROW_PARAMS forKey:@"ROW:PARAMS"];
    
    return dic ;
    
}

- (Class) responseMsgClass {
    
    
    return InviteFriendsResp.class;
}

@end
