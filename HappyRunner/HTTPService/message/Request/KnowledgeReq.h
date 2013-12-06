//
//  KnowledgeReq.h
//  HappyRunner
//
//  Created by chinatsp on 13-12-1.
//  Copyright (c) 2013年 chinatsp. All rights reserved.
//

#import "RequestMsg.h"

@interface KnowledgeReq : RequestMsg

@property (nonatomic, copy) NSString *USER_ID;
@property (nonatomic, copy) NSString *TOKEN;
@property (nonatomic, copy) NSString *USER_NAME;
@property (nonatomic, assign) NSInteger PAGE;
@property (nonatomic, assign) NSInteger page_size;
- (NSDictionary *)dictionary;

@end
