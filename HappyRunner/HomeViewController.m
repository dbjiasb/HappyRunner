//
//  ViewController.m
//  HappyRunner
//
//  Created by chinatsp on 13-10-12.
//  Copyright (c) 2013年 chinatsp. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "SettingViewController.h"
#import "MusicPlayViewController.h"
#import "HealthComomSenceViewController.h"
#import "FriendsViewController.h"
#import "LittleGamedViewController.h"
#import "GameChooseViewController.h"

@interface HomeViewController ()
{
    
}

@property (nonatomic, retain) InviteFriendsResp *resp;

@end

@implementation HomeViewController
- (id)init
{
    if (self = [super init]) {
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didReceiveInviteFriend:)
                                                     name:Notification_Key_InviteFriend
                                                   object:nil];
        
    }
    
    return self;
}

- (void)didReceiveInviteFriend:(NSNotification *)notification
{
    self.resp = notification.object;
    [[NSUserDefaults standardUserDefaults] setObject:self.resp.GROUP_ID forKey:@"GROUP_ID"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    if ([self.resp.USER_ID isEqualToString:[MyDefaults getUserID]]) {
        
        
        return;
    }
    
    [MyUtil showAlert:[NSString stringWithFormat:@"%@邀请你参加比赛",self.resp.USER_ID]
             delegate:(id<UIAlertViewDelegate>)self
              button1:@"拒绝"
              button2:@"接受"];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:Notification_Key_InviteFriend
                                                  object:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.view setFrame:CGRectMake(0, 0, 1024, 768)];
    NSLog(@"%.1f,%.1f",self.view.frame.size.width,self.view.frame.size.height);
    
//    CGAffineTransform rotation = CGAffineTransformMakeRotation(-M_PI_2);
//    [self.view setTransform:rotation];

    
    [self loadBG];
    [self loadButtons];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)loadBG
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    UIImage *bgImg = [UIImage imageNamed:@"bg_home"];
    imageView.image = bgImg;
    [self.view addSubview:imageView];
    
}

- (void)loadButtons
{
    
    NSArray *names = @[@"跑步练习",@"小游戏",@"我的好友",@"音乐",@"健康常识"];
    
    for (int i = 0; i < 5; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_home"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [button setFrame:CGRectMake(180 + 150 * i, 200, 105, 105)];
        [button setTitle:names[i] forState:UIControlStateNormal];
        button.tag = i;
        [self.view addSubview:button];
        [button addTarget:self action:@selector(functionBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingBtn setImage:[UIImage imageNamed:@"btn_setting.png"] forState:UIControlStateNormal];
    [settingBtn setFrame:CGRectMake(950, 10, 60, 60)];
    [self.view addSubview:settingBtn];
    [settingBtn addTarget:self action:@selector(settingAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)settingAction
{
    SettingViewController *controller = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];

}

- (void)functionBtnPress:(UIButton *)button
{
    
    if (![MyDefaults getToken])
    {
        LoginViewController *controller = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];

        return;
    }
    
    UIViewController *controller = nil;
    
    switch (button.tag) {
        case 0:
        {
            GameChooseViewController *controller = [[GameChooseViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
//            LoginViewController *controller = [[LoginViewController alloc] init];
//            [self.navigationController pushViewController:controller animated:YES];
            
            return;

        }
            break;
        case 1:
        {
//            controller = [[LittleGamedViewController alloc] init];
            LoginViewController *controller = [[LoginViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
            
            return;

        }
            break;
        case 2:
        {
            controller = [[FriendsViewController alloc] init];

        }
            break;
        case 3:
        {
            controller = [[MusicPlayViewController alloc] init];
            
        }
            break;
        case 4:
        {
            controller = [[HealthComomSenceViewController alloc] init];
            
        }
            break;
            
        default:
            break;
    }
 
    if (controller)
    {
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate NS_AVAILABLE_IOS(6_0)
{
    return NO;
}
- (NSUInteger)supportedInterfaceOrientations NS_AVAILABLE_IOS(6_0)
{
    return UIInterfaceOrientationLandscapeLeft;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    FeedbackForFriendReq *req = [[FeedbackForFriendReq alloc] init];
    req.VERIFIED = [NSString stringWithFormat:@"%d",buttonIndex];
    req.USER_ID = [MyDefaults getUserID];
    req.TO_USER_ID = self.resp.USER_ID;
    req.GROUP_ID = self.resp.GROUP_ID;

    
    self.resp = nil;
    
    [[DHSocket shareSocket] invokeWithReq:req delegate:(id<DHSocketDelegate>)self];
}

@end
