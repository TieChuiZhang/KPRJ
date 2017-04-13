//
//  RegisterViewController.h
//  发票项目
//
//  Created by Lee on 17/3/2.
//  Copyright © 2017年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *codeTextField;
@property (nonatomic, strong) UIButton *registerButton;
@property (nonatomic, strong) UIButton *getCodeButton;
@property (nonatomic, assign) NSUInteger timeTick;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UITextField *resetPwdTextField;
@property (nonatomic, strong) UIImageView * image;
@property (nonatomic, strong) UIView *mainView;

@property (nonatomic, strong) UIView      *mainHorizontalLine;

@property (nonatomic, strong) UIView      *mainHorizontalLineTwo;

/**
 *
 * 账号输入框整个左视图
 *
 */
@property (nonatomic, strong) UIView *userNameView;
@property (nonatomic, strong) UIImageView *name;
@property (nonatomic, strong) UIView *userNameVerticalLine;

/**
 *
 * 密码输入框整个左视图
 *
 */
@property (nonatomic, strong) UIView *userPassWdView;
@property (nonatomic, strong) UIImageView *passWdImage;
@property (nonatomic, strong) UIView *userPassWdVerLine;


/**
 *
 * 验证码输入框的左视图
 *
 */
@property (nonatomic, strong) UIView *codeTextView;
@property (nonatomic, strong) UIImageView *codeTextViewImage;
@property (nonatomic, strong) UIView *codeTextViewVerticalLine;

#pragma mark - *** 右上角退出
@property (nonatomic, strong) UIButton *exitBtn;

@end
