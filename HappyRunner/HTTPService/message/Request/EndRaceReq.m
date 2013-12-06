//
//  EndRaceReq.m
//  HappyRunner
//
//  Created by chinatsp on 13-12-5.
//  Copyright (c) 2013年 chinatsp. All rights reserved.
//

#import "EndRaceReq.h"

@implementation EndRaceReq

- (id)init
{
    if (self = [super init]) {
        
        self.SERVICE = @"endRace";
        
    }
    
    return self;
}

- (NSDictionary *)dictionary
{
    
    NSMutableDictionary * ret = [[NSMutableDictionary alloc] init] ;
    
    [ret addEntriesFromDictionary:[self dictionaryWithValuesForKeys:[NSArray arrayWithObjects:@"GROUP_ID",@"USER_ID",@"MATCH_ID",@"DISTANCE",@"CALORIE",@"TIME_CONSUMING",@"SPEED", nil]]];
    
    self.ROW_PARAMS = ret;
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:[super dictionary]];
    
    [dic setObject:self.ROW_PARAMS forKey:@"ROW:PARAMS"];
    
    return dic ;
    
}

- (Class) responseMsgClass {
    
    
    return RunningResultsResp.class;
}



@end
