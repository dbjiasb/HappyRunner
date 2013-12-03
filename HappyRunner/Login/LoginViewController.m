//
//  LoginViewController.m
//  HappyRunner
//
//  Created by chinatsp on 13-10-13.
//  Copyright (c) 2013年 chinatsp. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface LoginViewController ()<DHSocketDelegate>

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
        [defaultCenter addObserver:self
                          selector:@selector(keyboardWillShow:)
                              name:UIKeyboardWillShowNotification
                            object:nil];
        [defaultCenter addObserver:self
                          selector:@selector(keyboardWillHide:)
                              name:UIKeyboardWillHideNotification
                            object:nil];
    }
    return self;
}

- (void)dealloc
{
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [defaultCenter removeObserver:self name:UIKeyboardWillHideNotification object:nil];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [accountText becomeFirstResponder];
}

-(void)keyboardWillHide:(NSNotification *)aNotification
{
    
    [UIView animateWithDuration:.25 animations:^{
    
    [inputView setCenter:CGPointMake(512, 384)];
    }];
}

- (void)keyboardWillShow:(NSNotification *)aNotification
{
    
//    NSDictionary *info = [aNotification userInfo];
//    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
//    CGSize keyboardSize = [value CGRectValue].size;
    
    //    float offsetY = [MyUtil isIphone5] ? 80 : 0;
    
    
    [UIView animateWithDuration:.30 animations:^{
        [inputView setCenter:CGPointMake(512, 200)];
        
    } completion:^(BOOL finished)
     {
         
     }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonPress:(UIButton *)button
{
    [self resignAllFeild];
    if (button.tag == 0) {
        //登陆
        NSString *account = accountText.text;
        NSString *password = passwordText.text;
        
        if (account.length == 0) {
            [MyUtil showAlert:@"用户名不能为空!"];
            return;
        }
        if (password.length == 0) {
            [MyUtil showAlert:@"密码不能为空!"];
            return;
        }

        LoginReq *req = [[LoginReq alloc] init];
        req.USER_NAME = account;
        req.PASSWORD = password;
        
        [[[DHSocket alloc] init] invokeWithReq:req
                                      delegate:self];
    }
    else
    {
        //注册
        RegisterViewController *controller = [[RegisterViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
        
    }
}

- (void)resignAllFeild
{
    [accountText resignFirstResponder];
    [passwordText resignFirstResponder];
}

- (IBAction)backAction:(UIButton *)button
{
    [self resignAllFeild];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)socketDidRecvMessage:(id)result
{
    
    LoginResp *resp = (LoginResp *)result;
    if (resp.code.integerValue == 1)
    {
        [MyDefaults setToken:resp.TOKEN];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [MyUtil showAlert:@"登陆出错，请稍后重试!"];
    }

}

- (void)socketDidFailError:(NSError *)error
{
    [MyUtil showAlert:error.domain];
}

@end
