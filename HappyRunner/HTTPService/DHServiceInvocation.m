//
//  DHServiceInvocation.m
//  HotelManager
//
//  Created by Dragon Huang on 13-5-19.
//  Copyright (c) 2013年 baiwei.Yuan Wen. All rights reserved.
//

#import "DHServiceInvocation.h"
#import "config.h"
#import "RequestMsg.h"
#import "JSONKit.h"

#pragma mark - RequstTask

#define canResponse(__task, __method)       __task && \
[__task isMemberOfClass:RequstTask.class] && \
__task.eventHandle && \
[__task.eventHandle respondsToSelector:@selector(__method)]


@interface RequstTask : NSObject

@property (nonatomic, retain) NSString * key;

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) id param;
@property (nonatomic, assign) id<ServiceInvokeHandle> eventHandle;
@property (nonatomic, retain) NSURLConnection * connection;

@property (nonatomic, readonly) NSMutableData * cache;

@property (nonatomic, assign) BOOL didFailure;

@property (nonatomic, assign) BOOL runOnBackground;

@end

@implementation RequstTask

@synthesize key;

@synthesize name;
@synthesize param;
@synthesize eventHandle = _eventHandle;
@synthesize connection;

@synthesize cache;

- (id) init {
    if (self = [super init]) {
        self.didFailure = NO;
        self.runOnBackground = NO;
        cache = [[NSMutableData alloc] init];
    }
    return self;
}

- (void) dealloc {
    

}

- (id<ServiceInvokeHandle>) eventHandle {
    
    @try {
        BOOL test; // 无用的
        test = [_eventHandle respondsToSelector:@selector(didSuccess:)];
        test = [_eventHandle respondsToSelector:@selector(didSuccess:voucher:)];
        test = [_eventHandle respondsToSelector:@selector(didFailure:)];
        test = [_eventHandle respondsToSelector:@selector(didFailure:voucher:)];
        test = [_eventHandle respondsToSelector:@selector(didCancel)];
    }
    @catch (NSException * exception) {
        NSLog(@"%@", [exception description]);
        return nil;
    }
    
    return _eventHandle;
}

@end



static NSMutableDictionary * _taskDic = nil;//存放所有任务
static DHServiceInvocation * _service = nil;//请求实例

RequstTask * _getTask(NSURLConnection *conn) {
    RequstTask * task = nil;
    NSArray * values = [_taskDic allValues];
    for (RequstTask * t in values) {
        if (t.connection == conn) {
            task = t;
            break;
        }
    }
    return task;
};

RequstTask * _getTaskByVoucher(id voucher) {
    return [_taskDic objectForKey:voucher];
}


@implementation DHServiceInvocation


+ (void) initialize
{
    _taskDic = [[NSMutableDictionary alloc] initWithCapacity:5];
    _service = [[DHServiceInvocation alloc] init];
    
}

+ (void) cancel:(id)param {
    
    if (![param isKindOfClass:NSObject.class])
        return;
    
    RequstTask * task = _getTaskByVoucher(param); // 取回当前任务
    if (task) {
        [task.connection cancel]; // 取消连接
        NSLog(@"User cancel %@", task.key);
    } else {
        return;
    }
    
    BOOL canResp = canResponse(task, didCancel);
    if (canResp) {
        [task.eventHandle didCancel];
    }
    
    [_taskDic removeObjectForKey:task.key]; // 释放该任务
}

+ (void)cancelEventHandle:(id)param
{
    if (![param isKindOfClass:NSObject.class])
        return;
    RequstTask * task = _getTaskByVoucher(param); // 取回当前任务
    if (task) {
        task.eventHandle = nil; // 取消回调
        NSLog(@"User cancel EventHandle %@ ", task.key);
    }
}



