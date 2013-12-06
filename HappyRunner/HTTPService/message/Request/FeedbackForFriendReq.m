//
//  FeedbackForFriendReq.m
//  HappyRunner
//
//  Created by chinatsp on 13-12-5.
//  Copyright (c) 2013年 chinatsp. All rights reserved.
//

#import "FeedbackForFriendReq.h"

@implementation FeedbackForFriendReq

- (id)init
{
    if (self = [super init]) {
        
        self.SERVICE = @"feedbackForFriend";
        self.VERIFIED = @"1";
    }
    
    return self;
}

- (NSDictionary *)dictionary
{
    
    NSMutableDictionary * ret = [[NSMutableDictionary alloc] init] ;
    
    [ret addEntriesFromDictionary:[self dictionaryWithValuesForKeys:[NSArray arrayWithObjects:@"GROUP_ID",@"USER_ID",@"TO_USER_ID",@"VERIFIED", nil]]];
    
    self.ROW_PARAMS = ret;
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:[super dictionary]];
    
    [dic setObject:self.ROW_PARAMS forKey:@"ROW:PARAMS"];
    
    return dic ;
    
}

- (Class) responseMsgClass {
    
    
    return FeedbackForFriendResp.class;
}


@end
