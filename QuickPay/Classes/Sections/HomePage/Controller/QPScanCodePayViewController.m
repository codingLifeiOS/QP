//
//  QPScanCodePayViewController.m
//  QuickPay
//
//  Created by Nie on 2016/10/26.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPScanCodePayViewController.h"
#import "QPQRView.h"
#import "ZBarSDK.h"
#import "QPHttpManager.h"
#import "QRCodeGenerator.h"
#import "QPQrderQueryViewController.h"
#import "NavigationController.h"
@interface QPScanCodePayViewController ()<ZBarReaderViewDelegate>
{
    ZBarReaderView *_readview;          // 扫描二维码ZBarReaderView
    QPQRView *_qrRectView;             // 自定义的扫描视图
    UIView *backView ;
    UIImageView *codeImage;            // 生成的二维码
    UIImageView *logoImage;
    UIImageView *instructionImage;
    
    UIButton * changecodeBtn;
    UIButton * instructionsImageBtn;
    UIButton * changeZBarBtn;
    UIButton * codeinstructionsImageBtn;
    
//    NSInteger time;
}
@property(nonatomic,copy)NSString *orderId;//订单号
@property (nonatomic,assign)BOOL isStop;



@end

@implementation QPScanCodePayViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.payModel.payType isEqualToString:@"2"]) {
        [self addTitleToNavBar:@"微信收款"];
    } else {
        [self addTitleToNavBar:@"支付宝收款"];
    }
    [self createBackBarItem];
    [self configuredZBarReader];
    [self configureCodeView];
    [self setZBarReaderViewStart];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isStop = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 停止扫描
    [self setZBarReaderViewStop];
    self.isStop = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"resetDigitalKeyboard" object:nil];
}

#pragma mark - configureSubViews
- (void)configuredZBarReader {
    
    // 初始化照相机窗口
    _readview = [[ZBarReaderView alloc] init];
    // 设置扫描代理
    _readview.readerDelegate = self;
    // 关闭闪光灯
    _readview.torchMode = 0;
    // 显示帧率
    _readview.showsFPS = NO;
    // 将其照相机拍摄视图添加到要显示的视图上
    [self.view addSubview:_readview];
    // 二维码/条形码识别设置
    ZBarImageScanner *scanner = _readview.scanner;
    [scanner setSymbology: ZBAR_I25 config: ZBAR_CFG_ENABLE to: 0];
    
    __weak __typeof(self) weakSelf = self;
    [_readview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).with.offset(0);
        make.left.equalTo(weakSelf.view).with.offset(0);
        make.right.equalTo(weakSelf.view).with.offset(0);
        make.bottom.equalTo(weakSelf.view).with.offset(0);
    }];
    // 初始化扫描二维码视图的子控件
    [self configuredZBarReaderMaskView];
}

- (void)configuredZBarReaderMaskView {
    // 扫描的矩形方框视图
    _qrRectView = [[QPQRView alloc] init];
    _qrRectView.transparentArea = CGSizeMake(220, 220);
    _qrRectView.backgroundColor = [UIColor clearColor];
    
    [_readview addSubview:_qrRectView];
    [_qrRectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_readview).with.offset(0);
        make.left.equalTo(_readview).with.offset(0);
        make.right.equalTo(_readview).with.offset(0);
        make.bottom.equalTo(_readview).with.offset(0);
    }];
    
    UILabel *amoutLable = [[UILabel alloc]init];
    amoutLable.text =  [NSString stringWithFormat:@"¥:%@",self.payModel.amount];
    amoutLable.textColor = [UIColor orangeColor];
    amoutLable.textAlignment = NSTextAlignmentCenter;
    amoutLable.frame = CGRectMake(0, _readview.y+280, SCREEN_WIDTH, 30);
    amoutLable.font = [UIFont systemFontOfSize:20];
    [_readview addSubview:amoutLable];
    
    UILabel *paytapeLable = [[UILabel alloc]init];
    paytapeLable.text =  @"请扫描消费者的付款码完成收款";
    paytapeLable.textColor = [UIColor whiteColor];
    paytapeLable.textAlignment = NSTextAlignmentCenter;
    paytapeLable.font = [UIFont systemFontOfSize:16];
    paytapeLable.frame = CGRectMake(0, amoutLable.bottom+5, SCREEN_WIDTH, 30);
    [_readview addSubview:paytapeLable];
    
    changecodeBtn = [[UIButton alloc]init];
