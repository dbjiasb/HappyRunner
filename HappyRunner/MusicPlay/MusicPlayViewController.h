//
//  MusicPlayViewController.h
//  HappyRunner
//
//  Created by chinatsp on 13-10-13.
//  Copyright (c) 2013年 chinatsp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicPlayViewController : UIViewController
{
    IBOutlet UILabel *playingLabel;
    
    IBOutlet UITableView *_tableView;
}

- (IBAction)controlAction:(id)sender;

- (IBAction)backAction:(id)sender;

@end
