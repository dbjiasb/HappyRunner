//
//  FeedbackForFriendReq.h
//  HappyRunner
//
//  Created by chinatsp on 13-12-5.
//  Copyright (c) 2013年 chinatsp. All rights reserved.
//

#import "RequestMsg.h"

@interface FeedbackForFriendReq : RequestMsg

@property (nonatomic, copy) NSString *GROUP_ID;
@property (nonatomic, copy) NSString *USER_ID;
@property (nonatomic, copy) NSString *VERIFIED; //0 拒绝 1接受
@property (nonatomic, copy) NSString *TO_USER_ID;


@end
