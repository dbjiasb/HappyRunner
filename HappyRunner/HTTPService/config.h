//
//  config.h
//  HotelManager
//
//  Created by ysw on 13-4-5.
//  Copyright (c) 2013年 baiwei.Yuan Wen. All rights reserved.
//

#ifndef HotelManager_config_h
#define HotelManager_config_h


/*
 * nslog_debug
 */
//com.changqing.ManageHotel

#pragma mark - nslog_debug

#ifndef __OPTIMIZE__
# define NSLog(...) NSLog(__VA_ARGS__)
#else
# define NSLog(...)
#endif

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//IM服务地址：threadmill.oicp.net 端口号：9999
//跑步机服务地址：threadmill.oicp.net 端口号：9800

#define SEVER @"223.4.24.27"//@"192.168.5.45"//@"172.20.10.4"//@"192.168.1.199"//@"threadmill.oicp.net"//
#define PORT 9800//8888//

#define SERVER_Address @"http://threadmill.oicp.net:9800/userRegister"

#define NUMBER_OF_COLUMNS 3

static const int ERROR_CONNECTION_ERR = -1;
static const int ERROR_SERVER_ERR = -2;
static const int ERROR_CONVERT_RESULT_ERR = -3;
static const int ERROR_SERVER_NOT_AVAILABLE = -4;
static const int ERROR_NETWORK_NOT_AVAILABLE = -5;
static const int ERROR_OPERATE_FAILURE = -6;

static  NSString *const NAME_Method_Register = @"Register"; // param: accountId, mobileType

static  NSString *const NAME_Method_Login = @"login"; // param: accountId, mobileType
static  NSString *const NAME_Method_WriteApkCode = @"writeApkCode"; // param: accountId, mobileType,apkCode
static  NSString *const NAME_Method_SignIn = @"signIn"; // param: accountId
static  NSString *const NAME_Method_AddBean = @"addBean"; // param: accountId，mark，beans
static  NSString *const NAME_Method_UserInfo = @"userInfo"; //param: accountId
static  NSString *const NAME_Method_PrizeInfo = @"prizeInfo"; //param:
static  NSString *const NAME_Method_SpecialPrizeInfo = @"specialPrizeInfo"; //param:
static  NSString *const NAME_Method_PlatformInfo = @"platformInfo"; //param:
static  NSString *const NAME_Method_Awarding = @"awarding"; //param:accountId，changePwd，prizeName
static  NSString *const NAME_Method_AwardingRecords = @"awardingRecords"; //param:accountId，pageNum，pageSize 兑奖记录
static  NSString *const NAME_Method_Version = @"version"; //param:accountId，pageNum，pageSize 兑奖记录
static  NSString *const NAME_Method_Task = @"task"; //param:accountId 任务状态信息
static  NSString *const NAME_Method_DownloadGame = @"downloadGame"; //param:accountId 任务状态信息
static  NSString *const NAME_Method_GetGame = @"getGame"; //param: 获取下载游戏
static  NSString *const NAME_Method_GetAppsFromCP = @"getAppsFromCP"; //param: cpid,pageNum,pageSize获取下载游戏
static  NSString *const NAME_Method_AddBeans = @"addBeans"; //param: accountId,appid 用户从自定义平台下载应用并打开应用后给用户增加金豆
static  NSString *const NAME_Method_GetApkCodeAndDes = @"getApkCodeAndDes"; //param: accountId 获取apk推广码及推广描述
static  NSString *const NAME_Method_GetSpreadInfo = @"getSpreadInfo"; //param: accountId,pageNum,pageSize 用户获取推广明细
static  NSString *const NAME_Method_CountSpreadInfo = @"countSpreadInfo"; //param: accountId 用户推广总计
static  NSString *const NAME_Method_EditPwd = @"editPwd"; //param: accountId,changePwd,qqPwd 用户修改兑奖密码
static  NSString *const NAME_Method_UserOpinion = @"userOpinion"; //param: accountId,content 用户意见反馈


#endif
