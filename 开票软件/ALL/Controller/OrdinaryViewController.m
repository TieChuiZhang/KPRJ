//
//  OrdinaryViewController.m
//  开票软件
//
//  Created by Lee on 17/3/25.
//  Copyright © 2017年 Lee. All rights reserved.
//

#import "OrdinaryViewController.h"
#import "HMScannerController.h"
#import "CodeViewController.h"
#import "MJRViewController.h"
#import "LoginModel.h"
#import "SKFCamera.h"
#define TITLES @[@"识别二维码", @"拍照识别", @"识别照片"]
@interface OrdinaryViewController ()<YBPopupMenuDelegate,UIImagePickerControllerDelegate,UIPopoverControllerDelegate,UINavigationControllerDelegate,TOCropViewControllerDelegate,
MBProgressHUDDelegate>
@property (nonatomic, strong) UITextField * userName;
@property (nonatomic, strong) UITextField * userName1;
@property (nonatomic, strong) UITextField * userName2;
@property (nonatomic, strong) UITextField * userName3;
@property (nonatomic, strong) UILabel * name;
@property (nonatomic, strong) UIButton *exitBtn;
@property (nonatomic, strong) UIView * mainView;
@property (nonatomic, strong) UIView * hengxian1;//
@property (nonatomic, strong) UIView * userNameView;//
@property (nonatomic, strong) UIButton * codeBtn;
@property (nonatomic, strong) UIView *navView;
@property (nonatomic, strong) UIButton *scanBut;
@property (nonatomic, strong) NSData *sendImageData;



@property (nonatomic, copy) NSString *gfmc;
@property (nonatomic, copy) NSString *gfsh;
@property (nonatomic, copy) NSString *gfdzdh;
@property (nonatomic, copy) NSString *gfyhzh;
@property (nonatomic, strong) PackageAPI *packageApi;

@property (nonatomic, strong) InquiryModel *inquModel;

@property (nonatomic, strong) UIImage *imagePhoto;
@property (nonatomic, strong) UIImage *cameraPhoto;



@property (nonatomic, copy) NSArray *array;
@property (nonatomic, copy) NSArray *array1;
@property (nonatomic, copy) NSArray *array2;
@property (nonatomic, copy) NSArray *array3;
@property (nonatomic, copy) NSArray *array4;
@property (nonatomic, copy) NSString *codeStr;
@property (nonatomic, copy) NSString *codeEndStr;
@end

@implementation OrdinaryViewController

