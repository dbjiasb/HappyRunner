//
//  ResponseMsg.m
//  JSONRPC_Test
//
//  Created by OuYiJian on 13-2-20.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "ResponseMsg.h"

@implementation ResponseMsg


@synthesize code;

@synthesize message;

@synthesize retValue;

- (void) fillFromeDictionary:(NSDictionary*)dic
{
    self.code = [dic valueForKey:@"CODE"];
    self.message = [dic valueForKey:@"MSG"];
    self.retValue = [dic valueForKey:@"retValue"];
    self.PARAMS = [dic valueForKey:@"ROW:PARAMS"];
}

@end
