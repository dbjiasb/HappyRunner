//
//  GameChooseViewController.m
//  HappyRunner
//
//  Created by chinatsp on 13-11-28.
//  Copyright (c) 2013年 chinatsp. All rights reserved.
//

@interface GameImageView : UIImageView

@property (nonatomic, assign) float scale;
@property (nonatomic, assign) float translationX;
@property (nonatomic, assign) float translationY;

@end

@implementation GameImageView


@end

#import "GameChooseViewController.h"
#import "SCGIFImageView.h"

@interface GameChooseViewController ()
{
    UIImageView *runnerView;
    
    NSTimer *timer;
    
    GameImageView *treeRight;
    GameImageView *treeLeft;
    
    float leftY;
    float leftX;
    float rightX;
    float rightY;
    
    
    float scaleNum ;
}

@property (nonatomic, retain) NSMutableArray *leftItems;
@property (nonatomic, retain) NSMutableArray *rightItems;

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
        
        scaleNum = 0.1;
        
        leftY = 0;
        rightY = 0;
        
        leftX = 0;
        rightX = 0;
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
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateItems) userInfo:nil repeats:YES];
}

- (void)updateItems
{
    for (int i = 0; i < self.leftItems.count; i++)
    {
        GameImageView *item = self.leftItems[i];
        [self updateItem:item isLeft:YES];
        
        GameImageView *itemr = self.rightItems[i];
        [self updateItem:itemr isLeft:NO];

    }
    
}

- (void)updateItem:(GameImageView *)item isLeft:(BOOL)isLeft
{
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    scale.duration = 1;
    scale.repeatCount = 1;
    scale.autoreverses = NO;
    scale.delegate = self;
    scale.fillMode = kCAFillModeForwards;
    scale.removedOnCompletion = NO;
    scale.fromValue = [NSNumber numberWithFloat:item.scale];
    scale.toValue = [NSNumber numberWithFloat:item.scale + 0.2];
    item.scale = item.scale + 0.2;
    if (item.scale >= 1) {
        item.scale = .1;
    }
    [item.layer addAnimation:scale forKey:@"scale"];
    
    CABasicAnimation *translationY = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    translationY.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    translationY.duration = 1;
    translationY.repeatCount =1;
    translationY.autoreverses = NO;
    translationY.fillMode = kCAFillModeForwards;
    translationY.removedOnCompletion = NO;
    
    translationY.fromValue = [NSNumber numberWithFloat:item.translationY];
    translationY.toValue = [NSNumber numberWithFloat:item.translationY + 65];
    item.translationY = item.translationY + 65;
    
    [item.layer addAnimation:translationY forKey:@"translation.y"];
    
    CABasicAnimation *translationX = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    translationX.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    translationX.duration = 1;
    translationX.repeatCount = 1;
    translationX.autoreverses = NO;
    translationX.fillMode = kCAFillModeForwards;
    translationX.removedOnCompletion = NO;
    translationX.fromValue = [NSNumber numberWithFloat:item.translationX];
    if (isLeft)
    {
        translationX.toValue = [NSNumber numberWithFloat:item.translationX - 133];
        item.translationX = item.translationX - 133;
    }
    else
    {
        translationX.toValue = [NSNumber numberWithFloat:item.translationX + 150];
        item.translationX = item.translationX + 150;
    }
    [item.layer addAnimation:translationX forKey:@"translation.x"];
    

    if (item.translationY > 260)
    {
        item.translationX = 0;
        item.translationY = 0;
//        item.scale = .1;
        
        [item.layer removeAnimationForKey:@"scale"];
        [item.layer removeAnimationForKey:@"translation.x"];
        [item.layer removeAnimationForKey:@"translation.y"];
        item.layer.transform = CATransform3DIdentity;
        
        if (isLeft)
        {
            [item setFrame:CGRectMake(330 , 430 , 174 , 146)];
        }
        else
        {
            [item setFrame:CGRectMake(470 , 430 , 174 , 146)];
        }
        item.layer.transform = CATransform3DMakeScale(0.1 , 0.1 , 1);
    }
    
    NSLog(@"%f---%f---%f",item.scale,item.translationX,item.translationY);
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
//    [treeRight.layer animationForKey:@"transform.translation.y"];
//    NSLog(@"animationDidStop");
}

- (void)loadTrees
{
    UIImage *img = [UIImage imageUtilName:@"tree_1"];
    
    if (!self.leftItems) {
        self.leftItems = [NSMutableArray array];
    }
    if (!self.rightItems) {
        self.rightItems = [NSMutableArray array];
    }
    
    for (int i = 0; i < 3; i++)
    {
        GameImageView *rt = [[GameImageView alloc] initWithFrame:CGRectMake(470 + i * 150, 430 + i * 65, 174, 146)];
        rt.layer.anchorPoint = CGPointMake(0.5,1);
        rt.layer.transform = CATransform3DMakeScale(0.1 + i*0.2, 0.1 + i * 0.2, 1);
        rt.translationX = i * 150;
        rt.translationY = i * 65;
        rt.scale = 0.1 + i * 0.2;
        rt.image = img;
        [self.view addSubview:rt];
        [self.rightItems addObject:rt];
        
        GameImageView *lt = [[GameImageView alloc] initWithFrame:CGRectMake(330 - i * 133, 430 + i * 65, 174 , 146)];
        lt.layer.anchorPoint = CGPointMake(0.5, 1);
        lt.layer.transform = CATransform3DMakeScale(0.1 + i * 0.2, 0.1 + i * 0.2, 1);
        lt.translationX = - i * 133;
        lt.translationY = i * 65;
        lt.scale = 0.1 + i * 0.2;
        lt.image = img;
        [self.view addSubview:lt];
        
        [self.leftItems addObject:lt];
    }
}

- (void)upLoadRuningData
{
//    CAAnimation *scale = [treeRight.layer animationForKey:@"scale"];
//    scale.duration = 0.1;
//    return;
    
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
