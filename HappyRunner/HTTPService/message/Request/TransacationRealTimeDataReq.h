//
//  TransacationRealTimeDataReq.h
//  HappyRunner
//
//  Created by chinatsp on 13-12-5.
//  Copyright (c) 2013年 chinatsp. All rights reserved.
//

#import "RequestMsg.h"

//实时数据传输
@interface TransacationRealTimeDataReq : RequestMsg

@property (nonatomic, assign) NSString *MATCH_ID;
@property (nonatomic, assign) NSString *DISTANCE;
@property (nonatomic, assign) NSString *CALORIE;
@property (nonatomic, assign) NSString *TIME_CONSUMING;
@property (nonatomic, assign) NSString *SPEED;
@property (nonatomic, assign) NSString *NICK_NAME;
@property (nonatomic, assign) NSString *USER_ID;
@end
