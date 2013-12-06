//
//  StartRaceResp.h
//  HappyRunner
//
//  Created by chinatsp on 13-12-5.
//  Copyright (c) 2013年 chinatsp. All rights reserved.
//

#import "ResponseMsg.h"

@interface StartRaceResp : ResponseMsg

@property (nonatomic, copy) NSString *MATCH_ID;
@property (nonatomic, copy) NSString *GROUP_ID;
@property (nonatomic, copy) NSString *USER_ID;

@end
