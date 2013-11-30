//
//  ResponseMsg.h
//  JSONRPC_Test
//
//  Created by OuYiJian on 13-2-20.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model_Delegate.h"

@interface ResponseMsg : NSObject <FillFromDic>


@property (nonatomic, copy) NSNumber * code;

@property (nonatomic, copy) NSString * message;

@property (nonatomic, copy) NSString * retValue;

@property (nonatomic, retain) NSDictionary *PARAMS;

@end
