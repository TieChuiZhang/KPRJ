//
//  ForgetViewController.m
//  发票项目
//
//  Created by Lee on 17/3/2.
//  Copyright © 2017年 Lee. All rights reserved.
//

#import "ForgetViewController.h"


@interface ForgetViewController ()

@end

@implementation ForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:212.f/255.f green:220.f/255.f blue:225.f/255.f alpha:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIView *)navView {
    if (!_navView) {
        _navView = [UIView new];
        [_navView setFrame:CGRectMake(0, 0, KWidth, 64)];
        [_navView setBackgroundColor:[UIColor colorWithRed:74/255.0 green:100/255.0 blue:146/255.0 alpha:1]];
    }
    return _navView;
}
- (UIButton *)exitBtn {
    if (!_exitBtn) {
        _exitBtn = [UIButton new];
        [_exitBtn setFrame:CGRectMake(KWidth -(KWidth - 12), 30, 40, 15)];
        [_exitBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [_exitBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_exitBtn addTarget:self action:@selector(tapExitBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exitBtn;
}
- (UIButton *)subBtn {
    if (!_subBtn) {
        _subBtn = [UIButton new];
        [_subBtn setFrame:CGRectMake(KWidth - 52 , 30, 40, 15)];
        [_subBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_subBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [_subBtn addTarget:self action:@selector(tapSubBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _subBtn;
}
- (UIView *)mainView {
    if (!_mainView) {
        _mainView = [UIView new];
        [_mainView setFrame:CGRectMake(0, KHeight/4 - 30, KWidth, KHeight/9)];
        [_mainView setBackgroundColor:[UIColor whiteColor]];
        _mainView.alpha = 0.6;
    }
    return _mainView;
}

# pragma mark - *** 整个账号输入框左视图
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
- (UITextField *)nameTextField {
    if (!_nameTextField) {
        _nameTextField = [UITextField new];
        [_nameTextField setFrame:CGRectMake(0, 0, _mainView.bounds.size.width, _mainView.bounds.size.height/2)];
        [_nameTextField setBackgroundColor:[UIColor clearColor]];
        [_nameTextField setLeftView:_userNameView];
        [_nameTextField setLeftViewMode:UITextFieldViewModeAlways];
        //[_nameTextField.layer setCornerRadius:3.f];
        [_nameTextField setPlaceholder:@"用户名/昵称"];
        [_nameTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [_nameTextField setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        [_nameTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    }
    return _nameTextField;
}
# pragma mark - *** 横线
- (UIView *)mainHorizontalLine {
    if (!_mainHorizontalLine) {
        _mainHorizontalLine = [UIView new];
        [_mainHorizontalLine setFrame:CGRectMake(_nameTextField.frame.origin.x, _nameTextField.frame.origin.y + _nameTextField.frame.size.height, _mainView.frame.size.width, 1)];
        _mainHorizontalLine.backgroundColor = [UIColor lightGrayColor];
        [_mainHorizontalLine setBackgroundColor:[UIColor lightGrayColor]];
    }
    return _mainHorizontalLine;
}
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
        [_codeTextField  setFrame:CGRectMake(0, _nameTextField.frame.origin.y+_nameTextField.frame.size.height, KWidth*0.68, _mainView.bounds.size.height/2)];
        [_codeTextField setBackgroundColor:[UIColor clearColor]];
        _codeTextField.delegate = self;
        //[_codeTextField.layer setCornerRadius:3.f];
        [_codeTextField setLeftView:_codeTextView];
        [_codeTextField setFont:[UIFont systemFontOfSize:14]];
        [_codeTextField setLeftViewMode:UITextFieldViewModeAlways];
        [_codeTextField setPlaceholder:@"请输入验证码(区分大小写)"];
        [_codeTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [_codeTextField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
        [_codeTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    }
    return _codeTextField;
}
- (AuthCodeView *)authCodeView {
    if (!_authCodeView) {
        _authCodeView = [AuthCodeView new];
        [_authCodeView  setFrame:CGRectMake(KWidth * 0.7,_nameTextField.frame.origin.y + _nameTextField.frame.size.height, KWidth*0.29, _mainView.bounds.size.height/2)];
    }
    return _authCodeView;
}

- (void)tapExitBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)tapSubBtn:(UIButton *)sender {
    /*
    if ([_codeTextField.text isEqualToString:_authCodeView.authCodeStr]) {
        UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"恭喜" message:@"验证成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alView show];
    }else {
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        anim.repeatCount = 1;
        anim.values = @[@-20,@20,@-20];
        [_codeTextField.layer addAnimation:anim forKey:nil];
    }
*/
    
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self.view addSubview:self.navView];
        [self.navView addSubview:self.exitBtn];
        [self.navView addSubview:self.subBtn];
        
        [self.view addSubview:self.mainView];
        
        [self.mainView addSubview:self.userNameView];
        [self.userNameView addSubview:self.name];
        [self.mainView addSubview:self.nameTextField];
        [self.mainView addSubview:self.mainHorizontalLine];
        
        [self.mainView addSubview:self.codeTextView];
        [self.codeTextView addSubview:self.codeTextViewImage];
        [self.mainView addSubview:self.codeTextField];
        [self.mainView addSubview:self.authCodeView];

    }
    return self;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated{
 
}
# pragma mark - *** 输入框代理，点击return按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
    
    return [textField resignFirstResponder];
    
}

@end
