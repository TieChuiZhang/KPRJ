//
//  ForgetViewController.h
//  发票项目
//
//  Created by Lee on 17/3/2.
//  Copyright © 2017年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuthCodeView.h"

@interface ForgetViewController : UIViewController<UITextFieldDelegate>
# pragma mark - *** nav
@property (nonatomic, strong) UIButton *exitBtn;
@property (nonatomic, strong) UIButton *subBtn;
@property (nonatomic, strong) UIView *navView;
# pragma mark - *** TextField
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *codeTextField;
@property (nonatomic, strong) UIView *mainHorizontalLine;
# pragma mark - *** 整个view
@property (nonatomic, strong) UIView *mainView;
# pragma mark - *** 验证码输入框/View/验证码
@property (nonatomic, strong) UIView *codeTextView;
@property (nonatomic, strong) UIImageView *codeTextViewImage;
@property (nonatomic, strong) AuthCodeView *authCodeView;
# pragma mark - *** 账号输入框/View
@property (nonatomic, strong) UIView *userNameView;
@property (nonatomic, strong) UIImageView *name;

@end
