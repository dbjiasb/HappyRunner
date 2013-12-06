//
//  HealthComomSenceViewController.m
//  HappyRunner
//
//  Created by chinatsp on 13-10-13.
//  Copyright (c) 2013年 chinatsp. All rights reserved.
//

#import "HealthComomSenceViewController.h"

@interface HealthComomSenceViewController ()

@property (nonatomic, retain) NSArray *dataList;

@end

@implementation HealthComomSenceViewController

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
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    
    [self getHealthComomSence];
}

- (void)getHealthComomSence
{
    
    KnowledgeReq *req = [[KnowledgeReq alloc] init];
    req.USER_ID = [MyDefaults getUserID] ? [MyDefaults getUserID] : @"20";
    
    [[DHSocket shareSocket] invokeWithReq:req delegate:(id<DHSocketDelegate>)self];
}

- (void)socketDidRecvMessage:(id)result
{
    KnowledgeResp *resp = (KnowledgeResp *)result;
    if (resp.KNOWLEDGES.count > 0) {
        self.dataList = resp.KNOWLEDGES;
        
        [_tableView reloadData];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text = @"健康常识";
    
    return cell;
}


@end
