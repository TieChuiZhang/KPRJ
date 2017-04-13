//
//  LoginModel.m
//  开票软件
//
//  Created by Lee on 17/3/31.
//  Copyright © 2017年 Lee. All rights reserved.
//

#import "LoginModel.h"
#import <CommonCrypto/CommonDigest.h>
#import <sys/sysctl.h>
@interface LoginModel ()
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@property (nonatomic, assign) NSUInteger maxpage;

@end

@implementation LoginModel
+(AFHTTPSessionManager *)manager{
    
    //    // 先导入证书 证书由服务端生成，具体由服务端人员操作
    //    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"https" ofType:@"cer"];//证书的路径
    //    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    //
    //    // AFSSLPinningModeCertificate 使用证书验证模式
    //    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    //    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    //    // 如果是需要验证自建证书，需要设置为YES
    //    securityPolicy.allowInvalidCertificates = NO;
    //
    //    //validatesDomainName 是否需要验证域名，默认为YES;
    //    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //    //如置为NO，建议自己添加对应域名的校验逻辑。
    //    securityPolicy.validatesDomainName = NO;
    //
    //    securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:cerData,nil];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 超时时间
    manager.requestSerializer.timeoutInterval = HttpTimeOutInterval;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    return manager;
}
+ (void)httpManagerPostRestUrl:(NSString *)url
                           Xml:(NSData *)postdata
                       Success:(SuccessBlock)success
                          Fail:(ErrorBlock)fail{
    AFHTTPSessionManager *manager = [self manager];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    request.HTTPMethod = @"POST";
    request.HTTPBody = postdata;
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            fail(error);
            NSLog(@"%@",fail);
        }else{
            if (responseObject) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                    options:NSJSONReadingMutableContainers
                                                                      error:nil];
                if ([dic[@"status"]  isEqual: @"OK"]) {
                    success(dic,YES);
                    
                    } else {
                        success(dic,YES);
                }
                
                
                if ([dic[@"status"]  isEqual: @"-1· 10"]) {
                    
                    SHOW_TEXT(@"识别失败");
                } else if ([dic[@"status"]  isEqual: @"-90"] || [dic[@"status"]  isEqual: @"-91"] || [dic[@"status"]  isEqual: @"-92"] || [dic[@"status"]  isEqual: @"-98"] || [dic[@"status"]  isEqual: @"-99"] || [dic[@"status"]  isEqual: @"100"] || [dic[@"status"]  isEqual: @"-101"] || [dic[@"status"]  isEqual: @"-102"]) {
                    SHOW_TEXT(@"识别失败");
                } else if ([dic[@"status"]  isEqual: @"-106"]) {
                    SHOW_TEXT(@"识别出现异常");
                } 
                
                
            }else{
                //success(@"返回为空",NO);
            }
        }
    }];
    [dataTask resume];
    
}


- (void)saveSessionIdRequestSessionId:(NSString *)sessionID SessionIdHandler:(LoginBlock)SessionBlock ErrorHandler:(FailedBlock)errorBlock {
    NSString *avvvc = @"http://192.168.0.145:8080/kpserver/userjson/checkLogin.action";
    NSDictionary *dict = @{@"user":@{@"sessionId":sessionID}};
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:avvvc parameters:dict error:nil];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            //没有错误，返回正确；
            // NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
            //NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            //NSLog(@"HttpResponseCode:%ld", responseCode);
            //NSLog(@"HttpResponseBody %@",responseString);
            //NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSDictionary *dic    = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"验证sessionId返回的信息:%@",dic);
            if (dic) {
                SessionBlock(dic);
            } else {
                dispatch_async(dispatch_get_main_queue(), ^ {
                    //SHOW_TEXT(@"我也不知道该说什么");
                });
                
            }
            
        } else {
            //出现错误；
            NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
        }
    }];
    [dataTask resume];
}

-(BOOL)checkPhoneNumber:(NSString *)phone {
    //正则表达式
    
    NSString *pattern = @"^1+[3578]+\\d{9}$";
    
    //创建一个谓词,一个匹配条件
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    
    //评估是否匹配正则表达式
    
    BOOL isMatch = [pred evaluateWithObject:phone];
    
    return isMatch;
}
- (void)logInRequestPhoneNumber:(NSString *)phNum CodeNumber:(NSString *)codeNum LoginHandler:(LoginBlock)lBlock ErrorHandler:(FailedBlock)errorBlock {
    
    NSString *avvvc = @"http://192.168.0.145:8080/kpserver/userjson/loginByPhone.action";
    NSDictionary *dict = @{@"user":@{@"phone":phNum,@"checkCode":codeNum}};
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:avvvc parameters:dict error:nil];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            //没有错误，返回正确；
            // NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
            //NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            //NSLog(@"HttpResponseCode:%ld", responseCode);
            //NSLog(@"HttpResponseBody %@",responseString);
            //NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSDictionary *dic    = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"登录返回的信息:%@",dic);
            if (dic) {
                lBlock(dic);
            } else {
                dispatch_async(dispatch_get_main_queue(), ^ {
                    //SHOW_TEXT(@"我也不知道该说什么");
                });
               
            }
            
        } else {
            //出现错误；
            NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
        }
    }];
    [dataTask resume];
}
- (void)sendCodeRequestPhoneNumber:(NSString *)phone LoginHandler:(LoginBlock)lBlock ErrorHandler:(FailedBlock)errorBlock {
    NSString *avvvc = @"http://192.168.0.145:8080/kpserver/userjson/checkCode.action";
    NSDictionary *dict = @{@"user":@{@"phone":phone}};
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:avvvc parameters:dict error:nil];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            //没有错误，返回正确；
            // NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
            //NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            //NSLog(@"HttpResponseCode:%ld", responseCode);
            //NSLog(@"HttpResponseBody %@",responseString);
            // NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSDictionary *dic    = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            //NSDictionary *dicjson = (NSDictionary *)json;
            NSLog(@"请求验证码返回的信息:%@",dic);
            dispatch_async(dispatch_get_main_queue(), ^{
                //刷新UI
            });
        }else{
            //出现错误；
            NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
        }
    }];
    [dataTask resume];
}



