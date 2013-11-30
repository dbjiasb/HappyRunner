//
//  RequestMsg4Upload.m
//  JSONRPC_Test
//
//  Created by OuYiJian on 13-2-28.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "RequestMsg4Upload.h"
#import "ResponseMsg4Upload.h"

@implementation RequestMsg4Upload

@synthesize paramsDic;
@synthesize filesDic;

- (id) init {
    
    if (self = [super init]) {
        paramsDic = [[NSMutableDictionary alloc] initWithCapacity:5];
        filesDic = [[NSMutableDictionary alloc] initWithCapacity:2];
    }
    
    return self;
}

- (void) dealloc
{

}

- (Class) responseMsgClass {
    return ResponseMsg4Upload.class;
}

@end
