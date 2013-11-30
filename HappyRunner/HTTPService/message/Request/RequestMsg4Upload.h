//
//  RequestMsg4Upload.h
//  JSONRPC_Test
//
//  Created by OuYiJian on 13-2-28.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "RequestMsg.h"

@interface RequestMsg4Upload : RequestMsg

@property (nonatomic, retain) NSMutableDictionary * paramsDic;
@property (nonatomic, retain) NSMutableDictionary * filesDic;

@end
