//
//  StartRaceReq.h
//  HappyRunner
//
//  Created by chinatsp on 13-12-5.
//  Copyright (c) 2013年 chinatsp. All rights reserved.
//

#import "RequestMsg.h"

@interface StartRaceReq : RequestMsg

@property (nonatomic, copy) NSString *GROUP_ID;
@property (nonatomic, copy) NSString *USER_ID;


@end
