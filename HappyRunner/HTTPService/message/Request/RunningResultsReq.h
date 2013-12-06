//
//  RunningResultsReq.h
//  HappyRunner
//
//  Created by chinatsp on 13-12-5.
//  Copyright (c) 2013年 chinatsp. All rights reserved.
//

#import "RequestMsg.h"

@interface RunningResultsReq : RequestMsg

@property (nonatomic, copy) NSString *MATCH_ID; //查询个人跑步记录时MATCH_ID为0，查询比赛记录时需传MATCH_ID
@property (nonatomic, copy) NSString *USER_ID;

@property (nonatomic, assign) NSInteger page_size;
@property (nonatomic, assign) NSInteger PAGE;

@end
