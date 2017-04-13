//
//  LogInViewController.m
//  开票软件
//
//  Created by Lee on 17/3/26.
//  Copyright © 2017年 Lee. All rights reserved.
//

#import "LogInViewController.h"

#import "OrdinaryViewController.h"
#import "CodeViewController.h"
@interface LogInViewController ()

@end

@implementation LogInViewController
- (LoginModel *)logModel {
    if (!_logModel) {
        _logModel = [LoginModel new];
    }
    return _logModel;
}
- (void)setUpLayout {
    // 设置登录界面的头像
    _image=[UIImageView new];
    _image.frame = CGRectMake(KWidth*3/8, KHeight/8, KWidth/4, KWidth/4);
    //    _image.layer.borderWidth=1;
    //    _image.layer.borderColor=[UIColor whiteColor].CGColor;
    _image.image=[UIImage imageNamed:@"logo"];
    [self.view addSubview:_image];
    /**
     *
     *账号输入框
     *
     */
    
    // 包含两个输入框的视图
    _mainView = [UIView new];
    _mainView.frame = CGRectMake(0, KHeight/4 +30, KWidth,
                                 KHeight/9);
    //_mainView.layer.cornerRadius = 3;
    //_mainView.backgroundColor = [UIColor colorWithRed:144/225.0 green:144/255.0 blue:144/255.0 alpha:0.4];
    _mainView.backgroundColor = [UIColor whiteColor];
    _mainView.alpha = 0.6;
    //  左边的图片
    _name = [UIImageView new];
    _name.frame = CGRectMake(4, 0, KHeight/25,
                             KHeight/25);
    _name.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"用户名"].CGImage);
    
    // 中间的竖线
    /*
    _userNameVerticalLine = [UIView new];
    _userNameVerticalLine.frame = CGRectMake(_name.frame.size.width+_name.frame.origin.x + 2, _name.frame.origin.y, 1, _name.frame.size.height);
    _userNameVerticalLine.backgroundColor = [UIColor whiteColor];
     */
    
    //整个左视图
    _userNameView = [UIView new];
    _userNameView.frame = CGRectMake(_name.frame.origin.x, _name.frame.origin.y, _name.frame.size.width, _name.frame.size.height);
    [_userNameView addSubview:_name];
    //[_userNameView addSubview:_userNameVerticalLine];
    
    // 账号
    _phoneN = [UITextField new];
    
    _phoneN.frame = CGRectMake(0, 0, _mainView.bounds.size.width, _mainView.bounds.size.height/2);
    _phoneN.placeholder = @"用户名";
    [_phoneN setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_phoneN setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    _phoneN.leftView = _userNameView;
    _phoneN.backgroundColor = [UIColor clearColor];
    _phoneN.leftViewMode = UITextFieldViewModeAlways;
    _phoneN.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;  //垂直居中
    _phoneN.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_mainView addSubview:_phoneN];
    
    //横线
    _mainHorizontalLine = [UIView new];
    _mainHorizontalLine.frame = CGRectMake(_phoneN.frame.origin.x,  _phoneN.frame.size.height, _mainView.frame.size.width, 1);
    _mainHorizontalLine.backgroundColor = [UIColor lightGrayColor];
    [_mainView addSubview:_mainHorizontalLine];
    
    /**
     *
     *密码输入框
     *
     */
    // 左图片
    _mima = [UIImageView new];
    _mima.frame = CGRectMake(4, 0, KHeight/25, KHeight/25);
    _mima.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"密码"].CGImage);
    
    // 竖线
    /*
    _userPasswordVerticalLine = [UIView new];
    _userPasswordVerticalLine.frame = CGRectMake(_mima.frame.size.width+_mima.frame.origin.x+2, _mima.frame.origin.y, 1, _mima.frame.size.height);
    _userPasswordVerticalLine.backgroundColor = [UIColor whiteColor];
     */
    
    // 整个左视图
    _userPasswordView = [UIView new];
    _userPasswordView.frame = CGRectMake(_mima.frame.origin.x, _mima.frame.origin.y, _mima.frame.size.width , _mima.frame.size.height);
    [_userPasswordView addSubview:_mima];
    //[_userPasswordView addSubview:_userPasswordVerticalLine];
    
    //密码输入框
    _passWord = [UITextField new];
    _passWord.frame = CGRectMake(0, KHeight/18+1, KWidth *0.7, _mainView.bounds.size.height/2 );
    _passWord.placeholder = @"请输入验证码";
    [_passWord setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_passWord setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    _passWord.leftView = _userPasswordView;
    _passWord.backgroundColor = [UIColor clearColor];
    _passWord.leftViewMode = UITextFieldViewModeAlways;
    _passWord.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _passWord.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passWord.secureTextEntry = YES;
    
    [_mainView addSubview:_passWord];
    [self.view addSubview:_mainView];
}

