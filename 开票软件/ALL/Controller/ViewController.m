//
//  ViewController.m
//  开票软件
//
//  Created by Lee on 17/3/25.
//  Copyright © 2017年 Lee. All rights reserved.
//

#import "ViewController.h"
#import "OrdinaryViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIView *myView;
@property (nonatomic, strong) UIButton *odyBut;
@property (nonatomic, strong) UIButton *mjrBut;
@property (nonatomic, strong) UILabel *myLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.myView];
    [self.myView addSubview:self.odyBut];
    [self.myView addSubview:self.mjrBut];
    [self.myView addSubview:self.myLabel];
    if (_myView) {
        self.view.backgroundColor = [UIColor orangeColor];
        self.view.alpha = 0.5;
    }
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (UIView *)myView {
    if (!_myView) {
        _myView = [UIView new];
        [_myView setFrame:CGRectMake(0, 0, 300, 150)];
        _myView.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(self.view.frame)/2);
        _myView.backgroundColor = [UIColor redColor];
        _myView.layer.masksToBounds = YES;
        _myView.layer.cornerRadius = 6.0;
        //_myView.layer.borderWidth = 1.0;
    }
    return _myView;
}
- (UILabel *)myLabel {
    if (!_myLabel) {
        _myLabel = [UILabel new];
        [_myLabel setFrame:CGRectMake(0, 0, self.myView.frame.size.width, 30)];
        [_myLabel setText:@"请选择"];
        [_myLabel setFont:[UIFont systemFontOfSize:15]];
        [_myLabel setTextColor:[UIColor greenColor]];
        [_myLabel setBackgroundColor:[UIColor whiteColor]];
        [_myLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _myLabel;
}
- (UIButton *)odyBut {
    if (!_odyBut) {
        _odyBut = [UIButton new];
        [_odyBut setFrame:CGRectMake(0, 0, 80, 80)];
        [_odyBut setCenter:CGPointMake(CGRectGetWidth(self.myView.frame)/4, CGRectGetHeight(self.myView.frame)/2 + 15)];
        _odyBut.backgroundColor = [UIColor lightGrayColor];
        [_odyBut setTitle:@"普通用户" forState:UIControlStateNormal];
        _odyBut.backgroundColor = [UIColor lightGrayColor];
        _odyBut.layer.masksToBounds = YES;
        _odyBut.layer.cornerRadius = 6.0;
        [_odyBut setHighlighted:YES];
        [_odyBut addTarget:self action:@selector(tapOdyBut) forControlEvents:UIControlEventTouchUpInside];
    }
    return _odyBut;
}
- (UIButton *)mjrBut {
    if (!_mjrBut) {
        _mjrBut = [UIButton new];
        [_mjrBut setFrame:CGRectMake(0, 0, 80, 80)];
        [_mjrBut setCenter:CGPointMake(CGRectGetWidth(self.myView.frame)/2+75, CGRectGetHeight(self.myView.frame)/2+15)];
        _mjrBut.backgroundColor = [UIColor lightGrayColor];
        _mjrBut.layer.masksToBounds = YES;
        _mjrBut.layer.cornerRadius = 6.0;
        [_mjrBut setTitle:@"专业用户" forState:UIControlStateNormal];
        [_mjrBut addTarget:self action:@selector(tapmjrBut) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mjrBut;
}
- (void)tapmjrBut {
    
}
- (void)tapOdyBut {
    //UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    OrdinaryViewController *vo = [OrdinaryViewController new];
    
    [self presentViewController:vo animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