+ (id) invokeWithNAME:(id)name requestMsg:(id)msg eventHandle:(id<ServiceInvokeHandle>)handle
{
    
    // 初始化一个任务
    RequstTask *task = [[RequstTask alloc] init];
    task.name = name;
    task.param = msg;
    task.eventHandle = handle;
    
    
    int32_t i32max = INT32_MAX;
    int32_t random = ((int32_t)arc4random()) % i32max;
    id ret = [NSString stringWithFormat:@"%@[%o]", name, random];
    
    NSString * url = [NSString stringWithFormat:@"%@", SERVER_Address];
    
    // 初始化一个请求
    NSLog(@"Connection start with %@:%@", ret, url);
    NSURL *nsUrl = [NSURL URLWithString:url];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:nsUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
    
    [self prepareRequest:request param:msg];
    
    // 初始化一个连接(包括请求的内容)
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:_service startImmediately:NO];
    
    if (conn) {
        task.connection = conn;
        [conn start]; // 打开连接
        task.key = ret;
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        [_taskDic setValue:task forKey:task.key];
    } else {
        ret = nil;
    }
    
    return ret;
}

+ (void) prepareRequest:(NSMutableURLRequest *)req param:(id )param {

    NSMutableString * log = [[NSMutableString alloc] initWithCapacity:5];
    NSLog(log, @"Send body:\r\n");
    
    [req setHTTPMethod:@"POST"];
//    [req setTimeoutInterval:[param requestTimeout] > 0 ? [param requestTimeout] : EMarketing_INVOKE_TIMEOUT_DEFAULT];
    [req setValue:@"Mozilla/5.0" forHTTPHeaderField:@"User-Agent"];
    [req setValue:@"ios" forHTTPHeaderField:@"Client-Type"];
    [req setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];

    if ([param isKindOfClass:[RequestMsg class]])
    {
        // 普通的json请求
        [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [req setValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
        [req setValue:@"no-cache" forHTTPHeaderField:@"Pragma"];
        // [req setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
        // 初始化请求的内容
        NSDictionary *dic = [param dictionary];
        NSError *err = nil;
        
        NSString *data = [dic JSONString];
        if (err) {
            NSLog(@"Parse JSON param err:%@", err);
        } else {
            [req setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
            NSLog(@"%@",data);
        }
        
    }
    
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)conn didReceiveResponse:(NSURLResponse *)response
{
    
}

- (void)connection:(NSURLConnection *)conn didReceiveData:(NSData *)data
{
    RequstTask * task = _getTask(conn); // 取回当前任务
    [task.cache appendData: data];
    
//    _updateDataRate(task.name, data.length);
#if kShouldPrintDetailsFlags
    NSString * strData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Connection did receive data with %@.\r\n%@", task.key, strData);
#endif

    
}

- (void)connection:(NSURLConnection *)conn didFailWithError:(NSError *)error
{
    
    NSLog(@"%@",[error localizedDescription]);
    RequstTask * task = _getTask(conn); // 取回当前任务

    
    
    // 释放该任务
    [_taskDic removeObjectForKey:task.key];

}

//请求结束
- (void)connectionDidFinishLoading:(NSURLConnection *)conn
{
    RequstTask * task = _getTask(conn); // 取回当前任务

    NSLog(@"%@",[[NSString alloc] initWithData:task.cache encoding:NSUTF8StringEncoding]);
    
    NSDictionary *retDic = [task.cache objectFromJSONData];
    
    if (retDic)
    {
        if (task.eventHandle)
        {
            Class cls = [task.param responseMsgClass];
            id resp = [[cls alloc] init];
            [resp fillFromeDictionary:retDic];

            // 通知用户调用成功
            if (canResponse(task, didSuccess:voucher:))
            {
                [task.eventHandle didSuccess:resp voucher:task.key];
            }
            else if (canResponse(task, didSuccess:)) {
                [task.eventHandle didSuccess:resp];
            }
        }
    }
    else
    {
        //数据出错
    }
    
    // 释放该任务
    [_taskDic removeObjectForKey:task.key];

}


@end