- (UIButton *)getCodeBtn {
    if (!_getCodeBtn) {
        _getCodeBtn = [UIButton new];
        [_getCodeBtn setFrame:CGRectMake(KWidth*0.7+2, KHeight/18+1, KWidth*0.3-2, _mainView.bounds.size.height/2)];
        [_getCodeBtn setBackgroundColor:[UIColor redColor]];
        [_getCodeBtn addTarget:self action:@selector(tapCodeBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getCodeBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    }
    return _getCodeBtn;
}

- (void)tapCodeBtn:(UIButton *)sender {
    // 把键盘消失
    [self.phoneN resignFirstResponder];
    
    // 1.判断是否输入的手机号正确（为空或者不符合格式）
    
    // 手机号不正确
    
    // 弹窗提示
    
    BOOL isOK = [self.logModel checkPhoneNumber:self.phoneN.text];
    
    if (isOK == NO) {
        SHOW_TEXT(@"请填写正确的手机号");
    } else {
        // 手机号正确
        
        // 计时器开始工作，按钮不可交互
        self.getCodeBtn.enabled = NO;
        self.timeTick = 61;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFireMethod) userInfo:nil repeats:YES];
        // 调用方法去服务器获取验证码！！！！！！！！！！！！！！！！！！！！
        [_logModel sendCodeRequestPhoneNumber:_phoneN.text LoginHandler:^(NSDictionary *dic) {
            
        } ErrorHandler:^(NSError *error) {
            
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self logModel];
    self.view.backgroundColor = [UIColor colorWithRed:212.f/255.f green:220.f/255.f blue:225.f/255.f alpha:1];
    [self setUpLayout];
    [self.mainView addSubview:self.getCodeBtn];
    [self.view addSubview:self.logInBtn];
    [self.view addSubview:self.zwView];
    [self.zwView addSubview:self.zwViewLine];
    [self.zwView addSubview:self.wangjimima];
    [self.zwView addSubview:self.zhuce];
}

- (instancetype)init {
    self = [super init];
    if (self) {
    
    }
    return self;
}
- (UIButton *)logInBtn {
    if (!_logInBtn) {
        _logInBtn = [UIButton new];
        [_logInBtn setFrame:CGRectMake(KWidth *0.025, _mainView.frame.origin.y + _mainView.frame.size.height + _name.frame.size.height*0.5, KWidth-((KWidth *0.025)*2), _mainView.frame.size.height/2)];
        [_logInBtn setBackgroundColor:[UIColor colorWithRed:74/255.0 green:99/255.0 blue:146/255.0 alpha:1]];
        [_logInBtn.layer setCornerRadius:5.f];
        [_logInBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [_logInBtn setTitle:@"登    录" forState:UIControlStateNormal];
        [_logInBtn addTarget:self action:@selector(logIn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logInBtn;
}
# pragma - make 注册Btn/忘记密码Btn/忘记密码View/View上边的竖线
-(UIView *)zwView {
    if (!_zwView) {
        _zwView = [UIView new];
        [_zwView setFrame:CGRectMake(KWidth * 0.125,KHeight - 30 ,KWidth * 0.75, 30)];
    }
    return _zwView;
}
- (UIView *)zwViewLine{
    if (!_zwViewLine) {
        _zwViewLine = [UIView new];
        [_zwViewLine setFrame:CGRectMake(_zwView.frame.size.width/2 ,10, 1, 10)];
        _zwViewLine.backgroundColor = [UIColor lightGrayColor];
    }
    
    return _zwViewLine;
}
- (UIButton *)zhuce {
    if (!_zhuce) {
        _zhuce = [UIButton new];
        [_zhuce setFrame:CGRectMake(_zwView.frame.size.width/2 - 70,0 , 70, 30)];
        [_zhuce setTitle:@"注册账号" forState:UIControlStateNormal];
        [_zhuce setTitleColor:[UIColor colorWithRed:74/255.0 green:99/255.0 blue:146/255.0 alpha:1] forState:UIControlStateNormal];
        [_zhuce setBackgroundColor:[UIColor clearColor]];
        [_zhuce.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [_zhuce addTarget:self action:@selector(tapRegisterBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _zhuce;
}
- (UIButton *)wangjimima {
    if (!_wangjimima) {
        _wangjimima = [UIButton new];
        [_wangjimima setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_wangjimima.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [_wangjimima setTitleColor:[UIColor colorWithRed:74/255.0 green:99/255.0 blue:146/255.0 alpha:1] forState:UIControlStateNormal];
        [_wangjimima setFrame:CGRectMake(_zwView.frame.size.width/2 + 1,0 , 70, 30)];
        [_wangjimima addTarget:self action:@selector(tapForgetBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wangjimima;
}

# pragma - make 登录注册忘记密码方法
- (void)logIn:(UIButton *)sender {
    OrdinaryViewController *ordVC = [OrdinaryViewController new];
    [self presentViewController:ordVC animated:YES completion:^{
        
    }];
    [self.passWord resignFirstResponder];
    
    BOOL isOK = [_logModel checkPhoneNumber:self.phoneN.text];
    if ([_phoneN.text isEqualToString:@""]) {
        SHOW_TEXT(@"请输入验证码");
    }else if ([_passWord.text isEqualToString:@""]) {
        SHOW_TEXT(@"请输入手机号")
    }else if (isOK) {
        
            [_logModel logInRequestPhoneNumber:_phoneN.text CodeNumber:_passWord.text LoginHandler:^(NSDictionary *dic) {
                OrdinaryViewController *ordVC = [OrdinaryViewController new];
                [self presentViewController:ordVC animated:YES completion:^{
                    
                }];
                if ([dic[@"state"] isEqualToString:@"success"]) {
                    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                    
                    [userDefault setObject:dic[@"sessionId"] forKey:@"sessionId"];
                    
                }else if ([dic[@"state"] isEqualToString:@"error"]) {
                   
                    dispatch_async(dispatch_get_main_queue(), ^ {
                        //SHOW_TEXT(@"验证码有误啊");
                        
                         });
                  
                }
            } ErrorHandler:^(NSError *error) {
                
            }];
    }
}
- (void)timerFireMethod {
    self.timeTick--;
    if (self.timeTick == 0) {
        [self.timer invalidate];
        self.getCodeBtn.enabled = YES;
        [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getCodeBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
        self.timeTick = 61;
    } else {
        NSString *str = [NSString stringWithFormat:@"%ld秒后重新获取",(unsigned long)self.timeTick];
        [_getCodeBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [self.getCodeBtn setTitle:str forState:UIControlStateNormal];
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (void)tapExitBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
