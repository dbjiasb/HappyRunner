//
//  KnowledgeReq.m
//  HappyRunner
//
//  Created by chinatsp on 13-12-1.
//  Copyright (c) 2013年 chinatsp. All rights reserved.
//

#import "KnowledgeReq.h"

@implementation KnowledgeReq

- (id)init
{
    if (self = [super init]) {
        
        self.TOKEN = [MyDefaults getToken];
        self.USER_ID = [MyDefaults getUserID];
        
        self.SERVICE = @"queryKnowledge";
    }
    
    return self;
}

- (NSDictionary *)dictionary
{
    
    NSMutableDictionary * ret = [[NSMutableDictionary alloc] init] ;
    
    [ret addEntriesFromDictionary:[self dictionaryWithValuesForKeys:[NSArray arrayWithObjects:@"USER_ID",@"TOKEN", nil]]];
    
    self.ROW_PARAMS = ret;
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:[super dictionary]];
    
    [dic setObject:self.ROW_PARAMS forKey:@"ROW:PARAMS"];
    
    return dic ;
    
}

- (Class) responseMsgClass {
    
    
    return LoginResp.class;
}


@end