@end
@implementation MessageSave
- (void)messageSaveRequestGSName:(NSString *)gsName DZPhone:(NSString *)dzPhone YHAccount:(NSString *)yhAccount DutyNumber:(NSString *)dutyNumber SessIonID:(NSString *)sessionID SaveHandler:(LoginBlock)SBlock ErrorHandler:(FailedBlock)errorBlock {
    
    NSString *avvvc = @"http://192.168.0.145:8080/kpserver/userxxjson/save.action";
    NSDictionary *dict = @{@"userXX":@{@"gfmc":gsName,@"gfdzdh":dzPhone,@"gfyhzh":yhAccount,@"gfsh":dutyNumber,@"sessionId":sessionID}};
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:avvvc parameters:dict error:nil];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        if (!error) {
            //没有错误，返回正确；
            // NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
            //NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            //NSLog(@"HttpResponseCode:%ld", responseCode);
            //NSLog(@"HttpResponseBody %@",responseString);
            // NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSDictionary *dic    = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
            //NSDictionary *dicjson = (NSDictionary *)json;
            NSLog(@"保存的信息:%@",dic);
            dispatch_async(dispatch_get_main_queue(), ^{
                //刷新UI
            });
            
        } else {
            //出现错误；
            NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
        }
        
    }];
    [dataTask resume];
}
@end


@implementation InquiryModel
- (void)inquiryRequestSessionId:(NSString *)sessionId InquiryHandler:(LoginBlock)IBlock ErrorHandler:(FailedBlock)errorBlock {
    
    NSString *avvvc = @"http://192.168.0.145:8080/kpserver/userxxjson/queryByUserId.action";
    NSDictionary *dict = @{@"userXX":@{@"sessionId":sessionId}};
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:avvvc parameters:dict error:nil];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            //没有错误，返回正确；
            // NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
            //NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            //NSLog(@"HttpResponseCode:%ld", responseCode);
            //NSLog(@"HttpResponseBody %@",responseString);
            // NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSDictionary *dic    = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            //NSDictionary *dicjson = (NSDictionary *)json;
            NSLog(@"请求已经保存的信息:%@",dic);
            dispatch_async(dispatch_get_main_queue(), ^{
                //刷新UI
            });
            
        }else{
            //出现错误；
            NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
        }
        
    }];
    
    [dataTask resume];
    
}

- (void)encryptCodeRequestName:(NSString *)name SaveHandler:(LoginBlock)SBlock ErrorHandler:(FailedBlock)errorBlock {
    NSString *avvvc = @"http://192.168.0.145:8080/kpserver/cryptjson/enCrypt.action";
    NSDictionary *dict = @{@"crypt":@{@"value":name}};
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:avvvc parameters:dict error:nil];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            //没有错误，返回正确；
            // NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
            //NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            //NSLog(@"HttpResponseCode:%ld", responseCode);
            //NSLog(@"HttpResponseBody %@",responseString);
            // NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSDictionary *dic    = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            //NSDictionary *dicjson = (NSDictionary *)json;
            NSLog(@"加密返回的字典:%@",dic);
            dispatch_async(dispatch_get_main_queue(), ^{
                //刷新UI
            });
            SBlock(dic);
        }else{
            //出现错误；
            NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
        }
        
    }];
    
    [dataTask resume];
}
- (void)decipheringCodeRequestValue:(NSString *)Value SaveHandler:(LoginBlock)SBlock ErrorHandler:(FailedBlock)errorBlock {
    NSString *avvvc = @"http://192.168.0.145:8080/kpserver/cryptjson/deCrypt.action";
    
    NSDictionary *dict = @{@"crypt":@{@"value":Value}};
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:avvvc parameters:dict error:nil];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            //没有错误，返回正确；
            // NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
            //NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            //NSLog(@"HttpResponseCode:%ld", responseCode);
            //NSLog(@"HttpResponseBody %@",responseString);
            // NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSDictionary *dic    = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            //NSDictionary *dicjson = (NSDictionary *)json;
            NSLog(@"解密返回的字典:%@",dic);
            dispatch_async(dispatch_get_main_queue(), ^{
                //刷新UI
            });
            SBlock(dic);
        }else{
            //出现错误；
            NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
        }
        
    }];
    
    [dataTask resume];
}





@end


































