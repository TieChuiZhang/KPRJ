//
//  PackageAPI.h
//  发票项目
//
//  Created by Lee on 17/1/16.
//  Copyright © 2017年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "LoginModel.h"
#define serverUrl @"https://www.yunmaiocr.com/SrvXMLAPI"
@interface PackageAPI : UIViewController

@property (nonatomic, copy) NSString *statusStr;
@property (nonatomic, copy) NSData *receiveData;

- (void)AFNuploadPackage:(NSData*)imageData Success:(SuccessBlock)sucess Fail:(ErrorBlock)fail;
@end
