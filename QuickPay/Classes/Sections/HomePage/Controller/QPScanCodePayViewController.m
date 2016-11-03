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

@interface QPScanCodePayViewController ()<ZBarReaderViewDelegate>
{
    ZBarReaderView *_readview;          // 扫描二维码ZBarReaderView
    QPQRView *_qrRectView;             // 自定义的扫描视图
}

@end

@implementation QPScanCodePayViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleToNavBar:@"扫一扫"];
    [self createBackBarItem];
    [self configuredZBarReader];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 开始扫描
    [self setZBarReaderViewStart];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 停止扫描
    [self setZBarReaderViewStop];
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
    
    [[QPHUDManager sharedInstance]showTextOnly:[NSString stringWithFormat:@"扫描结果：11111%@",url]];
    NSLog(@"扫描成功！%@", url);
     if (![url containsString:@"meetingserver/scanning"]) {
         [[QPHUDManager sharedInstance] showTextOnly:@"不是微信支付的二维码"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setZBarReaderViewStart];
        });
        return;
    }
    // 扫描正常处理
    
}


@end
