//
//  TransacationRealTimeDataReq.m
//  HappyRunner
//
//  Created by chinatsp on 13-12-5.
//  Copyright (c) 2013年 chinatsp. All rights reserved.
//

#import "TransacationRealTimeDataReq.h"

@implementation TransacationRealTimeDataReq

- (id)init
{
    if (self = [super init]) {
        
        self.SERVICE = @"transacationRealTimeData";
        
    }
    
    return self;
}

- (NSDictionary *)dictionary
{
    
    NSMutableDictionary * ret = [[NSMutableDictionary alloc] init] ;
    
    [ret addEntriesFromDictionary:[self dictionaryWithValuesForKeys:[NSArray arrayWithObjects:@"USER_ID",@"MATCH_ID",@"DISTANCE",@"CALORIE",@"TIME_CONSUMING",@"SPEED",@"NICK_NAME", nil]]];
    
    self.ROW_PARAMS = ret;
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:[super dictionary]];
    
    [dic setObject:self.ROW_PARAMS forKey:@"ROW:PARAMS"];
    
    return dic ;
    
}

- (Class) responseMsgClass {
    

    return TransacationRealTimeDataResp.class;
}



@end
