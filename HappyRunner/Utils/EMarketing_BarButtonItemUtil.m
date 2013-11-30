//
//  EMarketing_BarButtonItemUtil.m
//  eMarketingProject
//
//  Created by liu zhiliang on 13-3-2.
//  Copyright (c) 2013年 eshore. All rights reserved.
//

#import "EMarketing_BarButtonItemUtil.h"

@implementation UIBarButtonItem (EMarketing_Customized)

+ (id)buttonWithImageName:(NSString *)imageName target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageUtilName:imageName];
    NSString *downName = [NSString stringWithFormat:@"%@_down",imageName];
    UIImage *imageDown = [UIImage imageUtilName:downName];
    
    button.frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
    [button setNormalImage:image];
    [button setHighlightedImage:imageDown];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, image.size.width, image.size.height)];
    [view addSubview:button];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:view];

    return backItem ;
}

+ (id)buttonWithTitle:(NSString *)title imageName:(NSString *)imageName target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:imageName];
//    NSString *downName = [NSString stringWithFormat:@"%@_down",imageName];
//    UIImage *imageDown = [UIImage imageUtilName:downName];
    
    button.frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
    [button setNormalBgImage:image];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [button setTitleColor:RGBCOLOR(63, 78, 92) forState:UIControlStateNormal];
    [button setNormalTitle:title];
//    [button setHighlightedBgImage:imageDown];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, image.size.width, image.size.height)];
    [view addSubview:button];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:view];

    return backItem ;
}

float fHeight = 32;
float fMinWidth = 51 - 3;

+ (id)backButtonWithTitle:(NSString *)title imageName:(NSString *)imageName target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageUtilName:imageName];
    NSString *downName = [NSString stringWithFormat:@"%@_down",imageName];
    UIImage *imageDown = [UIImage imageUtilName:downName];
    
    button.frame = CGRectMake(0, 4, 60, fHeight);
    button.titleLabel.font = [UIFont systemFontOfSize:13];
	button.titleLabel.backgroundColor =[UIColor clearColor];
    CGSize cs = [title sizeWithFont:[UIFont boldSystemFontOfSize:14]];
    float width = cs.width > 43 ? (14 + cs.width) : (43 + 14);
    [button setNormalBgImage:[image stretchableImageWithLeftCapWidth:17 topCapHeight:0]];
    [button setNormalTitle:title];
    [button setHighlightedBgImage:[imageDown stretchableImageWithLeftCapWidth:17 topCapHeight:0]];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 5.0, width, fHeight);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    button.titleLabel.shadowColor = [UIColor blackColor];
	button.titleLabel.shadowOffset = CGSizeMake(0.2, -1);
	button.titleLabel.textAlignment = NSTextAlignmentCenter;
	UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];	
	return backItem ;
}

+ (id)editButtonWithTitle:(NSString *)title imageNames:(NSArray *)imageNames target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageUtilName:imageNames[0]];
    UIImage *imageHL = [UIImage imageUtilName:imageNames[1]];
    
    button.frame = CGRectMake(0, 0, 56, 32);
    button.titleLabel.font = [UIFont systemFontOfSize:14];
	button.titleLabel.backgroundColor =[UIColor clearColor];
    CGSize cs = [title sizeWithFont:[UIFont systemFontOfSize:14]];
    float width = cs.width < 56 ? 56 : cs.width;
    [button setNormalBgImage:[image stretchableImage]];
    [button setNormalTitle:title];
    [button setSelectedBgImage:[imageHL stretchableImage]];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, width, 32);
    button.titleLabel.shadowColor = [UIColor blackColor];
	button.titleLabel.shadowOffset = CGSizeMake(0.2, -1);
	button.titleLabel.textAlignment = NSTextAlignmentCenter;
	UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
	return backItem ;
}

@end
