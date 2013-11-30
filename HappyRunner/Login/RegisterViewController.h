//
//  RegisterViewController.h
//  HappyRunner
//
//  Created by chinatsp on 13-10-13.
//  Copyright (c) 2013年 chinatsp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController
{
    IBOutlet UITextField *accountText;
    IBOutlet UITextField *passwordText;
    IBOutlet UITextField *surePsdText;
    
    IBOutlet UITextField *nicknameText;
    IBOutlet UITextField *emailText;
    IBOutlet UITextField *phoneText;
}

- (IBAction)backAction:(UIButton *)button;
- (IBAction)registerAction:(UIButton *)sender;

@end
