//
//  DHSocket.m
//  socketDemo2
//


//  Created by Meson on 11-12-7.

//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DHSocket.h"
#include <fcntl.h>
#include <sys/ioccom.h>
#include <sys/ioctl.h>
#import "RequestMsg.h"
#import "JSONKit.h"
#import "netdb.h"
#import "JSON.h"
//#define IP @"169.254.140.136";
//#define IP @"193.19.3.7"
//#define IP @"193.19.3.254"
//#define CONNECTPORT 12345


#define IP @"192.168.1.100"
#define CONNECTPORT 80


#define MINSIZE 512
#define TMINSIZE 1024*128

#define NUMOFID 201

@interface DHSocket()

@end

static DHSocket *_scocket;

@implementation DHSocket

@synthesize isConnected;

+ (void) initialize
{
    _scocket = [[DHSocket alloc] init];
}

+ (DHSocket *)shareSocket
{
    if (!_scocket)
    {
        _scocket = [[DHSocket alloc] init];
        [_scocket connectToSever:SEVER port:PORT];
    }
    
    return _scocket;
}

-(id)init
{
	if (self=[super init]) 
	{
		error = SocketErrorNone;
		
		isSending = NO;   //上一条信息处理完

		isConnected = NO;
		
	}
	return self;
}

- (void)invokeWithReq:(RequestMsg *)req
             delegate:(id <DHSocketDelegate>)delegate
{
    self.delegate = delegate;
    self.param = req;
    
//    [self connectToSever:SEVER port:PORT];
    [self sendMessageWithReq:req];
    
}

- (void)invokeIMWithReq:(RequestMsg *)req
               delegate:(id <DHSocketDelegate>)delegate
{
    
}

-(void)setupSocket
{
	socketClient = socket(AF_INET,SOCK_STREAM,0);
	
	if(socketClient < 0)
	{
		NSLog(@"\n create socket failed");
		close(socketClient);
		error = SocketCreateFailed;
		return;
	}
	
	int nRecvBuf = 32 * 1024;//设置为32K
	setsockopt(socketClient,SOL_SOCKET,SO_RCVBUF,(const char*)&nRecvBuf,sizeof(int));
}

- (void)connectToSever:(NSString *)ipString port:(int )port
{
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                   ^{

                       if([self connectToSever1:ipString port:port])
                       {
                           NSLog(@"已成功连接到服务器");
                           dispatch_async(dispatch_get_main_queue(),
                                          ^{
                                              //连接成功的回调
                                              if (self.delegate && [self.delegate respondsToSelector:@selector(socketDidConnected:)])
                                              {
                                                  [self.delegate socketDidConnected:self];
                                              }
                                              
                                          }
                                          );
                           if ([MyDefaults getToken])
                           {
                               LoginReq *req = [[LoginReq alloc] init];
                               [self invokeWithReq:req
                                            delegate:nil];
                           }
//                           //成功链接后发送
//                           [self sendMessageWithReq:self.param];
                           //循环等待消息
                           [self recvCommand];
                       }
                       else
                       {
                           [self connectToSever:ipString port:port];
                           
                       }
                       
                       
                   }
                   );
    
}

- (BOOL )connectToSever1:(NSString *)ipString port:(int )port
{
    NSLog(@"正在尝试连接%@，端口为:%d",ipString,port);
    
    struct hostent* host_entry = gethostbyname([ipString UTF8String]);
    
    char IPStr[64] = {0};
    
    if(host_entry !=0){
        
        sprintf(IPStr, "%d.%d.%d.%d",(host_entry->h_addr_list[0][0]&0x00ff),
                
                (host_entry->h_addr_list[0][1]&0x00ff),
                
                (host_entry->h_addr_list[0][2]&0x00ff),
                
                (host_entry->h_addr_list[0][3]&0x00ff));
    }

    
    //初始化socket对象
    [self setupSocket];
    
	struct sockaddr_in addr;
	memset(&addr,0,sizeof(addr));
	addr.sin_len =sizeof(addr);
	addr.sin_family=AF_INET;
    
	addr.sin_port=htons(port);
	addr.sin_addr.s_addr= inet_addr(IPStr);
	
	
	int _error = -1, len;
	len = sizeof(int);
	struct timeval tm;
	fd_set set;
	unsigned long ul = 1;
	ioctl(socketClient, FIONBIO, &ul); //设置为非阻塞模式
	bool ret = false;
	if( connect(socketClient,(struct sockaddr *)&addr,sizeof(addr)) == -1)
	{
		tm.tv_sec  = 1;
		tm.tv_usec = 500;
		FD_ZERO(&set);
		FD_SET(socketClient, &set);
		if( select(socketClient+1, NULL, &set, NULL, &tm) > 0)
		{
			getsockopt(socketClient, SOL_SOCKET, SO_ERROR, &_error, (socklen_t *)&len);
			if(_error == 0) ret = true;
			else ret = false;
		} else ret = false;
	}
	else ret = true;
	ul = 0;
	ioctl(socketClient, FIONBIO, &ul); //设置为阻塞模式
	if(!ret)
	{
		fprintf(stderr , "Cannot Connect the server!\n");
		error=SocketConnectError;
		close(socketClient);
		return NO;
	}
    
    isConnected=YES;
    
    return YES;
}

