//
//  DHServiceInvocation.h
//  HotelManager
//
//  Created by Dragon Huang on 13-5-19.
//  Copyright (c) 2013年 baiwei.Yuan Wen. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol ServiceInvokeHandle <NSObject>

@optional

- (void)didSuccess:(id)result;

- (void)didSuccess:(id)result voucher:(id)voucher;

- (void)didFailure:(NSError *)err;

- (void)didFailure:(NSError *)err voucher:(id)voucher;

- (void)didCancel;

- (id)doConvertResult:(NSData *)data;

@end


@interface DHServiceInvocation : NSObject <NSURLConnectionDataDelegate>

+ (id) invokeWithNAME:(id)name requestMsg:(id)msg eventHandle:(id<ServiceInvokeHandle>)handle;
+ (void)cancelEventHandle:(id)param;
+ (void) cancel:(id)voucher;


@end