- (InquiryModel *)inquModel {
    if (!_inquModel) {
        _inquModel = [InquiryModel new];
    }
    return _inquModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:212.f/255.f green:220.f/255.f blue:225.f/255.f alpha:1];
}
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupLayout];
        [self.view addSubview:self.codeBtn];
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated {
    [self.view addSubview:self.navView];
    [self.navView addSubview:self.exitBtn];
    [self.navView addSubview:self.scanBut];
    
    
    //NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    //NSString *sessionId = [userDefault objectForKey:@"sessionId"];
    //[self.inquModel inquiryRequestSessionId:sessionId InquiryHandler:^(NSDictionary *dic) {
        
    //} ErrorHandler:^(NSError *error) {
        
   // }];
    
}
- (UIView *)navView {
    if (!_navView) {
        _navView = [UIView new];
        [_navView setFrame:CGRectMake(0, 0, KWidth, 64)];
        [_navView setBackgroundColor:[UIColor colorWithRed:74/255.0 green:99/255.0 blue:146/255.0 alpha:1]];
    }
   return _navView;
}
- (UIButton *)exitBtn {
    if (!_exitBtn) {
        _exitBtn = [UIButton new];
        [_exitBtn setFrame:CGRectMake(15 , _navView.frame.size.height/2, 20, 20)];
        [_exitBtn setImage:[UIImage imageNamed:@"叉子删除"] forState:UIControlStateNormal];
        [_exitBtn addTarget:self action:@selector(tapExitBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exitBtn;
}
- (UIButton *)scanBut {
    if (!_scanBut) {
        _scanBut = [UIButton new];
        [_scanBut setFrame:CGRectMake(KWidth - 35, _navView.frame.size.height/2, 20, 20)];
        [_scanBut setImage:[UIImage imageNamed:@"二维码"] forState:UIControlStateNormal];
        [_scanBut addTarget:self action:@selector(tapScanBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _scanBut;
}
- (MBProgressHUD *)HUD {
    if (!_HUD) {
        _HUD = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        [_HUD  setDelegate:self];
        [_HUD setMode:MBProgressHUDModeAnnularDeterminate];
        [_HUD setDimBackground:YES];
        [_HUD setRemoveFromSuperViewOnHide:YES];
        // 显示的文字
        [_HUD setLabelText:@"正在识别请稍后"];
        // 细节文字
        //[_HUD showWhileExecuting:@selector(tapDistinguishButton) onTarget:self withObject:nil animated:YES];
        //[_HUD hide:YES afterDelay:2];
    }
    return _HUD;
}
- (void)tapExitBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)setupLayout
{
    //包含两个输入框的视图
    _mainView = [[UIView alloc]initWithFrame:CGRectMake(0 ,KHeight/4.2, KWidth, KHeight/4.2)];
    _mainView.backgroundColor = [UIColor whiteColor];
    _mainView.alpha = 0.6;
    _name = [UILabel new];
    _name.text = @"名                称 :";
    if (IS_IPHONE_5) {
        [_name setFont:[UIFont boldSystemFontOfSize:12]];
    }else {
        [_name setFont:[UIFont boldSystemFontOfSize:14]];
    }

    [_name setTextColor:[UIColor colorWithRed:102.f/225.f green:102.f/225.f blue:102.f/225.f alpha:1]];
    
    _name.textAlignment = UIControlContentVerticalAlignmentCenter;
    _name.frame = CGRectMake(4, 0, KWidth/3.8,  (KHeight/1.55)/10.9);
    // 整个左视图
    _userNameView = [[UIView alloc]initWithFrame:CGRectMake(_name.frame.origin.x, _name.frame.origin.y, _name.frame.size.width + 5, _name.frame.size.height)];
    [_userNameView addSubview:_name];
    
    _userName = [[UITextField alloc]initWithFrame:CGRectMake(0, _name.frame.origin.y, _mainView.bounds.size.width, _name.frame.size.height)];
    _userName.font = littleFont;
    _userName.leftView = _userNameView;
    _userName.leftViewMode = UITextFieldViewModeAlways;
    _userName.clearButtonMode = UITextFieldViewModeWhileEditing;
    _userName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    // 添加到包含两个输入框的视图上
    [_mainView addSubview:_userName];
    _hengxian1 = [UIView new];
    _hengxian1.frame = CGRectMake(0, _userName.frame.size.height, KWidth, 1);
    _hengxian1.backgroundColor = [UIColor lightGrayColor];
    [_userNameView addSubview:_hengxian1];
    
    // 加入整个视图
    UILabel *name1 = [UILabel new];
    name1.text = @"纳税人识别号 :";
    if (IS_IPHONE_5) {
        [name1 setFont:[UIFont boldSystemFontOfSize:12]];
    }else {
        [name1 setFont:[UIFont boldSystemFontOfSize:14]];
    }
    [name1 setTextColor:[UIColor colorWithRed:102.f/225.f green:102.f/225.f blue:102.f/225.f alpha:1]];
    name1.textAlignment = UIControlContentVerticalAlignmentCenter;
    name1.frame = CGRectMake(4, 0, KWidth/3.8,  (KHeight/1.55)/10.9);
    // 整个左视图
    UIView *userNameView1 = [[UIView alloc]initWithFrame:CGRectMake(_name.frame.origin.x, _name.frame.size.height, _name.frame.size.width+5, _name.frame.size.height)];
    [userNameView1 addSubview:name1];
    _userName1 = [[UITextField alloc]initWithFrame:CGRectMake(0, _name.frame.size.height, _mainView.bounds.size.width, _name.frame.size.height)];
    //_userName.backgroundColor = [UIColor lightGrayColor];
    _userName1.font = littleFont;
    _userName1.leftView = userNameView1;
    _userName1.leftViewMode = UITextFieldViewModeAlways;
    _userName1.clearButtonMode = UITextFieldViewModeWhileEditing;
    _userName1.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    // 添加到包含两个输入框的视图上
    [_mainView addSubview:_userName1];
    UIView *hengxian2 = [UIView new];
    hengxian2.frame = CGRectMake(0, _userName.frame.size.height*2, KWidth, 1);
    hengxian2.backgroundColor = [UIColor lightGrayColor];
    [userNameView1 addSubview:hengxian2];
    
    UILabel *name2 = [UILabel new];
    name2.text = @"地址、    电话 :";
    [name2 setTextColor:[UIColor colorWithRed:102.f/225.f green:102.f/225.f blue:102.f/225.f alpha:1]];
    if (IS_IPHONE_5) {
        [name2 setFont:[UIFont boldSystemFontOfSize:12]];
    }else {
        [name2 setFont:[UIFont boldSystemFontOfSize:14]];
    }
    name2.frame = CGRectMake(4, 0, KWidth/3.8,  (KHeight/1.55)/10.9);
    // 整个左视图
    UIView *userNameView2 = [[UIView alloc]initWithFrame:CGRectMake(_name.frame.origin.x, _name.frame.size.height*2, _name.frame.size.width+5, _name.frame.size.height)];
    [userNameView2 addSubview:name2];
    _userName2 = [[UITextField alloc]initWithFrame:CGRectMake(0, _name.frame.size.height*2, _mainView.bounds.size.width, _name.frame.size.height)];
    //_userName.backgroundColor = [UIColor lightGrayColor];
    _userName2.font = littleFont;
    _userName2.leftView = userNameView2;
    _userName2.leftViewMode = UITextFieldViewModeAlways;
    _userName2.clearButtonMode = UITextFieldViewModeWhileEditing;
    _userName2.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    // 添加到包含两个输入框的视图上
    [_mainView addSubview:_userName2];
    UIView *hengxian3 = [UIView new];
    hengxian3.frame = CGRectMake(0, 0, KWidth, 1);
    hengxian3.backgroundColor = [UIColor lightGrayColor];
    [userNameView2 addSubview:hengxian3];
    
    
    UILabel *name3 = [UILabel new];
    name3.text = @"开户行及账号 :";
    [name3 setTextColor:[UIColor colorWithRed:102.f/225.f green:102.f/225.f blue:102.f/225.f alpha:1]];
    if (IS_IPHONE_5) {
        [name3 setFont:[UIFont boldSystemFontOfSize:12]];
    }else {
        [name3 setFont:[UIFont boldSystemFontOfSize:14]];
    }
    name3.frame = CGRectMake(4, 0, KWidth/3.8,  (KHeight/1.55)/10.9);
    // 整个左视图
    UIView *userNameView3 = [[UIView alloc]initWithFrame:CGRectMake(_name.frame.origin.x, _name.frame.size.height*2, _name.frame.size.width + 5, _name.frame.size.height)];
    [userNameView3 addSubview:name3];
    _userName3 = [[UITextField alloc]initWithFrame:CGRectMake(0, _name.frame.size.height*3, _mainView.bounds.size.width, _name.frame.size.height)];
    //_userName.backgroundColor = [UIColor lightGrayColor];
    _userName3.font = littleFont;
    _userName3.leftView = userNameView3;
    _userName3.leftViewMode = UITextFieldViewModeAlways;
    _userName3.clearButtonMode = UITextFieldViewModeWhileEditing;
    _userName3.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    // 添加到包含两个输入框的视图上
    [_mainView addSubview:_userName3];
    UIView *hengxian4 = [UIView new];
    hengxian4.frame = CGRectMake(0, _userName.frame.size.height, KWidth, 1);
    hengxian4.backgroundColor = [UIColor lightGrayColor];
    [userNameView3 addSubview:hengxian4];
    [self.view addSubview:_mainView];
}
- (UIButton *)codeBtn {
    if (!_codeBtn) {
        _codeBtn = [UIButton new];
        _codeBtn.frame = CGRectMake(KWidth *0.025, _mainView.frame.origin.y+32+_mainView.frame.size.height, KWidth -((KWidth *0.025)*2), _name.frame.size.height);
        _codeBtn.backgroundColor = [UIColor colorWithRed:74.f/255.f green:100.f/255.f blue:146.f/255.f alpha:1];
        [_codeBtn addTarget:self action:@selector(tabBut:) forControlEvents:UIControlEventTouchUpInside];
        [_codeBtn setTitle:@"生成二维码" forState:UIControlStateNormal];
        if (IS_IPHONE_5) {
            [_codeBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
        }else {
            [_codeBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
        }
                _codeBtn.layer.masksToBounds = YES;
        _codeBtn.layer.cornerRadius = 5;
    }
    return _codeBtn;
}

- (void)tabBut:(UIButton *)sender {
    CodeViewController *codeVC = [CodeViewController new];
    if ([self.gfyhzh isEqualToString:@""]) {
        codeVC.nameText = _userName.text;
        codeVC.sbhText = _userName1.text;
        codeVC.phoneText = _userName2.text;
        codeVC.khhText = _userName3.text;
    }else {
        _userName.text = self.gfmc;
        _userName.text = self.gfsh;
        _userName.text = self.gfdzdh;
        _userName.text = self.gfyhzh;
        codeVC.nameText = self.gfmc;
        codeVC.sbhText = self.gfsh;
        codeVC.phoneText = self.gfdzdh;
        codeVC.khhText = self.gfyhzh;
    }
    
    [self presentViewController:codeVC animated:YES completion:^{
        
    }];
    
    if ([_userName.text isEqualToString:@""] &&[_userName1.text isEqualToString:@""] &&[_userName2.text isEqualToString:@""] &&[_userName3.text isEqualToString:@""]  ) {
        SHOW_TEXT(@"请输入信息");
    }else if ([_userName.text isEqualToString:@""] &&[_userName1.text isEqualToString:@""] &&[_userName2.text isEqualToString:@""] &&[_userName3.text isEqualToString:@""]) {
        SHOW_TEXT(@"不许空");
    }else if (_userName1.text.length != 15){
        SHOW_TEXT(@"请输入十八位纳税人识别号");
    }else {
        SHOW_TEXT(@"对了");
        
     
    }
 
}

- (void)tapScanBtn:(UIButton *)sender {
    [YBPopupMenu showRelyOnView:sender titles:TITLES icons:nil menuWidth:120 delegate:self];
}
- (void)tapQRCodeBtn {
    HMScannerController *scanner = [HMScannerController scannerWithCardName:nil avatar:nil completion:^(NSString *stringValue) {
        [self.inquModel decipheringCodeRequestValue:stringValue SaveHandler:^(NSDictionary *dic) {
            NSDictionary *dict = [[self class] dictionaryWithJsonString:dic[@"value"]];
            NSLog(@"解密%@",dict);
            if (dict) {
                if (dict[@"gfdzdh"]) {
                    self.gfmc = dict[@"gfmc"];
                    self.gfsh = dict[@"gfsh"];
                    self.gfdzdh = dict[@"gfdzdh"];
                    self.gfyhzh = dict[@"gfyhzh"];
                    dispatch_async(dispatch_get_main_queue(), ^ {
                        _userName.text = dict[@"gfmc"];
                        _userName1.text = dict[@"gfsh"];
                        _userName2.text = dict[@"gfdzdh"];
                        _userName3.text = dict[@"gfyhzh"];
                    });
                }else {
                    dispatch_async(dispatch_get_main_queue(), ^ {
                        SHOW_TEXT(@"请重试");
                    });
                }
            }
            
        } ErrorHandler:^(NSError *error) {
            
        }];
        //self.scanResultLabel.text = stringValue;
    }];
    [scanner setTitleColor:[UIColor whiteColor] tintColor:[UIColor greenColor]];
    
    [self showDetailViewController:scanner sender:nil];
}
- (void)tapTakePicBtn {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        SKFCamera *homec = [[SKFCamera alloc] init];
        __weak typeof(self) myself = self;
        homec.fininshcapture = ^(UIImage *ss) {
            if (ss) {
                NSLog(@"照片存在");
                myself.cameraPhoto = ss;
                [myself tapDistinguishButton];
            }
        };
        [myself presentViewController:homec
                             animated:NO
                           completion:^{
                           }];
    } else {
        NSLog(@"相机调用失败");
    }
}
- (void)tapPhotoBtn {
    
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
    //设置选取的照片是否可编辑
    pickerController.allowsEditing = NO;
    //设置相册呈现的样式
    pickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;//图片分组列表样式
    //照片的选取样式还有以下两种
    //UIImagePickerControllerSourceTypePhotoLibrary,直接全部呈现系统相册
    //UIImagePickerControllerSourceTypeCamera//调取摄像头
    
    //选择完成图片或者点击取消按钮都是通过代理来操作我们所需要的逻辑过程
    pickerController.delegate = self;
    //使用模态呈现相册
    [self presentViewController:pickerController animated:YES completion:^{
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

// json转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData                                                    options:NSJSONReadingMutableContainers                                                       error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu {
    NSLog(@"点击了 %@ 选项",TITLES[index]);
    if (index == 0) {
        [self tapQRCodeBtn];
    } else if (index == 1) {
        [self tapTakePicBtn];
    } else if (index == 2) {
        [self tapPhotoBtn];
    }
}
- (void)cropViewController:(TOCropViewController *)cropViewController
            didCropToImage:(UIImage *)image
                  withRect:(CGRect)cropRect
                     angle:(NSInteger)angle {
    
    self.imagePhoto = image;
    UIImageView *imageView = [UIImageView new];
    imageView.frame = CGRectMake(0, 0, KWidth, KHeight/3);
    self.navigationItem.rightBarButtonItem.enabled = YES;
    CGRect viewFrame = [self.view convertRect:imageView.frame toView:self.navigationController.view];
    [cropViewController dismissAnimatedFromParentViewController:self
                                               withCroppedImage:image
                                                        toFrame:imageView.frame
                                                     completion:^{
                                                     }];
    NSLog(@"最后");
    [self tapDistinguishButton];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [self dismissViewControllerAnimated:NO completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    NSData * imageData = UIImageJPEGRepresentation(image,1);
    NSLog(@"AM:%.2fKB",imageData.length/1000.0);
    self.imagePhoto = image;
    TOCropViewController *cropController = [[TOCropViewController alloc] initWithImage:image];
    cropController.delegate = self;
    [self presentViewController:cropController animated:YES completion:nil];
}
- (UIImage *)compressImage:(UIImage *)image {
    UIImageOrientation orientation = [image imageOrientation];
    
    CGImageRef imRef = [image CGImage];
    
    CGFloat texWidth = CGImageGetWidth(imRef);
    CGFloat texHeight = CGImageGetHeight(imRef);
    
    float imageScale = 1;
    
    if(orientation == UIImageOrientationUp && texWidth < texHeight)
        image = [UIImage imageWithCGImage:imRef scale:imageScale orientation: UIImageOrientationLeft];
    else if((orientation == UIImageOrientationUp && texWidth > texHeight) || orientation == UIImageOrientationRight)
        image = [UIImage imageWithCGImage:imRef scale:imageScale orientation: UIImageOrientationUp];
    else if(orientation == UIImageOrientationDown)
        image = [UIImage imageWithCGImage:imRef scale:imageScale orientation: UIImageOrientationDown];
    else if(orientation == UIImageOrientationLeft)
        image = [UIImage imageWithCGImage:imRef scale:imageScale orientation: UIImageOrientationUp];
    return image;
}
- (NSData *)cameraImageInToDataCameraImage:(UIImage *)cameraImage {
    NSData *data = UIImageJPEGRepresentation(cameraImage, 0.75);
    NSLog(@"M:%.2fKB",data.length/1000.0);
    NSUInteger sizeOrigin = [data length];
    NSUInteger sizeOriginKB = sizeOrigin / 1024;
    if (sizeOriginKB > 5*1024){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:@"图片大小超过5M，请重试"
                                                      delegate:nil
                                             cancelButtonTitle:nil
                                             otherButtonTitles:@"确定", nil];
        [alert show];
    }
    
    return data;
}
- (void)disMissHud {
    
    [self.HUD dimBackground];
    [self.HUD removeFromSuperview];
    self.HUD = nil;
}
- (void)showToViewHud {
    [self.HUD show:YES];
}
- (void)tapDistinguishButton {
    [self showToViewHud];
    if (_imagePhoto) {
        _sendImageData = [self cameraImageInToDataCameraImage:_imagePhoto];
    } else if (_cameraPhoto) {
        _sendImageData = [self cameraImageInToDataCameraImage:_cameraPhoto];
    }

    self.packageApi = [PackageAPI new];
    
    [_packageApi AFNuploadPackage:_sendImageData Success:^(NSDictionary *dic, BOOL isSUccess) {
        [self disMissHud];
         if (isSUccess) {
             if ([dic[@"status"]  isEqual: @"OK"]){
                NSString *codeStr;
                if(([dic[@"data"] rangeOfString:@"O"].location !=NSNotFound && [dic[@"data"] rangeOfString:@"o"].location !=NSNotFound) || ([dic[@"data"] rangeOfString:@"O"].location !=NSNotFound) || [dic[@"data"] rangeOfString:@"o"].location !=NSNotFound) {
                    codeStr = [dic[@"data"] stringByReplacingOccurrencesOfString:@"o" withString:@"0"];
                    codeStr = [codeStr stringByReplacingOccurrencesOfString:@"O" withString:@"0"];
                    
                    if ([codeStr  rangeOfString:@"s"].location !=NSNotFound) {
                        self.codeEndStr = [codeStr stringByReplacingOccurrencesOfString:@"s" withString:@"5"];
                        self.codeStr = self.codeEndStr;
                    }
                    self.codeStr = codeStr;
                } else if ([dic[@"data"]  rangeOfString:@"s"].location !=NSNotFound) {
                    codeStr = [dic[@"data"] stringByReplacingOccurrencesOfString:@"s" withString:@"5"];
                    self.codeStr = codeStr;
                }
                 NSLog(@"%@",self.codeStr);
                if ( [self.codeStr rangeOfString:@"名称"].location !=NSNotFound) {
                    _array = [self.codeStr componentsSeparatedByString:@"名称："];
                    _array1 = [_array[1] componentsSeparatedByString:@"纳税人识别号："];
                    if ([_array1[1] rangeOfString:@"地址："].location !=NSNotFound && [_array2[1] rangeOfString:@"电话："].location !=NSNotFound) {
                        _array2 = [_array1[1] componentsSeparatedByString:@"地址："];
                        _array3 = [_array2[1] componentsSeparatedByString:@"电话："];
                    } else if ([_array1[1] rangeOfString:@"地址、电话："].location !=NSNotFound) {
                        _array3 = [_array1[1] componentsSeparatedByString:@"地址、电话："];
                        NSLog(@"截取的值为333：%@",_array3[0]);
                    }else {
                        NSLog(@"再试试吧");
                    }
                    _array4 = [_array3[1] componentsSeparatedByString:@"开户行及账号："];
                    NSLog(@"截取的值为111：%@",_array1[0]);
                    NSLog(@"截取的值为222：%@",_array3[0]);
                    NSLog(@"截取的值为444：%@",_array4[0]);
                    NSLog(@"截取的值为：%@",_array2[0]);
                    NSLog(@"截取的值为444：%@",_array4[1]);
                    if (_array1[0]) {
                        _userName.text = _array1[0];
                        _userName3.text = _array4[1];
                        if (_array2[0]) {
                            _userName1.text = _array2[0];
                            _userName2.text = [NSString stringWithFormat:@"%@%@",_array3[0],_array4[0]];
                        }else {
                            _userName1.text = _array3[0];
                            _userName2.text = _array4[0];
                        }
                    }else {
                        SHOW_TEXT(@"识别失败了拍一张清晰点的照片吧");
                    }
                }

                    
                    
                }else if(!([dic[@"data"] rangeOfString:@"公司"].location !=NSNotFound)) {
                   // qrCode.string = dic[@"data"];
                   // [self presentViewController:qrCode animated:YES completion:nil];
                    SHOW_TEXT(@"乱码了朋友,好好拍照不行么");
                }
        }else {
            
        }
    } Fail:^(NSError *error) {
        NSLog(@"11111111%@",error);
    }];
}

@end
