//
//  FriendsViewController.h
//  HappyRunner
//
//  Created by chinatsp on 13-10-13.
//  Copyright (c) 2013年 chinatsp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendsViewController : UIViewController
{
    IBOutlet UITextField *searchField;
    IBOutlet UITextField *inputField;
    
    IBOutlet UITableView *friendsTableView;
    IBOutlet UITableView *chatTableView;
    
    
}

- (IBAction)addAction:(id)sender;
- (IBAction)searchAction:(id)sender;
- (IBAction)backAction:(id)sender;

@end