//    if (SCREEN_WIDTH == 414) {
//        changecodeBtn.frame = CGRectMake(96.5, paytapeLable.bottom+15, SCREEN_WIDTH-193, 60);
//    }
//    if (SCREEN_WIDTH == 375) {
//    changecodeBtn.frame = CGRectMake(114, paytapeLable.bottom+15, SCREEN_WIDTH-228, 40);
//    }
//    if (SCREEN_WIDTH == 320) {
//    changecodeBtn.frame = CGRectMake(86.5, paytapeLable.bottom+15, SCREEN_WIDTH-173, 40);
//    }
    [changecodeBtn setBackgroundImage:[UIImage imageNamed:@"saoma_qiehuan_nor"] forState:UIControlStateNormal];
    [_readview addSubview:changecodeBtn];
    [changecodeBtn addTarget:self action:@selector(changePayType) forControlEvents:UIControlEventTouchUpInside];
    [changecodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(paytapeLable.mas_bottom_mas).with.offset(15);
        make.width.equalTo(@(294/2));
        make.height.equalTo(@(80/2));
        make.centerX.equalTo(_readview.mas_centerX_mas);
        
    }];
    
    instructionsImageBtn = [[UIButton alloc]init];
//    if (SCREEN_WIDTH == 414) {
//        instructionsImageBtn.frame = CGRectMake(105, changecodeBtn.bottom+15, SCREEN_WIDTH-210, 30);
//    }
//    if (SCREEN_WIDTH == 375) {
//        instructionsImageBtn.frame = CGRectMake(122.5, changecodeBtn.bottom+15, SCREEN_WIDTH-245, 20);
//    }
//    if (SCREEN_WIDTH == 320){
//        instructionsImageBtn.frame = CGRectMake(95, changecodeBtn.bottom+15, SCREEN_WIDTH-190, 20);
//    }
    
    [instructionsImageBtn setBackgroundImage:[UIImage imageNamed:@"saoma_Help"] forState:UIControlStateNormal];
    [_readview addSubview:instructionsImageBtn];
    [instructionsImageBtn addTarget:self action:@selector(showInstructionImage) forControlEvents:UIControlEventTouchUpInside];
    [instructionsImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(changecodeBtn.mas_bottom_mas).with.offset(15);
        make.width.equalTo(@(260/2));
        make.height.equalTo(@(40/2));
        make.centerX.equalTo(_readview.mas_centerX_mas);
        
    }];
}

