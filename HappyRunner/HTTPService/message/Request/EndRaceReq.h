//
//  EndRaceReq.h
//  HappyRunner
//
//  Created by chinatsp on 13-12-5.
//  Copyright (c) 2013年 chinatsp. All rights reserved.
//

#import "RequestMsg.h"

@interface EndRaceReq : RequestMsg

@property (nonatomic, assign) NSString *MATCH_ID;
@property (nonatomic, assign) NSString *DISTANCE;
@property (nonatomic, assign) NSString *CALORIE;
@property (nonatomic, assign) NSString *TIME_CONSUMING;
@property (nonatomic, assign) NSString *SPEED;

@end
