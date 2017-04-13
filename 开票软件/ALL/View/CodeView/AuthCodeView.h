//
//  AuthCodeView.h
//  发票项目
//
//  Created by Lee on 17/3/6.
//  Copyright © 2017年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthCodeView : UIView

#pragma mark - *** 字符数组
@property (nonatomic, strong) NSArray *dataArray;

#pragma mark - *** 验证码字符串
@property (nonatomic, copy) NSString *authCodeStr;


@end
