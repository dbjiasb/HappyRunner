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
}
@end

@implementation GameChooseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    imgv.image = [UIImage imageNamed:@"scene_1.jpg"];
    [self.view addSubview:imgv];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    backBtn.backgroundColor = [UIColor blackColor];
    [backBtn setFrame:CGRectMake(70, 20, 80, 45)];
    [backBtn setTitle:@"菜单" forState:UIControlStateNormal];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"btn_menu_1.png"] forState:UIControlStateNormal];
    [self.view addSubview:backBtn];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self loadRunner];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadRunner
{
    runnerView = [[UIImageView alloc] initWithFrame:CGRectMake(442, 340, 170 * 0.8, 400 * 0.8)];
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
