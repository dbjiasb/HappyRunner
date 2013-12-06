//
//  InviteFriendsReq.h
//  HappyRunner
//
//  Created by chinatsp on 13-12-5.
//  Copyright (c) 2013年 chinatsp. All rights reserved.
//

#import "RequestMsg.h"

@interface InviteFriendsReq : RequestMsg

@property (nonatomic, copy) NSString *USER_ID;
@property (nonatomic, copy) NSString *INVITE_FRIEND_IDS;

@end