//接收消息
-(void)recvCommand
{
	if (socketClient)
	{
		struct timeval tv;
		fd_set readfds;
		tv.tv_sec = 0;
		tv.tv_usec = 0;
		
		Byte tempRecv[1024];//缓冲区
		memset(tempRecv,0x00,1024);
		int recState = 0;
		int tempSize = 0;
		
		while (YES)
		{	
			if (!isConnected ) 
			{
				error = SocketDisconnect;
			     NSLog(@"disconnect!");
				close(socketClient);
                socketClient = 0;
				return;
				
			}
			FD_ZERO(&readfds);  //每次循环都要清空集合，否则不能检测描述符变化
			FD_SET(socketClient,&readfds);//turn on the bit for fd in fdset
			int rec = select(socketClient + 1,&readfds,NULL,NULL,&tv);
			
			
			if (rec == -1)
			{//select错误，退出程序
				NSLog(@"select wrong--%d!",rec);
                
			}
            else if(rec == 0)
            {//再次轮询
                
            }
            else
			{
                 //测试sock是否可读，即是否网络上有数据
				if( FD_ISSET(socketClient,&readfds)>0)
				{
					BOOL sthToRead=NO;
					
                    //从流读取数据
					Byte *rePacket = (Byte *)malloc(MINSIZE);
					memset(rePacket,0x00,MINSIZE);
					while((tempSize = recv(socketClient,tempRecv,sizeof(tempRecv), MSG_DONTWAIT)) > 0)
					{
						sthToRead=YES;
							
						for (int i = recState; i < tempSize+recState; i++)
						{
							rePacket[i] = tempRecv[i-recState];
							tempRecv[i-recState] = 0x00;
						}
						
						recState = recState + tempSize;
					}

					if(!sthToRead)
					{
//						error = SocketDisconnect;
//						NSLog(@"断开连接v....");
//						free(rePacket);
//						close(socketClient);
//						return;
						
					}
					else
                    {
                        [self didRecvMessageFromSever:rePacket size:recState];
                    }

					recState = 0;
					free(rePacket);
//                    break;
				}
			}
		}
	}
}

- (void)sendMessageWithReq:(id)param
{
    if ([param isKindOfClass:[RequestMsg class]])
    {
        
        NSDictionary *dic = [param dictionary];
        NSString *msg = [dic JSONString];
        msg = [msg stringByAppendingString:@"\r\n"];
//        msg = @"啊啊啊啊";
        [self sendMessage:msg];

    }
}

- (BOOL)sendMessage:(NSString *)message
{
    NSLog(@"send:%@",message);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                   ^{
                       
                       int lenght = [message length];
                       
//                       NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
                       
                       NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];

                       Byte *byte = (Byte *)[data bytes];
                       int sendState = send(socketClient,byte,lenght,MSG_FLUSH);

                       if (sendState > 0)
                       {
                           //发送成功
                           NSLog(@"发送成功");
                           dispatch_async(dispatch_get_main_queue(),
                                          ^{
                                              
                                          }
                                          );
                           
                           //发送成功后循环从服务器获取消息
//                           [self recvCommand];
                       }
                       else
                       {
                           if(errno == ENOTDIR)
                           {
                               
                           }
                           error = SocketSendFailed;
                           
                           dispatch_async(dispatch_get_main_queue(),
                                          ^{
                                              
                                          }
                                          );

                       }
                       
                   });

    return NO;
}

- (void)didRecvMessageFromSever:(Byte *)rePacket
                           size:(int )size
{
    if (rePacket && size > 0)
    {
        NSString *message = [NSString stringWithCString:(char *)rePacket
                                               encoding:NSUTF8StringEncoding];
        NSLog(@"%@",message);
        
        
        if ([message length] > 0)
        {
            
            NSDictionary *dic = [message objectFromJSONString];
            if (!dic)
            {
                NSLog(@"数据出错～");
                return;
            }
            
            if ([dic[@"SERVICE"] isEqualToString:@"noticeInviteFriend"])
            {
                InviteFriendsResp *resp = [[InviteFriendsResp alloc] init];
                [resp fillFromeDictionary:dic];
                
                dispatch_async(dispatch_get_main_queue(),
                               ^{
                                   [[NSNotificationCenter defaultCenter] postNotificationName:Notification_Key_InviteFriend
                                                                                       object:resp];
                               });
                
                return;
            }
            
            ResponseMsg *resp = [[[self.param responseMsgClass] alloc] init];
            [resp fillFromeDictionary:dic];

            dispatch_async(dispatch_get_main_queue(),
                           ^{
                               if([resp.code integerValue] == 1)
                               {
                                   if (self.delegate && [self.delegate respondsToSelector:@selector(socketDidRecvMessage:service:)])
                                   {
                                       [self.delegate socketDidRecvMessage:resp service:self.param.SERVICE];
                                   }
                                   else if (self.delegate && [self.delegate respondsToSelector:@selector(socketDidRecvMessage:)])
                                   {
                                       [self.delegate socketDidRecvMessage:resp];
                                   }
                               }
                               else
                               {
                                   if (self.delegate && [self.delegate respondsToSelector:@selector(socketDidFailError:)])
                                   {
                                       if (!resp.message) {
                                           resp.message = @"数据出错!";
                                       }
                                       NSError *err = [NSError errorWithDomain:resp.message code:[resp.code integerValue] userInfo:nil];
                                       [self.delegate socketDidFailError:err];
                                   }
                               }
                           }
                           );
            
//            close(socketClient);
        }
        
    }
    
}


@end

