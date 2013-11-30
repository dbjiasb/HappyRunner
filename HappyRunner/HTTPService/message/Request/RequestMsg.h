//
//  RequestMsg.h
//  JSONRPC_Test
//
//  Created by OuYiJian on 13-2-20.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RequestMsgBasic <NSObject, ObjectToDic>

@required

- (Class) responseMsgClass;

@end



@interface RequestMsg : NSObject <RequestMsgBasic>

@property (nonatomic, retain) NSDictionary *ROW_PARAMS;

@property (nonatomic, copy) NSString *SERVICE_TYPE;
@property (nonatomic,copy) NSString *SERVICE;
@property (nonatomic, copy) NSString *TOKEN;
@property (nonatomic, assign) Class responseMsgClass;
//@property (nonatomic, copy)   NSString *method;

+ (id)shareInstance;

@end
