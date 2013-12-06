//
//  RunningResultsReq.m
//  HappyRunner
//
//  Created by chinatsp on 13-12-5.
//  Copyright (c) 2013年 chinatsp. All rights reserved.
//

#import "RunningResultsReq.h"

@implementation RunningResultsReq

- (id)init
{
    if (self = [super init]) {
        
        self.SERVICE = @"queryRunningResults";

    }
    
    return self;
}

- (NSDictionary *)dictionary
{
    
    NSMutableDictionary * ret = [[NSMutableDictionary alloc] init] ;
    
    [ret addEntriesFromDictionary:[self dictionaryWithValuesForKeys:[NSArray arrayWithObjects:@"GROUP_ID",@"USER_ID",@"MATCH_ID",@"PAGE", nil]]];
    
    [ret setObject:@(self.page_size) forKey:@"PAGE_SIZE"];
    self.ROW_PARAMS = ret;
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:[super dictionary]];
    
    [dic setObject:self.ROW_PARAMS forKey:@"ROW:PARAMS"];
    
    return dic ;
    
}

- (Class) responseMsgClass {
    
    
    return RunningResultsResp.class;
}



@end
