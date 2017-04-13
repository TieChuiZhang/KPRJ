//
//  LoginModel.h
//  开票软件
//
//  Created by Lee on 17/3/31.
//  Copyright © 2017年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#define HttpTimeOutInterval   30
typedef void (^SuccessBlock)(NSDictionary *dic , BOOL isSUccess);
typedef void (^ErrorBlock)(NSError *error);
typedef void (^LoginBlock)(NSDictionary *dic);
typedef void(^FailedBlock)(NSError *error);

@interface LoginModel : NSObject
- (BOOL)checkPhoneNumber:(NSString *)phone;
- (void)logInRequestPhoneNumber:(NSString *)phNum
                     CodeNumber:(NSString *)codeNum
                   LoginHandler:(LoginBlock)lBlock
                   ErrorHandler:(FailedBlock)errorBlock;

- (void)sendCodeRequestPhoneNumber:(NSString *)phone
                      LoginHandler:(LoginBlock)lBlock
                      ErrorHandler:(FailedBlock)errorBlock;

- (void)saveSessionIdRequestSessionId:(NSString *)sessionID
                         SessionIdHandler:(LoginBlock)SessionBlock
                         ErrorHandler:(FailedBlock)errorBlock;

// 识别接口
+ (void)httpManagerPostRestUrl:(NSString *)url
                           Xml:(NSData *)postdata
                       Success:(SuccessBlock)success
                          Fail:(ErrorBlock)fail;

@end


@interface MessageSave : LoginModel
- (void)messageSaveRequestGSName:(NSString *)gsName
                         DZPhone:(NSString *)dzPhone
                       YHAccount:(NSString *)yhAccount
                      DutyNumber:(NSString *)dutyNumber
                       SessIonID:(NSString *)sessionID
                     SaveHandler:(LoginBlock)SBlock
                    ErrorHandler:(FailedBlock)errorBlock;

@end

@interface InquiryModel : LoginModel
- (void)inquiryRequestSessionId:(NSString *)sessionId
                 InquiryHandler:(LoginBlock)IBlock
                   ErrorHandler:(FailedBlock)errorBlock;

- (void)encryptCodeRequestName:(NSString *)name
                     SaveHandler:(LoginBlock)SBlock
                    ErrorHandler:(FailedBlock)errorBlock;


- (void)decipheringCodeRequestValue:(NSString *)Value
                        SaveHandler:(LoginBlock)SBlock
                       ErrorHandler:(FailedBlock)errorBlock;
@end