- (void)configureCodeView{
    
    backView = [[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:backView];
    
    CGFloat width = 220;
    CGFloat height = 220;
    codeImage = [[UIImageView alloc]init];
    codeImage.frame = CGRectMake((SCREEN_WIDTH-220)/2, 40, width, height);
    [backView addSubview:codeImage];
    
//    logoImage = [[UIImageView alloc]init];
//    logoImage.frame = CGRectMake((codeImage.width/2)-20, (codeImage.height/2)-20, 40, 40);
//    [codeImage addSubview:logoImage];
    
    UILabel *amoutLable = [[UILabel alloc]init];
    amoutLable.text =  [NSString stringWithFormat:@"¥:%@",self.payModel.amount];
    amoutLable.textColor = [UIColor orangeColor];
    amoutLable.textAlignment = NSTextAlignmentCenter;
    amoutLable.font = [UIFont systemFontOfSize:20];
    amoutLable.frame = CGRectMake(0, codeImage.bottom+10, SCREEN_WIDTH, 30);
    [backView addSubview:amoutLable];
    
    
    UILabel *promptLable = [[UILabel alloc]init];
    if ([self.payModel.payType isEqualToString:@"2"]) {
        promptLable.text =  @"请使用微信扫一扫完成付款";
    } else {
        promptLable.text =  @"请使用支付宝扫一扫完成付款";
    }
    promptLable.textColor = [UIColor blackColor];
    promptLable.textAlignment = NSTextAlignmentCenter;
    promptLable.font = [UIFont systemFontOfSize:16];
    promptLable.frame = CGRectMake(0, amoutLable.bottom+5, SCREEN_WIDTH, 30);
    [backView addSubview:promptLable];
    
    changeZBarBtn = [[UIButton alloc]init];
//    if (SCREEN_WIDTH == 414) {
//        changeZBarBtn.frame = CGRectMake(96.5, promptLable.bottom+15, SCREEN_WIDTH-193, 60);
//    }
//    if (SCREEN_WIDTH == 375) {
//        changeZBarBtn.frame = CGRectMake(114, promptLable.bottom+15, SCREEN_WIDTH-228, 40);
//    }
//    if (SCREEN_WIDTH == 320){
//        changeZBarBtn.frame = CGRectMake(86.5, promptLable.bottom+15, SCREEN_WIDTH-173, 40);
//    }
//
    [changeZBarBtn setBackgroundImage:[UIImage imageNamed:@"saoma_qiehuan_pre"] forState:UIControlStateNormal];
    [changeZBarBtn addTarget:self action:@selector(changeToScanPay) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:changeZBarBtn];
    [changeZBarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(promptLable.mas_bottom_mas).with.offset(15);
        make.width.equalTo(@(294/2));
        make.height.equalTo(@(80/2));
        make.centerX.equalTo(backView.mas_centerX_mas);
        
    }];
    
    codeinstructionsImageBtn = [[UIButton alloc]init];
//    if (SCREEN_WIDTH == 414) {
//        codeinstructionsImageBtn.frame = CGRectMake(105, changeZBarBtn.bottom+15, SCREEN_WIDTH-210, 30);
//    }
//    if (SCREEN_WIDTH == 375) {
//        codeinstructionsImageBtn.frame = CGRectMake(122.5, changeZBarBtn.bottom+15, SCREEN_WIDTH-245, 20);
//    }
//    if (SCREEN_WIDTH == 320) {
//        codeinstructionsImageBtn.frame = CGRectMake(95, changeZBarBtn.bottom+15, SCREEN_WIDTH-190, 20);
//    }
    [codeinstructionsImageBtn setBackgroundImage:[UIImage imageNamed:@"saoma_Help1"] forState:UIControlStateNormal];
    [backView addSubview:codeinstructionsImageBtn];
    [codeinstructionsImageBtn addTarget:self action:@selector(showInstructionImage) forControlEvents:UIControlEventTouchUpInside];
    [codeinstructionsImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(changeZBarBtn.mas_bottom_mas).with.offset(15);
        make.width.equalTo(@(260/2));
        make.height.equalTo(@(40/2));
        make.centerX.equalTo(backView.mas_centerX_mas);
        
    }];
    
    backView.hidden = YES;
}

#pragma mark - ZBarReaderViewDelegate
// 扫描二维码的时候，识别成功会进入此方法，读取二维码内容
- (void) readerView: (ZBarReaderView*) readerView didReadSymbols: (ZBarSymbolSet*) symbols fromImage: (UIImage*) image {
    // 停止扫描
    [self setZBarReaderViewStop];
    ZBarSymbol *symbol = nil;
    for (symbol in symbols) {
        break;
    }
    [self parsingQRCodeWithUrl:symbol.data];
}

