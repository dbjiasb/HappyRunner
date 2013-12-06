//
//  KnowledgeResp.m
//  HappyRunner
//
//  Created by chinatsp on 13-12-1.
//  Copyright (c) 2013年 chinatsp. All rights reserved.
//

#import "KnowledgeResp.h"

@implementation KnowledgeResp

- (void)fillFromeDictionary:(NSDictionary *)dic {
    
    if (ISNULL(dic))
        return;
    [super fillFromeDictionary:dic];
    
    self.KNOWLEDGES = [dic objectForKey:@"DATASET:KNOWLEDGES"];
    
}

@end
