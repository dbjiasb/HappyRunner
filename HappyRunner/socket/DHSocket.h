//
//  DHSocket.h
//  socketDemo2
//
//  Created by Meson on 11-12-7.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <unistd.h>

enum  
{
	SocketErrorNone      =   0,
	SocketCreateFailed   =   1,
	SocketConnectError   =   2,
	SocketSendFailed     =   3,
	SocketDisconnect     =   4,
	SocketBeyondMaximum,
	DeviceIllegal
	
	
};
typedef NSUInteger DHSocketError;

@class RequestMsg;
@protocol DHSocketDelegate ;

@interface DHSocket : NSObject {

	int socketClient;
	
	BOOL isSending;
	
	NSCondition *_myCondition;
	
	DHSocketError error;
	
	BOOL isConnected;

}

@property (retain, nonatomic) id <DHSocketDelegate> delegate;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, retain) RequestMsg *param;

@property BOOL isConnected;


//连接服务器
- (void)connectToSever:(NSString *)ipString port:(int )port;
//发送消息
- (BOOL)sendMessage:(NSString *)message;
- (void)sendMessageWithReq:(id)param;


//业务数据请求
- (void)invokeWithReq:(RequestMsg *)req
             delegate:(id <DHSocketDelegate>)delegate;
//IM请求
- (void)invokeIMWithReq:(RequestMsg *)req
             delegate:(id <DHSocketDelegate>)delegate;

@end


@protocol DHSocketDelegate <NSObject>
@optional

- (void)socketDidConnected:(DHSocket *)socket;
- (void)socket:(DHSocket *)socket didRecvMessage:(NSString *)message;
- (void)socketDidDisConnected:(DHSocket *)socket;
- (void)socketDidFail:(DHSocket *)socket;

/*
 成功接收
 result: 相应的Resp对象
*/
- (void)socketDidRecvMessage:(id)result;
- (void)socketDidFailError:(NSError *)error;

@end