#pragma mark - ZBar Manager
// 打开二维码扫描视图ZBarReaderView
- (void)setZBarReaderViewStart {
    _readview.torchMode = 0;    // 关闭闪光灯
    [_readview start];          // 开始扫描二维码
    [_qrRectView startScan];
}


// 关闭二维码扫描视图ZBarReaderView
- (void)setZBarReaderViewStop {
    _readview.torchMode = 0;    // 关闭闪光灯
    [_readview stop];           // 关闭扫描二维码
    [_qrRectView stopScan];
}


#pragma mark - Private Methods
- (void)parsingQRCodeWithUrl:(NSString *)url {
    
    // 扫描结果异常处理
    if(url == nil || url.length <= 0) {
        
        // 二维码内容解析失败
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"扫描失败" message:nil preferredStyle:UIAlertControllerStyleAlert];
        WEAKSELF();
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定"
                                                         style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                                                             // 重新扫描
                                                             [weakSelf setZBarReaderViewStart];
                                                         }];
        
        [alertVC addAction:action];
        [self presentViewController:alertVC animated:YES completion:^{
            
        }];
        return;
    }
    
    NSLog(@"扫描成功！%@", url);
    // 18位订单号
    NSString *regex = @"^[0-9]{18}$";
    // 创建谓词对象并设定条件的表达式
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    // 判断的字符串
    // 对字符串进行判断
    if ([predicate evaluateWithObject:url]) {
        [self scansuccessToPayWithAuthno:url];
    } else {
        [[QPHUDManager sharedInstance] showTextOnly:@"不是支付的二维码"];
    }
}

// 切换到生成二维码支付
- (void)changePayType{
    
    _readview.hidden = YES ;
    [self setZBarReaderViewStop];
    backView.hidden = NO;
    self.isStop = YES;
//    if (!codeImage.image) {
        [self getQRCodetoPay];
//    }
}

//  切换到扫码刷卡支付
- (void)changeToScanPay{
    
    _readview.hidden = NO;
    // 开始扫描
    [self setZBarReaderViewStart];
    self.isStop = NO;
    backView.hidden = YES;
}

-(void)showInstructionImage
{
    self.navigationController.navigationBarHidden = YES;
    [changecodeBtn setUserInteractionEnabled:NO];
    [instructionsImageBtn setUserInteractionEnabled:NO];
    [changeZBarBtn setUserInteractionEnabled:NO];
    [codeinstructionsImageBtn setUserInteractionEnabled:NO];
    
    instructionImage = [[UIImageView alloc]initWithFrame:self.view.bounds];
    if ([self.payModel.payType isEqualToString:@"2"]) {
    instructionImage.image = backView.hidden ? [UIImage imageNamed:@"zhinan_saoke"]: [UIImage imageNamed:@"kehusaoma_shuoming"];
    } else {
    instructionImage.image = backView.hidden ? [UIImage imageNamed:@"zhinan"]: [UIImage imageNamed:@"kehusaoma-2"];
    }
    [self.view addSubview:instructionImage];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    instructionImage.hidden = YES;
    self.navigationController.navigationBarHidden = NO;
    [changecodeBtn setUserInteractionEnabled:YES];
    [instructionsImageBtn setUserInteractionEnabled:YES];
    [changeZBarBtn setUserInteractionEnabled:YES];
    [codeinstructionsImageBtn setUserInteractionEnabled:YES];

}

// 刷卡支付
- (void)scansuccessToPayWithAuthno:(NSString*)authno{
    [[QPHUDManager sharedInstance]showProgressWithText:@"正在支付"];
    [QPHttpManager creditCardPaymentByScanString:self.payModel.amount PayTye:self.payModel.payType Authno:authno Completion:^(id responseData) {
        [[QPHUDManager sharedInstance]hiddenHUD];
        if ([[responseData objectForKey:QP_ResponseCode] isEqualToString:QP_Response_SuccsessCode]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                _readview.hidden = YES ;
                [self setZBarReaderViewStop];
                [[QPHUDManager sharedInstance]showProgressWithText:@"支付结果回调中"];
                // 生成订单号 就循环请求订单状态  成功跳支付结果回调界面  用户看到的就是成功界面
                self.orderId = [responseData objectForKey:@"order_sn"];
                [self orderqueryWithOrderId:self.orderId];
                
             });
        } else {
            [[QPHUDManager sharedInstance]showTextOnly:[responseData objectForKey:@"resp_msg"]];
         }
        
    } failure:^(NSError *error) {
        
        [[QPHUDManager sharedInstance]hiddenHUD];
        [[QPHUDManager sharedInstance]showTextOnly:error.localizedDescription];
        
    }];
}

