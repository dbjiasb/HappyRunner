//
//  GameChooseViewController.m
//  HappyRunner
//
//  Created by chinatsp on 13-11-28.
//  Copyright (c) 2013年 chinatsp. All rights reserved.
//

#import "GameChooseViewController.h"
#import "SCGIFImageView.h"

@interface GameChooseViewController ()
{
    UIImageView *runnerView;
    
    NSTimer *timer;
    
    UIImageView *treeRight;
    UIImageView *treeLeft;
}

@property (nonatomic,retain) StartRaceResp *startResp;

@end

@implementation GameChooseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(didReceiveInviteFriend:)
//                                                     name:Notification_Key_InviteFriend
//                                                   object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:Notification_Key_InviteFriend
                                                  object:self];
}

- (void)didReceiveInviteFriend:(NSNotification *)notification
{
    InviteFriendsResp *resp = notification.object;
    
    [MyUtil showAlert:[NSString stringWithFormat:@"%@邀请你参加比赛",resp.USER_ID]
             delegate:(id<UIAlertViewDelegate>)self
              button1:@"取消"
              button2:@"确定"];
}


- (void)viewWillDisappear:(BOOL)animated
{
    if (timer) {
        [timer invalidate];
    }
    
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 748)];
    imgv.image = [UIImage imageNamed:@"bg_game_1.jpg"];
    [self.view addSubview:imgv];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    backBtn.backgroundColor = [UIColor blackColor];
    [backBtn setFrame:CGRectMake(70, 20, 80, 45)];
    [backBtn setTitle:@"菜单" forState:UIControlStateNormal];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"btn_menu_1.png"] forState:UIControlStateNormal];
    [self.view addSubview:backBtn];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(100, 100, 100, 100)];
    [button setBackgroundColor:[UIColor redColor]];
    [button setTitle:@"邀请好友" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(inviteFriend) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button1 setFrame:CGRectMake(100, 250, 100, 100)];
    [button1 setBackgroundColor:[UIColor redColor]];
    [button1 setTitle:@"开始" forState:UIControlStateNormal];
    [self.view addSubview:button1];
    [button1 addTarget:self action:@selector(startRace) forControlEvents:UIControlEventTouchUpInside];

    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button2 setFrame:CGRectMake(100, 400, 100, 100)];
    [button2 setBackgroundColor:[UIColor redColor]];
    [button2 setTitle:@"上传数据" forState:UIControlStateNormal];
    [self.view addSubview:button2];
    [button2 addTarget:self action:@selector(upLoadRuningData) forControlEvents:UIControlEventTouchUpInside];

    
    [self loadTrees];
    [self loadRunner];
    
    [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(updateTrees) userInfo:nil repeats:YES];
}

- (void)updateTrees
{
    static int count = 0;
    count++;
    
    if (count == 10)
    {
        count = 0;
        [treeRight setFrame:CGRectMake(470, 430, 174, 146)];
        treeRight.layer.transform = CATransform3DIdentity;
        treeRight.layer.transform = CATransform3DMakeScale(.1, .1, 1);
        return;
    }
    
    treeRight.frame = CGRectMake(treeRight.frame.origin.x + 16, treeRight.frame.origin.y + 10, treeRight.frame.size.width, treeRight.frame.size.height);
    
//    treeRight.layer.transform = CATransform3DIdentity;
//    treeRight.layer.transform = CATransform3DMakeScale(0.1*count, 0.1*count, 1);

}

- (void)loadTrees
{
    UIImage *img = [UIImage imageUtilName:@"tree_1"];
    
    treeRight = [[UIImageView alloc] initWithFrame:CGRectMake(470, 430, 174, 146)];
    treeRight.layer.anchorPoint = CGPointMake(0.5,1);
    treeRight.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    treeRight.image = img;
    [self.view addSubview:treeRight];
    
    treeLeft = [[UIImageView alloc] initWithFrame:CGRectMake(10, 600, 174, 146)];
    treeLeft.layer.anchorPoint = CGPointMake(0.5, 1);
    treeLeft.layer.transform = CATransform3DMakeScale(0.8, 0.8, 1);
    treeLeft.image = img;
    [self.view addSubview:treeLeft];

}

- (void)upLoadRuningData
{
     treeRight.layer.transform = CATransform3DMakeScale(0.4, 0.4, 1);
    return;
    
    TransacationRealTimeDataReq *req = [[TransacationRealTimeDataReq alloc] init];
    req.MATCH_ID = self.startResp.MATCH_ID;
    req.DISTANCE = @"100";
    req.CALORIE = @"100";
    req.TIME_CONSUMING = @"50";
    req.SPEED = @"100";
    req.USER_ID = [MyDefaults getUserID];
    req.NICK_NAME = @"gzy";
    
    [[DHSocket shareSocket] invokeWithReq:req
                                 delegate:(id<DHSocketDelegate>)self];
}

- (void)startRace
{
    treeRight.layer.transform = CATransform3DMakeScale(1, 1, 1);
    return;

    StartRaceReq *req = [[StartRaceReq alloc] init];
    req.USER_ID = [MyDefaults getUserID];
    NSString *group = [[NSUserDefaults standardUserDefaults] objectForKey:@"GROUP_ID"];
    req.GROUP_ID = group;
    
    [[DHSocket shareSocket] invokeWithReq:req
                                 delegate:(id<DHSocketDelegate>)self];
}

- (void)inviteFriend
{
    InviteFriendsReq *req = [[InviteFriendsReq alloc] init];
    req.USER_ID = [MyDefaults getUserID];
    req.INVITE_FRIEND_IDS = @"22";
    
    [[DHSocket shareSocket] invokeWithReq:req
                                   delegate:(id<DHSocketDelegate>)self];
}

- (void)socketDidRecvMessage:(id)result service:(NSString *)service
{
    if ([service isEqualToString:@"startRace"])
    {
        self.startResp = (StartRaceResp *)result;
    }
    else
    {
        
    }
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadRunner
{
    runnerView = [[UIImageView alloc] initWithFrame:CGRectMake(452, 540, 152 * 0.5, 347 * 0.5)];
    [self.view addSubview:runnerView];
    [runnerView setImage:[UIImage imageUtilName:@"girl_run_0000.png"]];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(changImage) userInfo:nil repeats:YES];
    
    [timer fire];
}

- (void)changImage
{
    static int count = 0;
    NSString *str = [NSString stringWithFormat:@"girl_run_%04d",++count];
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:str ofType:@"png"]];
    [runnerView setImage:image];
    
    if (count == 23) {
        count = 0;
    }
}

//加载Gif动画，暂时不用
- (void)loadGifImages
{
    
    SCGIFImageView *gifImageView = [[SCGIFImageView alloc] initWithFrame:CGRectMake(130, 230, 80, 80)] ;
    gifImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    gifImageView.backgroundColor	= [UIColor clearColor];
    gifImageView.contentMode		= UIViewContentModeScaleAspectFit;
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"maninwater.gif" ofType:nil];
    NSData* imageData = [NSData dataWithContentsOfFile:filePath];
    [gifImageView setData:imageData];
    
    [self.view addSubview:gifImageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
