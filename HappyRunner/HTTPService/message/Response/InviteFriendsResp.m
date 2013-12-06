//
//  InviteFriendsResp.m
//  HappyRunner
//
//  Created by chinatsp on 13-12-5.
//  Copyright (c) 2013年 chinatsp. All rights reserved.
//

#import "InviteFriendsResp.h"

@implementation InviteFriendsResp

- (void)fillFromeDictionary:(NSDictionary *)dic {
    
    if (ISNULL(dic))
        return;
    [super fillFromeDictionary:dic];
    
    if (self.PARAMS) {
        self.GROUP_ID = self.PARAMS[@"GROUP_ID"];
        self.USER_ID = self.PARAMS[@"USER_ID"];
        self.INVITE_FRIEND_IDS = self.PARAMS[@"INVITE_FRIEND_IDS"];
    }
    
}

@end
