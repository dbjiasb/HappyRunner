//
//  LoginResp.h
//  EarnMoney
//
//  Created by chinatsp on 13-9-28.
//  Copyright (c) 2013年 chinatsp. All rights reserved.
//

#import "ResponseMsg.h"

@interface LoginResp : ResponseMsg <FillFromDic>


@property (nonatomic, copy) NSString *USER_ID;
@property (nonatomic, copy) NSString *USER_NAME;
@property (nonatomic, copy) NSString *PASSWORD;
@property (nonatomic, copy) NSString *TOKEN;


- (void)fillFromeDictionary:(NSDictionary *)dic;

@end
