//
//  LogInViewController.h
//  开票软件
//
//  Created by Lee on 17/3/26.
//  Copyright © 2017年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginModel.h"
@interface LogInViewController : UIViewController
@property (nonatomic, strong) LoginModel *logModel;

@property (nonatomic, strong) UIImageView * image;
//
@property (nonatomic, strong) UIButton    *zhuce;
@property (nonatomic, strong) UIButton    *wangjimima;
@property (nonatomic, strong) UIButton    *logInBtn;
@property (nonatomic, strong) UIView      *zwView;
@property (nonatomic, strong) UIView      *zwViewLine;


// 账号输入框
@property (nonatomic, strong) UIView      *userNameVerticalLine;
@property (nonatomic, strong) UITextField *phoneN;
@property (nonatomic, strong) UIImageView *name;
@property (nonatomic, strong) UIView      *userNameView;

@property (nonatomic, strong) UIButton    *iconBtn;
@property (nonatomic, strong) UIView      *mainView;
@property (nonatomic, strong) UIView      *mainHorizontalLine;

// 密码输入框
@property (nonatomic, strong) UIImageView *mima;
@property (nonatomic, strong) UIView      *userPasswordVerticalLine;//
@property (nonatomic, strong) UIView      *userPasswordView;
@property (nonatomic, strong) UITextField *passWord;
@property (nonatomic, strong) UIButton *getCodeBtn;


// 计时器
@property (nonatomic, strong) NSTimer *timer;
// 显示的倒计时的数字
@property (nonatomic, assign) NSUInteger timeTick;

@end
