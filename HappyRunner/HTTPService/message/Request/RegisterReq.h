//
//  RegisterReq.h
//  HappyRunner
//
//  Created by chinatsp on 13-11-8.
//  Copyright (c) 2013年 chinatsp. All rights reserved.
//

#import "RequestMsg.h"

@interface RegisterReq : RequestMsg

@property (nonatomic, copy) NSString *USER_NAME;
@property (nonatomic, copy) NSString *PASSWORD;
@property (nonatomic, copy) NSString *NICK_NAME;

@property (nonatomic, copy) NSString *GENDER;
@property (nonatomic, copy) NSString *EMAIL;
@property (nonatomic, copy) NSString *VIRTUAL_CHARACTERS;
@property (nonatomic, copy) NSString *MOBILE_TELEPHONE;

@end
