//
//  LoginReq.h
//  EarnMoney
//
//  Created by chinatsp on 13-9-27.
//  Copyright (c) 2013年 chinatsp. All rights reserved.
//

#import "RequestMsg.h"

@interface LoginReq : RequestMsg

@property (nonatomic, copy) NSString *USER_NAME;
@property (nonatomic, copy) NSString *PASSWORD;

- (NSDictionary *)dictionary;

@end
