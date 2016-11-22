//
//  QPAboutUsViewController.m
//  QuickPay
//
//  Created by Nie on 2016/11/5.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPAboutUsViewController.h"

@interface QPAboutUsViewController ()

@end

@implementation QPAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleToNavBar:@"关于我们"];
    [self createBackBarItem];
    [self configureView];

}

#pragma mark - configureSubViews
-(void)configureView
{
    self.view.backgroundColor = UIColorFromHex(0xefefef);
    UIImageView *logoImage=[[UIImageView alloc] init];
    logoImage.frame = CGRectMake((SCREEN_WIDTH-284/2)/2,15 , 284/2, 164/2);
    logoImage.image = [UIImage imageNamed:@"logo.png"];
    [self.view addSubview:logoImage];
    
    UILabel * aboutusLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, logoImage.bottom+15, SCREEN_WIDTH-40, 300)];
    NSString * desText = @"北京人人购电子商务有限公司坐落于国家级科技园区奥运村科技园，因规模扩大，搬迁于北京市顺义区旭辉空港，作为高新技术认证企业，是一家高科技数字现代化企业，致力于线下电子金融、移动便民支付、便民线下受理服务网点和便民智能服务终端的网点网络的推广，为互联网用户和商户提供“安全、便捷、稳定”的便民服务，是中国线下便利电子商务的领航者。北京人人购愿意与合作伙伴分享自身多年的运营经验和广大优质用户，共同推动移动便民终端的繁荣发展。中付宝是银联商务、数字王府井、银商支付、人人购共同研发的一款便民智能服务终端。2014年布局全国七大区域将便民的触角延伸到全国各地，设立华北、东北、西北、华中、华东、华南、西南七大战区。各战区所属省份设立分公司或办事处。";
    aboutusLabel.text = desText;
    aboutusLabel.font = [UIFont systemFontOfSize:16];
    aboutusLabel.lineBreakMode = NSLineBreakByTruncatingHead;
    aboutusLabel.numberOfLines = 0;
    CGSize contanSize = CGSizeMake(280, 400);
    CGRect autoRect = [desText boundingRectWithSize:contanSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:aboutusLabel.font} context:nil];
    aboutusLabel.frame = CGRectMake(20, logoImage.bottom+15, SCREEN_WIDTH-40, autoRect.size.height);
    [self.view addSubview:aboutusLabel];
}

@end
