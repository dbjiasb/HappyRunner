//
//  EMarketing_BarButtonItemUtil.h
//  eMarketingProject
//
//  Created by liu zhiliang on 13-3-2.
//  Copyright (c) 2013年 eshore. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BARKBARWIDTH 50.0
#define BARWIDTH 61.0
#define BARHEIGHT 30.0

//[_editButton setBackgroundImage:[[UIImage imageUtilName:@"barBg@2x"] resizableImageWithCapInsets:UIEdgeInsetsMake(5.0f,5.0f, 5.0f, 5.0f)] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];

#define BARBUTTONITEM(TITLE, SELECTOR)	[[[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR] autorelease]//UIBarButtonItem

#define BARBUTTONITEMIMAGE(IMAGENAME, SELECTOR) [[[UIBarButtonItem alloc] initWithImage:[UIImage imageUtilName:IMAGENAME] style:UIBarButtonItemStylePlain target:self action:SELECTOR] autorelease]

#define BARBUTTONITEMDONE(TITLE, SELECTOR)	[[[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStyleDone target:self action:SELECTOR] autorelease]//UIBarButtonItem

#define BARBTNIMAGE(IMAGENAME, SELECTOR) [UIBarButtonItem buttonWithImageName:IMAGENAME target:self action:SELECTOR];

@interface UIBarButtonItem (EMarketing_Customized)

+ (id)buttonWithImageName:(NSString *)imageName target:(id)target action:(SEL)action;

+ (id)buttonWithTitle:(NSString *)title imageName:(NSString *)imageName target:(id)target action:(SEL)action;

+ (id)backButtonWithTitle:(NSString *)title imageName:(NSString *)imageName target:(id)target action:(SEL)action;

+ (id)editButtonWithTitle:(NSString *)title imageNames:(NSArray *)imageNames target:(id)target action:(SEL)action;

@end
