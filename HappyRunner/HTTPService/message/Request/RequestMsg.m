//
//  RequestMsg.m
//  JSONRPC_Test
//
//  Created by OuYiJian on 13-2-20.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "RequestMsg.h"
#import "ResponseMsg.h"
#import "Model_Delegate.h"


@implementation RequestMsg

@synthesize responseMsgClass;

- (id)init
{
    if (self = [super init]) {
        
//        self.ROW_PARAMS = @"";
        self.SERVICE_TYPE = @"0";
        self.SERVICE = @"";
        self.TOKEN = @"";
    }
    
    return self;
}

+ (id)shareInstance
{
    static dispatch_once_t pred;
    static RequestMsg *_requestMsg = nil;
    dispatch_once(&pred, ^{
        _requestMsg = [[RequestMsg alloc] init];
    });
    return _requestMsg;
}

- (NSDictionary*) dictionary
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic addEntriesFromDictionary:[self dictionaryWithValuesForKeys:@[@"SERVICE_TYPE",@"SERVICE"/*,@"TOKEN"*/]]];
    
    return dic;
}

- (Class) responseMsgClass {
    
    if (responseMsgClass)
        return responseMsgClass;
    
    return ResponseMsg.class;
}

@end