// 生成二维码支付
- (void)getQRCodetoPay{
    
    [[QPHUDManager sharedInstance]showProgressWithText:@"正在努力生成二维码"];
    [QPHttpManager getQRcodeString:self.payModel.amount PayTye:self.payModel.payType Completion:^(id responseData) {
        [[QPHUDManager sharedInstance]hiddenHUD];
        if ([[responseData objectForKey:QP_ResponseCode] isEqualToString:QP_Response_SuccsessCode]) {
            dispatch_async(dispatch_get_main_queue(), ^{
            self.orderId = [responseData objectForKey:@"order_sn"];
            codeImage.image = [QRCodeGenerator qrImageForString:[responseData objectForKey:@"barCode"] imageSize:220];
            // 生成订单号 就循环请求订单状态  成功跳支付结果回调界面  用户看到的就是成功界面
            [self orderqueryWithOrderId:self.orderId];
//            if ([self.payModel.payType isEqualToString:@"1"]) {
//                    logoImage.image = [UIImage imageNamed:@"zhifubao"];
//                } else {
//                    logoImage.image = [UIImage imageNamed:@"weixin"];
//                }
            });
        } else {
            [[QPHUDManager sharedInstance]showTextOnly:[responseData objectForKey:@"resp_msg"]];
        }
    } failure:^(NSError *error) {
        [[QPHUDManager sharedInstance]hiddenHUD];
        [[QPHUDManager sharedInstance]showTextOnly:error.localizedDescription];
    }];
}

- (void)showPayResultVC{

    QPQrderQueryViewController *payResultVC = [[QPQrderQueryViewController alloc]init];
    payResultVC.payModel = self.payModel;
    payResultVC.payModel.orderId = self.orderId;
    [self.navigationController pushViewController:payResultVC animated:YES];
}

// 生成订单号 就循环请求订单状态  成功跳支付结果回调界面  用户看到的就是成功界面
- (void)orderqueryWithOrderId:(NSString*)orderId
{
    [QPHttpManager orderquery:orderId Completion:^(id responseData) {
        if ([[responseData objectForKey:QP_ResponseCode] isEqualToString:QP_Response_SuccsessCode]) {
            [[QPHUDManager sharedInstance]hiddenHUD];
            [self showPayResultVC];
        } else {
            [self performSelector:@selector(circulateRequest) withObject:nil afterDelay:1];
        }
    }failure:^(NSError *error) {
           [self performSelector:@selector(circulateRequest) withObject:nil afterDelay:1];
           [[QPHUDManager sharedInstance]hiddenHUD];
//        [[QPHUDManager sharedInstance]showTextOnly:error.localizedDescription];
        
    }];
}

- (void)circulateRequest{
    if (self.isStop ) {
        [self orderqueryWithOrderId:self.orderId];

    }
    // 超过一分钟
//    time++;
//    if (time > 300) {
////        if (!backView.hidden) {
//        [[QPHUDManager sharedInstance]showProgressWithText:@"该二维码已失效"];
//        backView.hidden = YES;
//        [[QPHUDManager sharedInstance]hiddenHUD];
//        [self.navigationController popToRootViewControllerAnimated:YES];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"resetDigitalKeyboard" object:nil];
//
////            [self getQRCodetoPay];
////        }
//    } else {
//    }
}
@end
