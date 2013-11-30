//
//  RegisterViewController.m
//  HappyRunner
//
//  Created by chinatsp on 13-10-13.
//  Copyright (c) 2013年 chinatsp. All rights reserved.
//

#import "RegisterViewController.h"
#import "DHSocket.h"

@interface RegisterViewController ()<ServiceInvokeHandle,DHSocketDelegate>
{
//    DHSocket *_socket;
}
@end

@implementation RegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)registerAction:(UIButton *)sender
{
    NSString *account = accountText.text;
    NSString *password = passwordText.text;
    NSString *surePsd = surePsdText.text;
//    NSString *nickname = nicknameText.text;
//    NSString *email = emailText.text;

    if (account.length == 0) {
        [MyUtil showAlert:@"用户名不能为空!"];
        return;
    }
    if (password.length == 0) {
        [MyUtil showAlert:@"密码不能为空!"];
        return;
    }
    if (surePsd.length == 0) {
        [MyUtil showAlert:@"确认密码不能为空!"];
        return;
    }
    if (![surePsd isEqualToString:password]) {
        [MyUtil showAlert:@"两次密码不一致!"];
        return;
    }
    
    RegisterReq *req = [[RegisterReq alloc] init];
    req.USER_NAME = account;//@"dragon";
    req.PASSWORD = password;//@"123456";
    req.NICK_NAME = @"DragonHuang";//@"testUser";

    [[[DHSocket alloc] init] invokeWithReq:req
                                  delegate:self];
//    _socket  = [[DHSocket alloc] init];
//    _socket.delegate = self;
//    [_socket connectToSever:SEVER port:PORT];
    
    
//    RegisterReq *req = [[RegisterReq alloc] init];
//    req.USER_NAME = @"test11";
//    req.SERVICE = @"userRegister";
//    req.PASSWORD = @"123456";
//    req.NICK_NAME = @"测试用户";
//    
//    
//    [DHServiceInvocation invokeWithNAME:NAME_Method_Register
//                             requestMsg:req
//                            eventHandle:self];
}

- (void)socketDidConnected:(DHSocket *)socket
{
    NSLog(@"-----链接成功------");
//    [MyUtil showAlert:@"注册成功!" delegate:(id <UIAlertViewDelegate>)self];
    
//    RegisterReq *req = [[RegisterReq alloc] init];
//    req.USER_NAME = @"test11112";
//    req.SERVICE = @"userRegister";
//    req.PASSWORD = @"123456";
//    req.NICK_NAME = @"啊啊";//@"testUser";
//
//    [socket sendMessageWithReq:req];
    
}

- (void)socketDidRecvMessage:(id)result
{
    RegisterResp *resp = (RegisterResp *)result;
    
    if ([resp.code integerValue] == 1)
    {
        [MyUtil showAlert:@"注册成功!"
                 delegate:(id <UIAlertViewDelegate>)self];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
