//
//  QPDigitalKeyboardView.m
//  QuickPay
//
//  Created by Nie on 2016/11/1.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPDigitalKeyboardView.h"

@interface QPDigitalKeyboardView()
@property (nonatomic,strong)UILabel *amountLable;
@property (nonatomic,strong)UIButton *aliPayBtn;
@property (nonatomic,strong)UIButton *weixinPayBtn;
@property (nonatomic,strong)NSMutableString *amountStr;//钱的数目

@end

@implementation QPDigitalKeyboardView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureSubViews];
        self.amountStr = [[NSMutableString alloc] initWithString:@""];
    }
    return self;
}

#pragma mark - configureSubViews
- (void)configureSubViews
{
    UIView *menbanView = [[UIView alloc]initWithFrame:self.bounds];
    menbanView.backgroundColor = [UIColor blackColor];
    menbanView.alpha = 0.8;
    [self addSubview:menbanView];
    
    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-30-15, 35, 22, 22)];
    [closeBtn setImage:[UIImage imageNamed:@"shoukuan_fanhui"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(hidekeyboard) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    
    UIView * amounBackView = [[UIView alloc]initWithFrame:CGRectMake(15, 64, SCREEN_WIDTH-30, 49)];
    amounBackView.layer.cornerRadius = 5.0f;
    amounBackView.layer.masksToBounds = YES;
    amounBackView.backgroundColor = [UIColor whiteColor];
    [self addSubview:amounBackView];
    
    self.amountLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, amounBackView.width-30, amounBackView.height)];
    self.amountLable.textColor = [UIColor textBlack];
    self.amountLable.text = @"输入收款金额";
    self.amountLable.font = [UIFont systemFontOfSize:16];
    self.amountLable.textAlignment = NSTextAlignmentRight;
    self.amountLable.backgroundColor = [UIColor clearColor];
    [amounBackView addSubview:self.amountLable];
    
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.frame = CGRectMake(0, SCREEN_HEIGHT-250, SCREEN_WIDTH, 250);
    [self addSubview:bottomView];
    
    CGFloat width = SCREEN_WIDTH/3;
    CGFloat height = 50;
    NSArray *nubArray = @[@[@"1",@"2",@"3"],@[@"4",@"5",@"6"],@[@"7",@"8",@"9"],@[@".",@"0",@""]];
    for (int i = 0; i<4; i++) {
        NSArray *titleArray = nubArray[i];
        for (int j = 0; j< 3; j++) {
            
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(j*width, i*height, width, height)];
            [btn setTitle:titleArray[j]  forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:20];
            btn.tag = 300 + 10 * i + j;
            if (btn.tag == 332) {
                [btn setImage:[UIImage imageNamed:@"shoukuan_shanchujian"] forState:UIControlStateNormal];
            }
            [btn addTarget:self action:@selector(btnClicck:) forControlEvents:UIControlEventTouchUpInside];
            [bottomView addSubview:btn];
        }
        
    }
    
    //两条竖分割线
    for (int i=0; i<2; i++) {
        UILabel *vLineLabel = [[UILabel alloc] initWithFrame:CGRectMake((i+1) * width, 0, 0.5, height*4)];
        vLineLabel.backgroundColor = UIColorFromHex(0xdddddd);
        [bottomView addSubview:vLineLabel];
    }
    
    //四条横分割线
    for (int j=0; j<4; j++) {
        UILabel *vLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (j+1)*height, SCREEN_WIDTH, 0.5)];
        vLineLabel.backgroundColor = UIColorFromHex(0xdddddd);
        [bottomView addSubview:vLineLabel];
    }
    
    // 底部支付宝和微信支付按钮
    self.aliPayBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, height*4, width, height)];
    [self.aliPayBtn addTarget:self action:@selector(aliPayBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:self.aliPayBtn];
    
    self.weixinPayBtn = [[UIButton alloc]initWithFrame:CGRectMake(width, height*4, width*2, height)];
    [self.weixinPayBtn addTarget:self action:@selector(weixinPayBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:self.weixinPayBtn];
    
    [self setAliPayBtnAndWeixinPayBtn];
    
}
// 键盘按钮点击事件
- (void)btnClicck:(UIButton*)btn{
    
    switch (btn.tag) {
        case 300:case 301:case 302:
        case 310:case 311:case 312:
        case 320:case 321:case 322:
            if ([NSString isBlank:self.amountStr]) {
                [self.amountStr appendString:btn.titleLabel.text];
                [self changAmoutLabAndPayBtnStatus];
            } else{
                if ([self digitCheck]) {
                    [self.amountStr appendString:btn.titleLabel.text];
                    [self changAmoutLabAndPayBtnStatus];
                }
            }
            break;
        case 330:
            if ([NSString isBlank:self.amountStr]) {
                [self.amountStr appendString:@"0."];
                [self changAmoutLabAndPayBtnStatus];
            } else if ([self.amountStr containsString:@"."]) {
                return;
            } else {
                [self.amountStr appendString:btn.titleLabel.text];
                [self changAmoutLabAndPayBtnStatus];
            }
            break;
        case 331:
            if ([NSString isBlank:self.amountStr]) {
                [self.amountStr appendString:@"0."];
                [self changAmoutLabAndPayBtnStatus];
            } else {
                if ([self digitCheck]) {
                    [self.amountStr appendString:btn.titleLabel.text];
                    [self changAmoutLabAndPayBtnStatus];
                }
            }
            break;
        case 332:
            if ([NSString isBlank:self.amountStr]) {
                return;
            } else {
                if ([self.amountStr isEqualToString:@"0."]) {
                    self.amountStr = [NSMutableString stringWithFormat:@""];
                    [self changAmoutLabAndPayBtnStatus];
                } else {
                    NSString *tempStr = [self.amountStr substringToIndex:self.amountStr.length-1];
                    self.amountStr = [NSMutableString stringWithFormat:@"%@",tempStr];
                    [self changAmoutLabAndPayBtnStatus];
                }
            }
            break;
            
        default:
            break;
    }
}

// 改变金额lab的内容 和支付按钮的状态
- (void)changAmoutLabAndPayBtnStatus{
    if (self.amountStr.length) {
        self.amountLable.text = [NSString stringWithFormat:@"¥ %@",self.amountStr];
        if ([self.amountStr floatValue] >0) {
            [self changeAliPayBtnAndWeixinPayBtn];
        } else {
            [self setAliPayBtnAndWeixinPayBtn];
        }
    } else {
        self.amountLable.text = @"输入收款金额";
        [self setAliPayBtnAndWeixinPayBtn];
    }
}
// 有金钱 支付按钮状态变为可点击
- (void)changeAliPayBtnAndWeixinPayBtn{
    
    self.aliPayBtn.enabled = YES;
    self.weixinPayBtn.enabled = YES;
    [self.aliPayBtn setImage:[UIImage imageNamed:@"shoukuanzfb_pre"] forState:UIControlStateNormal];
    [self.weixinPayBtn setImage:[UIImage imageNamed:@"shoukuanweixin_pre"] forState:UIControlStateNormal];
}
// 输入内容无或者为0 支付按钮不可点击
- (void)setAliPayBtnAndWeixinPayBtn{
    self.aliPayBtn.enabled = NO;
    self.weixinPayBtn.enabled = NO;
    [self.aliPayBtn setImage:[UIImage imageNamed:@"shoukuanzfb_nor"] forState:UIControlStateNormal];
    [self.weixinPayBtn setImage:[UIImage imageNamed:@"shoukuanweixin_nor"] forState:UIControlStateNormal];
}
// 只支持到10万位和分   所以小数点前6位 小数点后2位
- (BOOL)digitCheck{
    NSArray *array = [self.amountStr componentsSeparatedByString:@"."];
    if (array.count == 1) {
        NSString *intAmount = array[0];
        if (intAmount.length >=6) {
            return NO;
        }
    } else if (array.count == 2) {
        NSString *floatAmount = array[1];
        if (floatAmount.length >=2) {
            return NO;
        }
    }
    return YES;
}
// 点击关闭按钮
- (void)hidekeyboard{
    if (self.delegate && [self.delegate respondsToSelector:@selector(closeBtnClickDelegate)]) {
        [self.delegate closeBtnClickDelegate];
    }
}
// 点击支付宝支付
- (void)aliPayBtnClick:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(payBtnClickDelegate:amoumt:)]) {
        [self.delegate payBtnClickDelegate:AlipayType amoumt:self.amountStr];
    }
}

// 点击微信支付
- (void)weixinPayBtnClick:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(payBtnClickDelegate:amoumt:)]) {
        [self.delegate payBtnClickDelegate:WeiXinPayType amoumt:self.amountStr];
    }
}

@end
