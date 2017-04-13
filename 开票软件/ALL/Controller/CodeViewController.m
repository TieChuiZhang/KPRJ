//
//  CodeViewController.m
//  开票软件
//
//  Created by Lee on 17/3/25.
//  Copyright © 2017年 Lee. All rights reserved.
//

#import "CodeViewController.h"
#import "HMScannerController.h"
#import "LoginModel.h"
@interface CodeViewController ()
@property (nonatomic, strong) UIButton *exitBtn;
@property (nonatomic, strong) UIButton * codeBtn;
@property (nonatomic, strong) UIView *imageView;
@property (nonatomic, strong) UILabel *myCodeLabel;
@property (nonatomic, strong) UIImageView *codeImageView;

@property (nonatomic, strong) MessageSave *messageSave;
@property (nonatomic, strong) InquiryModel *inquiryModel;
@property (nonatomic, strong) NSString *strValue;
@end

@implementation CodeViewController
- (MessageSave *)messageSave {
    if (!_messageSave) {
        _messageSave = [MessageSave new];
    }
    return _messageSave;
}
- (InquiryModel *)inquiryModel {
    if (!_inquiryModel) {
        _inquiryModel = [InquiryModel new];
    }
    return _inquiryModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:212.f/255.f green:220.f/255.f blue:225.f/255.f alpha:1];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.myCodeLabel];
    [self.imageView addSubview:self.codeImageView];
    [self.view addSubview:self.codeBtn];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *sessionId = [userDefault objectForKey:@"sessionId"];
   // NSDictionary *dic = @{@"gfmc":self.nameText,@"gfsh":self.sbhText,@"gfyhzh":self.khhText,@"gfdzdh":self.phoneText};
   // NSString *str = [self convertToJsonData:dic];
    [self.inquiryModel encryptCodeRequestName:@"" SaveHandler:^(NSDictionary *dic) {
        
        NSLog(@"%@",dic);
        
        
        [HMScannerController cardImageWithCardName:dic[@"value"] avatar:nil scale:0.2 completion:^(UIImage *image) {
            dispatch_async(dispatch_get_main_queue(), ^ {
                self.codeImageView.image = image;
                if (image) {
                    [self.messageSave messageSaveRequestGSName:self.nameText DZPhone:self.phoneText YHAccount:self.khhText DutyNumber:self.sbhText SessIonID:sessionId SaveHandler:^(NSDictionary *dic) {
                        
                    } ErrorHandler:^(NSError *error) {
                        
                    }];
                }
            });
            
        }];
    } ErrorHandler:^(NSError *error) {
        
    }];
   
    [self.view addSubview:self.exitBtn];
}

-(NSString *)convertToJsonData:(NSDictionary *)dict {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}
- (UIView *)imageView {
    if (!_imageView) {
        _imageView = [UIView new];
        _imageView.frame = CGRectMake(KWidth *0.2,KHeight/5, KWidth-(KWidth*0.2*2), KHeight/3);
        _imageView.backgroundColor = [UIColor whiteColor];
    }
    return _imageView;
}
- (UILabel *)myCodeLabel {
    if (!_myCodeLabel) {
        _myCodeLabel = [UILabel new];
        _myCodeLabel.frame = CGRectMake(KWidth *0.2, _imageView.frame.origin.y+_imageView.frame.size.height, KWidth-(KWidth*0.2*2), KHeight/25);
        [_myCodeLabel setText:@"我的专票二维码"];
        [_myCodeLabel setFont:[UIFont boldSystemFontOfSize:14]];
        _myCodeLabel.textAlignment = NSTextAlignmentCenter;
        _myCodeLabel.backgroundColor = [UIColor clearColor];
        [_myCodeLabel setTextColor:[UIColor colorWithRed:102.f/225.f green:102.f/225.f blue:102.f/225.f alpha:1]];
    }
    return _myCodeLabel;
}
- (UIImageView *)codeImageView {
    if (!_codeImageView) {
        _codeImageView = [UIImageView new];
        _codeImageView.frame = CGRectMake(_imageView.frame.size.width*0.04,_imageView.frame.size.height*0.04 ,_imageView.frame.size.width - (_imageView.frame.size.width*0.04*2),_imageView.frame.size.width - (_imageView.frame.size.height*0.04*2));
        _codeImageView.backgroundColor = [UIColor clearColor];
    }
    return _codeImageView;
}
- (UIButton *)codeBtn {
    if (!_codeBtn) {
        _codeBtn = [UIButton new];
        _codeBtn.frame = CGRectMake(KWidth *0.025, _myCodeLabel.frame.size.height+_myCodeLabel.frame.origin.y, KWidth -((KWidth *0.025)*2), KHeight/9/2);
        _codeBtn.backgroundColor = [UIColor colorWithRed:74.f/255.f green:100.f/255.f blue:146.f/255.f alpha:1];
        [_codeBtn addTarget:self action:@selector(tapBut:) forControlEvents:UIControlEventTouchUpInside];
        [_codeBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
        [_codeBtn setTitle:@"保存到相册" forState:UIControlStateNormal];
        _codeBtn.layer.masksToBounds = YES;
        _codeBtn.layer.cornerRadius = 5;
    }
    return _codeBtn;
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
- (void)tapExitBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)tapBut:(UIButton *)sender {
    UIImageWriteToSavedPhotosAlbum(self.codeImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (!error) {
        SHOW_TEXT(@"保存成功");
    }
}
@end
