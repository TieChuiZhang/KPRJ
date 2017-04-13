//
//  RegisterViewController.m
//  发票项目
//
//  Created by Lee on 17/3/2.
//  Copyright © 2017年 Lee. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   self.view.backgroundColor = [UIColor colorWithRed:212.f/255.f green:220.f/255.f blue:225.f/255.f alpha:1];
    _image=[UIImageView new];
    _image.frame = CGRectMake(KWidth*3/8, KHeight/8, KWidth/4, KWidth/4);
    _image.image=[UIImage imageNamed:@"logo"];
    [self.view addSubview:self.image];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIView *)mainView {
    if (!_mainView) {
        _mainView = [UIView new];
        [_mainView setFrame:CGRectMake(0, KHeight/4 +30, KWidth, KHeight/6)];
        _mainView.backgroundColor = [UIColor whiteColor];
        _mainView.alpha = 0.6;
    }
    return _mainView;
}

#pragma mark - *** 整个账号输入框左视图
- (UIView *)userNameView {
    if (!_userNameView) {
        _userNameView = [UIView new];
        [_userNameView setFrame:CGRectMake(4, 0, KHeight/25 +15, KHeight/25)];
    }
    return _userNameView;
}
- (UIImageView *)name{
    if (!_name) {
        _name = [UIImageView new];
        [_name setFrame:CGRectMake(4, 0, KHeight/25, KHeight/25)];
        [_name.layer setContents:(__bridge id _Nullable)([UIImage imageNamed:@"用户名"].CGImage)];
    }
    return _name;
}
- (UIView *)userNameVerticalLine {
    if (!_userNameVerticalLine) {
        _userNameVerticalLine = [UIView new];
        [_userNameVerticalLine setFrame:CGRectMake(KHeight/25+6, 0, 1, KHeight/25)];
        [_userNameVerticalLine setBackgroundColor:[UIColor whiteColor]];
    }
    return _userNameVerticalLine;
}
- (UITextField *)nameTextField {
    if (!_nameTextField) {
        _nameTextField = [UITextField new];
        [_nameTextField setFrame:CGRectMake(0, 0, _mainView.bounds.size.width, _mainView.bounds.size.height/3)];
        [_nameTextField setBackgroundColor:[UIColor clearColor]];
        [_nameTextField setLeftView:_userNameView];
        [_nameTextField setFont:littleFont];
        [_nameTextField setLeftViewMode:UITextFieldViewModeAlways];
        //[_nameTextField.layer setCornerRadius:3.f];
        [_nameTextField setPlaceholder:@"用户名/昵称"];
        [_nameTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [_nameTextField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
        [_nameTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    }
    return _nameTextField;
}
// 横线
- (UIView *)mainHorizontalLine {
    if (!_mainHorizontalLine) {
        _mainHorizontalLine = [UIView new];
        [_mainHorizontalLine setFrame:CGRectMake(_nameTextField.frame.origin.x, _nameTextField.frame.origin.y + _nameTextField.frame.size.height, _mainView.frame.size.width, 1)];
        [_mainHorizontalLine setBackgroundColor: [UIColor lightGrayColor]];
    }
    return _mainHorizontalLine;
}
#pragma mark - *** 密码输入框左视图
- (UIView *)userPassWdView {
    if (!_userPassWdView) {
        _userPassWdView = [UIView new];
        [_userPassWdView setFrame:CGRectMake(4, (_mainView.frame.size.height/3)*2, KHeight/25+15, KHeight/25)];
        
    }
    return _userPassWdView;
}
- (UIImageView *)passWdImage {
    if (!_passWdImage) {
        _passWdImage = [UIImageView new];
        [_passWdImage setFrame:CGRectMake(4, 0, KHeight/25, KHeight/25)];
        [_passWdImage.layer setContents:(__bridge id _Nullable)([UIImage imageNamed:@"密码"].CGImage)];
    }
    return _passWdImage;
}
- (UIView *)userPassWdVerLine {
    if (!_userPassWdVerLine) {
        _userPassWdVerLine = [UIView new];
        [_userPassWdVerLine setFrame:CGRectMake(KHeight/25+6, 0, 1, KHeight/25)];
        [_userPassWdVerLine setBackgroundColor:[UIColor whiteColor]];
    }
    return _userPassWdVerLine;
}
- (UITextField *)resetPwdTextField {
    if (!_resetPwdTextField) {
        _resetPwdTextField = [UITextField new];
        [_resetPwdTextField setFrame:CGRectMake(0, _nameTextField.frame.origin.y+_nameTextField.frame.size.height , KWidth, _mainView.bounds.size.height/3)];
        [_resetPwdTextField setBackgroundColor:[UIColor clearColor]];
        [_resetPwdTextField setLeftView:_userPassWdView];
        [_resetPwdTextField setLeftViewMode:UITextFieldViewModeAlways];
        [_resetPwdTextField setPlaceholder:@"密码"];
        [_resetPwdTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [_resetPwdTextField setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        //[_resetPwdTextField.layer setCornerRadius:3.f];
        [_resetPwdTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_resetPwdTextField setSecureTextEntry:YES];
    }
    return _resetPwdTextField;
}
// 横线
- (UIView *)mainHorizontalLineTwo {
    if (!_mainHorizontalLineTwo) {
        _mainHorizontalLineTwo = [UIView new];
        [_mainHorizontalLineTwo setFrame:CGRectMake(_resetPwdTextField.frame.origin.x, _resetPwdTextField.frame.origin.y + _resetPwdTextField.frame.size.height, _mainView.frame.size.width, 1)];
        [_mainHorizontalLineTwo setBackgroundColor:[UIColor lightGrayColor]];
        }
        return _mainHorizontalLineTwo;
}
#pragma mark - *** 验证码输入框左视图
- (UIView *)codeTextView {
    if (!_codeTextView) {
        _codeTextView = [UIView new];
        [_codeTextView setFrame:CGRectMake(4, (_mainView.frame.size.height/3)*2, KHeight/25+15, KHeight/25)];
    }
    return _codeTextView;
}
- (UIImageView *)codeTextViewImage {
    if (!_codeTextViewImage) {
        _codeTextViewImage  = [UIImageView new];
        [_codeTextViewImage setFrame:CGRectMake(4, 0, KHeight/25, KHeight/25)];
        [_codeTextViewImage.layer setContents:(__bridge id _Nullable)([UIImage imageNamed:@"验证码"].CGImage)];
    }
    return _codeTextViewImage;
}
- (UITextField *)codeTextField {
    if (!_codeTextField) {
        _codeTextField = [UITextField new];
        [_codeTextField  setFrame:CGRectMake(0, _resetPwdTextField.frame.origin.y+_nameTextField.frame.size.height, KWidth*0.68, _mainView.bounds.size.height/3)];
        [_codeTextField setBackgroundColor:[UIColor clearColor]];
        //[_codeTextField.layer setCornerRadius:3.f];
        [_codeTextField setLeftView:_codeTextView];
        [_codeTextField setFont:littleFont];
        [_codeTextField setLeftViewMode:UITextFieldViewModeAlways];
        [_codeTextField setPlaceholder:@"请输入验证码"];
        [_codeTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [_codeTextField setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        [_codeTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    }
    return _codeTextField;
}
- (UIButton *)getCodeButton {
    if (!_getCodeButton) {
        _getCodeButton = [UIButton new];
        [_getCodeButton  setFrame:CGRectMake(KWidth * 0.7,_resetPwdTextField.frame.origin.y+_nameTextField.frame.size.height+2, KWidth*0.29, _mainView.bounds.size.height/3.2)];
        [_getCodeButton setBackgroundColor:[UIColor whiteColor]];
        _getCodeButton.alpha = 0.6;
        [_getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getCodeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_getCodeButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
        //[_getCodeButton.layer setCornerRadius:3.f];
        [_getCodeButton addTarget:self action:@selector(tapCodeBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getCodeButton;
}
#pragma mark - *** 注册
- (UIButton *)registerButton {
    if (!_registerButton) {
        _registerButton = [UIButton new];
        [_registerButton setFrame:CGRectMake(KWidth*0.025,_mainView.frame.origin.y + _nameTextField.frame.size.height * 3.8 , KWidth-((KWidth *0.025)*2), _mainView.frame.size.height/3)];
        [_registerButton setTitle:@"注    册" forState:UIControlStateNormal];
        [_registerButton.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
        [_registerButton.layer setCornerRadius:5.f];
        [_registerButton setBackgroundColor:[UIColor colorWithRed:74/255.0 green:99/255.0 blue:146/255.0 alpha:1]];
        //[_registerButton.layer setCornerRadius:3.f];
        [_registerButton addTarget:self action:@selector(tapRegisterBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}
- (UIButton *)exitBtn {
    if (!_exitBtn) {
        _exitBtn = [UIButton new];
        [_exitBtn setFrame:CGRectMake(KWidth - 25 , 30, 15, 15)];
        [_exitBtn setImage:[UIImage imageNamed:@"叉子删除"] forState:UIControlStateNormal];
        [_exitBtn addTarget:self action:@selector(tapExitBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exitBtn;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        [self.view addSubview:self.mainView];
        
        [self.mainView addSubview:self.userNameView];
        [self.userNameView addSubview:self.name];
        //[self.userNameView addSubview:self.userNameVerticalLine];
        [self.mainView addSubview:self.nameTextField];
        [self.mainView addSubview:self.mainHorizontalLine];
        
        [self.mainView addSubview:self.userPassWdView];
        [self.userPassWdView addSubview:self.passWdImage];
        //[self.userPassWdView addSubview:self.userPassWdVerLine];
        [self.mainView addSubview:self.resetPwdTextField];
        [self.mainView addSubview:self.mainHorizontalLineTwo];
        
        [self.mainView addSubview:self.codeTextView];
        [self.codeTextView addSubview:self.codeTextViewImage];
        [self.mainView addSubview:self.codeTextField];
        [self.mainView addSubview:self.getCodeButton];
        
        [self.view addSubview:self.registerButton];
        [self.view addSubview:self.exitBtn];
    }
    return self;
}

- (void)tapRegisterBtn:(UIButton *)sender{
    
}
- (void)tapExitBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (void)tapCodeBtn:(UIButton *)sender {
    
}

@end
